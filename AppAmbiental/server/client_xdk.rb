require 'socket'

class ClientXDK

  def initialize( client, id )
    @client = client
  end

  def comunication()
    client.readline()
    client.send("#{@id}")
    client.readline
  end

end



c = ClientXDK.new("teste")

print c.instance_variable_get(:client)
print c.instance_variable_get(:t)

print c.instance_variable_set(:client, "ola")

print c.instance_variable_get(:client)
