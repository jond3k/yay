require 'yay/paths'

class Yay
  # Lists installed .yay files
  # See also: Rimmer, Cat
  class Lister

    # returns [[name, path],..]
    def get_files_in_dir dir
      results = []
      Dir.glob("#{dir}/*.yay").each { |path| 
        matches = /\/(\w*)?\.yay$/.match(path)
        if matches[1]
          results.unshift [matches[1], path]
        else
          puts "Eh.. #{path} isn't quite right"
        end
      }
      return results
    end
    
    # returns {dir=>[file,..]
    def get_all_files
      paths  = Yay::Paths.new
      result = {}
      paths.yay_paths.each { |path| 
        result[path] = get_files_in_dir path
      }
      return result
    end
    
    # print the search paths we'll use when looking for yay files
    def print_paths
      puts "Search paths: (in order of precedence)"
      paths = Yay::Paths.new
      paths.yay_paths.each { |dir| 
        puts dir
      }
    end
    
    # print the files we can use and the command that can be typed to use it
    def print_files
      puts "Installed styles:"
      get_all_files.each_pair { |dir, files| 
        #puts "#{dir}:"
        files.each { |file| 
          puts "#{file[0]}#{' '*(20-file[0].length)}#{file[1]}"
        }
      }      
    end
    
    # print all paths and files we find in them
    def print
      print_paths
      puts
      print_files
    end
  end
end