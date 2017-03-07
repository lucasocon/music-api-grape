require 'open-uri'

module Helpers
  class IO
    def self.copy_remote_to_temp remote_uri, temp_name = 'templocal'
      remote_file = open(remote_uri)
      file = Tempfile.new(temp_name)
      # Tempfile will assume text file unless we switch to binary
      file.binmode
      file << remote_file.read
      file.rewind
      file
    end
  end
end
