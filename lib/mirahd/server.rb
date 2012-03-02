require 'drb/drb'
require 'mirah'

module MirahD
  class Server
    class Compiler
      def compile args, dir = FileUtils.pwd
        FileUtils.cd dir do
          Mirah::Commands::Compile.new(args).execute
        end
        true
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
