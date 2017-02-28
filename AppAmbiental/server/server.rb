require 'socket'

class Server

  def initialize(port)

    @server = TCPServer.open port

  end

  def start()

    Thread.new{
      loop do
        Thread.start( @server.accept ) do | client |
          print "new connection"
          client.puts(Time.now.ctime)  # Send the time to the client
          client.puts "Closing the connection. Bye!"
          client.close                 # Disconnect from the client
        end

      end
    }

  end

end

s = Server.new 12346
s.start
