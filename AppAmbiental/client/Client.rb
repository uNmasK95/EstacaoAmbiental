require 'socket'
require_relative "XdkSensor.rb"

class Client

  include XdkSensor

  def initialize( hostname, port)
    @hostname = hostname
    @port = port
    @latitude = rand(-90.0..90.0)
    @longitude = rand(-180.0..180)
    super()
  end

  def start

    socket = TCPSocket.open(@hostname, @port, @id)

    # Thread Ruido  Colocar uma Thread para o ruido com => valor;Timestamp;gps;
    Thread.new{
      loop do
        puts"#{getRuido};#{Time.now.to_i};#{@latitude}:#{@longitude};"
        sleep(1)
      end
    }

    # Thread Temperatura   Colocar uma Thread para a Temperatura com => valor;Timestamp;gps;
    Thread.new {
      loop do
        puts"#{getTemperatura};#{Time.now.to_i};#{@latitude}:#{@longitude};"
        sleep(30)
      end
    }.join

    #O gps tem latitude e longitude exemplo => 99.70:-73.9893;

  end
end


c = Client.new 'localhost', 12346
c.start
