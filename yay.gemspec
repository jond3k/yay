$:.unshift(File.dirname(__FILE__) + '/lib')

Gem::Specification.new do |s|
  s.name         = 'yay'
  s.version      = '0.0.2'

  s.platform     = Gem::Platform::RUBY
  s.summary      = "Makes your logs colourful!"
  s.authors      = ["Jon Davey"]
  s.email        = "jond3k@gmail.com"
  s.homepage     = "http://github.com/jond3k/yay"

  s.bindir       = "bin"
  s.executables  = %w(yay)

  s.require_path = 'lib'
  s.files        = %w(LICENSE) + Dir.glob("{data,lib}/**/*")

end
