require 'net/http'
require 'net/https'
require 'uri'
require 'yay/paths'
require 'fileutils'

class Yay
  # installs .yay files from a remote url in to either ~/.yay or /etc/yay
  # depending on the users permissions
  class Installer

    # initialize an installer for the specified url. the .install method will
    # attempt the actual installation process
    def initialize file_name, url
      # directories to iterate. begin with /etc/yay, which should only be
      # accessible to sudo. then try a local install.
      paths     = Yay::Paths.new
      validate_filename file_name
      @file_name = append_filetype file_name
      @dirs = [
        paths.global_yay_path,
        paths.local_yay_path
      ]
      @url = url
    end
    
    # some filenames just aren't a good idea
    def validate_filename string
      raise BadFilenameError.new string if /[\?\*\\\/]/.match(string)
    end
    
    # add the .yay part to the filename if it's missing
    def append_filetype string
      return "#{string}.yay" unless /\.yay$/.match(string)
      return string
    end

    # see if we can write to a directory. will try to create the folder (and 
    # its parents) unless asked otherwise
    def can_write_to_dir dir, create

        begin
          stat = File.stat(dir)
          return true if stat && stat.writable?
        rescue Errno::ENOENT
        end

        # create and try again if it doesn't exist
        if create
          begin
            FileUtils.mkdir_p dir
            #FileUtils.chmod 0644, dir 
            result = can_write_to_dir dir, false
            puts "Created #{dir}" if result
            return result
          rescue Errno::EACCES
          end
        end

        return false
    end
    
    # try to find the install directory
    def get_install_directory
      # search globally and then locally to see if we can write
      @dirs.each { |dir| 
        return dir if can_write_to_dir dir, true
      }
      return nil
    end
        
    # make a curl-ish request and get the contents
    def get_remote_string url, limit=5
      raise  InstallFailedError.new url, 'HTTP redirect too deep' if limit == 0

      begin
        puts "Requesting #{url}"
        url = URI.parse(url)

        request = Net::HTTP::Get.new(url.path || '/')
        
        http    = Net::HTTP.new url.host, url.port
        #http.set_debug_output($stderr)
        http.use_ssl = url.scheme == 'https' 

        response     = http.start { |http2| 
          http2.request(request)
        }

      rescue StandardError => error
        raise InstallFailedError.new url, error.to_s
      end
      
      case response
        when Net::HTTPSuccess then 
          return response.body
        when Net::HTTPRedirection then
          puts "Redirecting to #{response['location']}"; 
          return get_remote_string(response['location'], limit - 1)
      end

      raise InstallFailedError.new url, "#{response.code} \"#{response.message}\"", response.body
    end
    
    # ensure the rules we've downloaded parse correctly
    def verify_rules url, string
      begin
        parser = Yay::Parser.new
        parser.parse(string)
      rescue Yay::Error => error
        raise InstallFailedError.new url, error.printable_message, string
      end
      raise InstallFailedError.new url, "No rules in downloaded file", string if parser.get_rules == []
      return parser
    end
    
    # store a string 
    def install_string string, dest_folder
      dest = "#{dest_folder}/#{@file_name}"
      File.open(dest, 'w') {|file|
        file.write(string)
      }
      puts "#{ColourWheel::success}Installed to #{dest}#{ColourWheel::end_colour}"
    end
    
    # attempt the installation process
    def install
      dest_folder = get_install_directory
      raise "Couldn't write to or create directories #{@dirs.join(' or ')} something is up with your system!" unless dest_folder
      string = get_remote_string @url
      verify_rules @url, string
      install_string string, dest_folder
    end
  end
end
