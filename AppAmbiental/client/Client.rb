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

    puts socket.gets

    # Thread Ruido  Colocar uma Thread para o ruido com => valor;Timestamp;gps;
    Thread.new{
      loop do
        puts "ruido"
        socket.write("ruido;#{getRuido};#{Time.now.to_i};#{@latitude};#{@longitude}\n")
        sleep(1)
      end
    }

    # Thread Temperatura   Colocar uma Thread para a Temperatura com => valor;Timestamp;gps;
    Thread.new {
      loop do
        puts "temperatura"
        socket.write("temperatura;#{getTemperatura};#{Time.now.to_i};#{@latitude};#{@longitude}\n")
        sleep(30)
      end
    }.join

    #O gps tem latitude e longitude exemplo => 99.70:-73.9893;

  end

end


puts "Insira o ID:"
b = gets.chomp.to_i

c = Client.new 'localhost', 12346, b

c.start
