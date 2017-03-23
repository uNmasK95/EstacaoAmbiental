require 'socket'
require_relative "XdkSensor.rb"

class Client

  include XdkSensor

  def initialize( hostname, port, id, latitude, longitude)
    @hostname = hostname
    @port = port
    @id = id
    @latitude = latitude
    @longitude = longitude
    #@latitude = rand(-90.0..90.0)
    #@longitude = rand(-180.0..180)
    super()
  end

  def start

    begin
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

    rescue Errno::ECONNREFUSED
      puts "No connection to server"
    end

  end

end



if __FILE__ == $PROGRAM_NAME

  c = Client.new ARGV[0], ARGV[1].to_i, ARGV[2], ARGV[3], ARGV[4]
  c.start

end
