require 'drb/drb'
require 'stringio'
require 'mirah'

module MirahD
  class Server
    class Compiler
      def compile args, dir = FileUtils.pwd
        intercepting_stdout do
          FileUtils.cd dir do
            Mirah::Commands::Compile.new(args).execute
          end
        end
      end

      private

      def intercepting_stdout
        orig_stdout = $stdout
        $stdout = StringIO.new 'w'
        yield
      rescue Exception => ex
        new_ex = StandardError.new $stdout.string
        new_ex.set_backtrace ex.backtrace
        raise new_ex
      else
        $stdout.string
      ensure
        $stdout = orig_stdout
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
