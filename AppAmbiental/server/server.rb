require 'socket'
require_relative 'Menu'

class Server
  include Menu

  def initialize(port)
    @server = TCPServer.open port
    @online = Hash.new

  end

  def start()

    Thread.new{

      loop do
        Thread.start( @server.accept ) do | client |
          #ver como calcular o id
          begin
            worker = ClientWorker.new(client,id)
            @online[c.ID] = worker
            c.receive
          rescue IOError
            @online.delete(c.ID)
          end
        end
      end
    }


    display_Menu

  end


  def listarOnline
    puts "ainda vou fazer o listar online"
  end

  def listarSensorClient( id )
    puts "ainda vou fazer o listar sensor"
  end

  def display_Menu
    loop {
      case Menu.menu_geral

      when @@optionListarOnline
          listarOnline

        when @@optionListarSensor
          listarSensorClient( Menu.requestID )

        when @@optionSair
          break

        else
          Menu.errorComand

      end

    }
  end

end






s = Server.new 12346
s.start
