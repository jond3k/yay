
class Yay
  # installs .yay files from a remote url in to either ~/.yay or /etc/yay
  # depending on the users permissions
  class Installer
    def initialize(url)
        @url = url
    end
    
    def install
      raise "installing files is not yet implemented! :-("
    end
  end
end
