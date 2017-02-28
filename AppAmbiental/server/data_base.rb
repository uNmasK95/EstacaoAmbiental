
require 'mongo'

class LeituraDAO

  Mongo::Logger.logger.level = ::Logger::FATAL

  def initialize()
    @client = Mongo::Client.new(['127.0.0.1:27017'])
    @db = @client.use("test")

    @db[:leituras].insert_one(
      { :id => 2, :name => "teste"}
    )
  end

end



LeituraDAO.new
