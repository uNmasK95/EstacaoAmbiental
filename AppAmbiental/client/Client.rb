require 'socket'

class Client

  def initialize( hostname, port)
    @hostname = hostname
    @port = port
  end

  def start
    s = TCPSocket.open(@hostname, @port)

    while line = s.gets   # Read lines from the socket
      puts line.chop      # And print with platform line terminator
    end

  end
end


c = Client.new 'localhost', 12346
c.start
