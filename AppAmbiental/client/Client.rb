require 'socket'
require_relative "XdkSensor.rb"

class Client

  include XdkSensor

  def initialize( hostname, port, id)
    @hostname = hostname
    @port = port
    @id = id
    @latitude = rand(-90.0..90.0)
    @longitude = rand(-180.0..180)
    super()
  end

  def start

    socket = TCPSocket.open(@hostname, @port)

    socket.puts("#{@id}")

    puts "Client ID: #{socket.gets}"

    Thread.new{
      loop do
        socket.write("ruido;#{getRuido};#{Time.now.to_i};#{@latitude};#{@longitude}\n")
        sleep(1)
      end
    }

    Thread.new {
      loop do
        socket.write("temperatura;#{getTemperatura};#{Time.now.to_i};#{@latitude};#{@longitude}\n")
        sleep(30)
      end
    }.join

  end

end



if __FILE__ == $PROGRAM_NAME

  c = Client.new ARGV[0], ARGV[1].to_i, ARGV[2]
  c.start

end
