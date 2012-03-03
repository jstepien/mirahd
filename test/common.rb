require 'rspec'
require 'fileutils'

Source = 'test/hello.mirah'
BadSource = 'Gemfile.lock'
JavaFile = 'test/Hello.java'
ClassFile = 'test/Hello.class'

def rm_f_temp_files
  [JavaFile, ClassFile].each { |file| FileUtils.rm_f file }
end
