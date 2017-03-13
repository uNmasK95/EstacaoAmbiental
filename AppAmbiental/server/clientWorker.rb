require 'socket'
require_relative 'leituras_dao'
require_relative 'users_dao'

class ClientWorker

  def initialize(client)
    @client = client
    @leituras = LeiturasDAO.new
    @users = UsersDAO.new

  end

  def handshake
    begin
      id = @client.gets.to_i

      if @users.containsUser(id) then
        @id = id
        @users.updateState(@id,"ON")
        @client.puts "#{@id}"
      else
        @id = @users.countUsers+1
        @users.insert(@id,-1,-1,"ON")
        @client.puts "#{@id}"
      end

      $stdout.puts "O client xdk com o id: #{@id} estabeleceu conexao"
    rescue IOError
      #TODO ver o que fazer aqui
      #Thread.current[:stop] = true
    end
  end


  def receiveFristPack
    fields = @client.gets.strip.split(";")
    @frist_timestamp = fields[2].to_i
    updateSaveData( @id, fields[0], fields[1].to_f.round(2), fields[2].to_i, fields[3].to_f.round(4), fields[4].to_f.round(4) )
  end

  def receiveData
    receiveFristPack
    loop {
      fields = @client.gets.strip.split(";")
      updateSaveData( @id, fields[0], fields[1].to_f.round(2), fields[2].to_i, fields[3].to_f.round(4), fields[4].to_f.round(4) )
    }
  end

  def updateSaveData( id, type, value, timestamp, lat, lon )
    @leituras.insert( id, type, value, timestamp, lat, lon )
    @users.updateGPS( id, lat, lon )
  end

  def run()
    handshake()
    begin
      receiveData
    rescue Exception
      n = @leituras.countByCon( @id, @frist_timestamp )
      @users.updateState( @id, "OFF")
      $stdout.puts "O client xdk com o id: #{@id} terminou a sua conexao com o registo de #{n} leituras"
    end
  end

private :handshake, :receiveFristPack, :receiveData, :updateSaveData

end
