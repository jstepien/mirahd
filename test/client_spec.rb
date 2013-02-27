require 'test/common'
require 'mirahd/server'
require 'mirahd/client'

describe MirahD::Client do
  before :all do
    wait_for_the_port_to_become_free 8787
    @server = MirahD::Server.new
    @server.start
  end

  after :all do
    @server.stop
  end

  before do
    @client = MirahD::Client.new
  end

  after do
    rm_f_temp_files
  end

  it 'can compile a JVM class' do
    @client.compile([Source]).should_not be_nil
    File.file?(ClassFile).should == true
  end

  it 'receives compiler\'s standard output' do
    @client.compile([Source]).should =~ /^Parsing.*Inferring.*Done!$/m
  end

  describe 'after failed compilation' do
    it 'receives an exception' do
      lambda { @client.compile([BadSource]) } .should raise_error StandardError
    end

    it 'receives error messages' do
      begin
        @client.compile([BadSource])
      rescue => ex
        ex.message.should =~ /^Parsing\..*#{BadSource}.*\n1 errors?, exiting/m
      end
    end
  end
end
