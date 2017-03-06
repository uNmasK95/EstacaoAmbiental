require 'socket'
require 'leituras_dao'
require 'users_dao'

class ClientWorker

  def initialize(client)
    $stdout.puts "iniciar"
    @client = client
    @leituras = LeituraDAO.new
    @users = UsersDAO.new

  end

  def handshake
    puts "ola1"

    begin
      puts "ola"
      id = @client.gets.to_i

      puts "#{id}"

      if @users.containsUser(id) then
        @id = id
        @users.updateState(@id,"ON")
        @client.puts "#{@id}"
      else
        @id = @users.countUsers+1
        @users.insert(@id,-1,-1,"ON")
        @client.puts "#{@id}"
      end

      puts "O client xdk com o id: #{@id} estabeleceu conexao"
    rescue IOError
      #TODO ver o que fazer aqui
      #Thread.current[:stop] = true
    end
  end


  def receiveFristPack
    line = @client.gets
    fields = line.split(";")

    @frist_timestamp = fields[2].to_i

    updateSaveData( @id, fields[0], fields[1].to_i, fields[2].to_i, fields[3].to_i, fields[4].to_i )
  end

  def receiveData
    receiveFristPack
    loop {
      line = @client.gets
      fields = line.split(";")

      updateSaveData( @id, fields[0], fields[1].to_i, fields[2].to_i, fields[3].to_i, fields[4].to_i )
    }
  end


  def updateSaveData( id, type, value, timestamp, lat, lon )
    @leituras.insert( id, type, value, timestamp, lat, lon )
    @users.updateGPS( @id, fields[3].to_i, fields[4].to_i )
  end


  def run()
    puts "um"
    handshake()

    begin
      receiveData
    rescue IOError
      n = @leituras.countByCon( @id, @timestamp )
      @users.updateState( @id, "OFF")
      puts "O client xdk com o id: #{@id} terminou a sua conexao com o registo de #{n} leituras"
    end
  end


private :handshake, :receiveFristPack, :receiveData, :updateSaveData

end
