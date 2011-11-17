require 'rubygems'
require './lib/yay/version'
task :default => :test

version   = Yay::VERSION
spec_file = "yay.gemspec"
gem_file  = "yay-#{version}.gem"

desc "build gem"
task :gem do
	sh "gem build #{spec_file}"
end

desc "install gem"
task :install => [:gem] do
	sh "gem install #{gem_file} --no-rdoc --no-ri"
end

desc "uninstall gem"
task :uninstall do
	sh "rake uninstall yay"
end

desc "run tests"
task :test do
  Dir.chdir("test") { sh "ruby all.rb" }
end

desc "rebuild grammar"
task :racc do
  Dir.chdir("scripts") { sh "bash generate-grammar.sh" }
end

desc "build yay"
task :build => [:racc, :test, :gem] do
	
end
