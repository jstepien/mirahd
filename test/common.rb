$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'
require 'fileutils'
require 'socket'

Source = 'test/hello.mirah'
BadSource = 'Gemfile.lock'
ClassFile = 'Hello.class'

def rm_f_temp_files
  [ClassFile].each { |file| FileUtils.rm_f file }
end

# This function tries to connect to a given TCP port and close the socket
# immediately after getting connected. If TCPSocket#new raises an error it
# means that the port is free and we can begin testing.
#
# This function prevents spurious Errno::EADDRINUSE errors which happened from
# time to time when the port didn't get completely freed before proceeding to
# a next test.
def wait_for_the_port_to_become_free port
  while true
    begin
      TCPSocket.new('localhost', port).close
    rescue
      return
    end
    sleep 0.1
  end
end
