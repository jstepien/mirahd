require 'test/common'
require 'drb/drb'
require 'mirahd/server'

describe MirahD::Server do
  before do
    @server = MirahD::Server.new
  end

  it 'can be started and stopped' do
    @server.start.should == true
    @server.stop.should == true
  end

  it 'is not running by default' do
    @server.running?.should == false
  end

  it 'knows when it is stopped' do
    @server.start
    @server.stop
    @server.running?.should == false
  end

  it 'cannot be stopped before being started' do
    lambda { @server.stop } .should raise_error
  end

  describe 'when online' do
    before do
      @server.start
      @remote = DRbObject.new_with_uri 'druby://localhost:8787'
    end

    after do
      @server.stop if @server.running?
      rm_f_temp_files
    end

    it 'knows that it is running' do
      @server.running?.should == true
    end

    it 'cannot be started once again' do
      lambda { @server.start } .should raise_error
    end

    it 'listens on port 8787' do
      @remote.should respond_to :object_id
    end

    it 'responds to compile' do
      @remote.should respond_to :compile
    end

    it 'the #wait method should keep it running' do
      # FIXME: busy waiting is considered evil.
      failed = false
      thr = Thread.start do
        @server.wait
        failed = @server.running?
      end
      sleep 0.1 until @server.running?
      @server.stop
      thr.join
      failed.should == false
    end

    describe 'and given a valid input file' do
      it 'should compile it to Java' do
        @remote.compile(['--java', Source]).should == true
        File.file?(JavaFile).should == true
      end

      it 'should compile it to a JVM class' do
        @remote.compile([Source]).should == true
        File.file?(ClassFile).should == true
      end
    end

    describe 'and given an invalid input file' do
      source = 'Gemfile.lock'

      it 'should fail' do
        lambda { @remote.compile [BadSource] } .should raise_error
      end

      it 'should not be killed after handling it' do
        lambda { @remote.compile [BadSource] } .should raise_error
        @remote.should respond_to :compile
      end
    end
  end
end
