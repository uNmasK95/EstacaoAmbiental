require 'socket'
require_relative 'menu'
require_relative 'clientWorker'
require_relative '../server/leituras_dao.rb'
require_relative '../server/users_dao.rb'

class Server

  def initialize( portClient, portTelnet)
    @server = TCPServer.open portClient
    @telnet = TCPServer.open portTelnet
    @leituras = LeiturasDAO.new
    @users = UsersDAO.new

    puts "Server listening clients on #{portClient}"
    puts "Server listening telnet on #{portTelnet}"
  end

  def start
    @users.updateAllState("OFF")
    # disponibilizar conexao para os clientes
    Thread.new{
      loop do
        Thread.start( @server.accept ) do  | client |
          worker = ClientWorker.new( client )
          worker.run
        end
      end
    }

    # disponibilizar as queries pedidas
    loop{
      Thread.start( @telnet.accept ) do  | client |
        menu = Menu.new(client, client)
        menu.display_Menu ([method(:listarOnline), method(:listarSensorClient)])
      end
    }
  end

  def listarOnline
    return @users.getAllOn
  end

  def listarSensorClient( id )
    return @leituras.getAllById( id )
  end

end


if __FILE__ == $PROGRAM_NAME
  s = Server.new ARGV[0], ARGV[1]
  s.start
end
