require 'socket'

class ClientWorker

  def initialize( client, id )
    @ID = id
    @client = client
    @data = DataDAO
  end

  def receive()

    loop {
      line = @client.gets
      fields = line.split(";")



    }

  end

end
