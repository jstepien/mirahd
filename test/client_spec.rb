require 'test/common'
require 'mirahd/server'
require 'mirahd/client'

describe MirahD::Client do
  before :all do
    @server = MirahD::Server.new
    @server.start
  end

  after :all do
    @server.stop
  end

  before do
    @client = MirahD::Client.new
  end

  it 'can compile to Java source code' do
    @client.compile(['--java', Source]).should == true
    File.file?(JavaFile).should == true
    FileUtils.rm_f JavaFile
  end

  it 'can compile a JVM class' do
    @client.compile([Source]).should == true
    File.file?(ClassFile).should == true
    FileUtils.rm_f ClassFile
  end
end
