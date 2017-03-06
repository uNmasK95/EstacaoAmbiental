require 'socket'
require_relative 'menu'
require_relative 'clientWorker'
require_relative '../server/leituras_dao.rb'
require_relative '../server/users_dao.rb'

class Server
  include Menu

  def initialize(port)
    @server = TCPServer.open port
    @leituras = LeiturasDAO.new
    @users = UsersDAO.new
  end

  def start()

    Thread.new{
      loop do
        Thread.start( @server.accept ) do  | client |

          worker = ClientWorker.new( client )
          worker.run

        end
      end
    }
    display_Menu
  end


  def listarOnline
    Menu.displayAllOnline( @users.getAllOn )
  end

  def listarSensorClient( id )
    Menu.displayLeiturasSensor( @leituras.getAllById( id ) )
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
