require 'drb/drb'
require 'stringio'
require 'mirah'

module MirahD
  class Server
    class Compiler
      def compile args, dir = FileUtils.pwd
        result = ''
        FileUtils.cd dir do
          orig_stdout = $stdout
          $stdout = StringIO.new 'w'
          Mirah::Commands::Compile.new(args).execute
          result = $stdout.string
          $stdout = orig_stdout
        end
        result
      end
    end

    URI = 'druby://localhost:8787'

    def start
      DRb.start_service URI, Compiler.new
      true
    end

    def stop
      raise 'The server has not been started yet' unless running?
      DRb.stop_service
      true
    end

    def wait
      DRb.thread.join if running?
      true
    end

    def running?
      not DRb.thread.nil? and DRb.thread.alive?
    end
  end
end
