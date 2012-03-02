require 'drb/drb'
require 'fileutils'

module MirahD
  class Client
    URI = 'druby://localhost:8787'

    def compile args
      DRbObject.new_with_uri(URI).compile args, FileUtils.pwd
    end
  end
end
