$:.unshift(File.dirname(__FILE__) + '/lib')

sandbox = Module.new
sandbox.module_eval(IO.read(File.expand_path('lib/yay/version.rb')))

Gem::Specification.new do |s|
  s.name         = 'yay'
  s.version      = sandbox::Yay::VERSION

  s.platform     = Gem::Platform::RUBY
  s.summary      = "makes your logs colourful!"
  s.authors      = ["jon davey"]
  s.email        = "jond3k@gmail.com"
  s.homepage     = "http://github.com/jond3k/yay"

  s.bindir       = "bin"
  s.executables  = %w(yay)

  s.require_path = 'lib'
  s.files        = %w(LICENSE) + Dir.glob("{data/yay,lib}/**/*")

end
