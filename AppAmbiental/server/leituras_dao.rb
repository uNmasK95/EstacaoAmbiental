# Class que permite realizar operações sobre a coleção leituras da base de dados
#
require 'mongo'

class LeiturasDAO

  Mongo::Logger.logger.level = ::Logger::FATAL

  # Contrutor da class LeiturasDAO
  #
  def initialize
    @db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
  end



  # Description of method
  #
  # @param [Fixnum] sensorID describe sensorID
  # @param [String] sensorType describe sensorType
  # @param [Fixnum] value describe value
  # @param [Fixnum] timestamp describe timestamp
  # @param [Fixnum] gps_lat describe gps_lat
  # @param [Fixnum] gps_lon describe gps_lon
  # @return [nil]
  def insert( sensorID, sensorType, value, timestamp, gps_lat, gps_lon)
    leitura = {
        :_id => {
            :id => sensorID,
            :timestamp => timestamp,
            :type => sensorType
        },
        :value => value,
        :gps => {
            :lat => gps_lat,
            :lon => gps_lon
        }
    }
    #@db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
    @db[:leituras].insert_one(leitura)
    #@db.close
  end

  # Metodo que oferece a funcionalidade de fazer drop da coleção leituras
  #
  # @return [nil]
  def drop
    #@db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
    @db[:leituras].drop
    #@db.close
  end

  # O metodo getAllByID recolhe todas as leituras realizadas
  #
  # @param [Type] id describe id
  # @return [Type] description of returned object
  def getAllById( id )
    result = Array.new
    #@db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
    @db[:leituras].find( {"_id.id" => id }
    ).each { |leitura|
      result.push(
        {
          :id => leitura["_id"]["id"],
          :type => leitura["_id"]["type"],
          :timestamp => leitura["_id"]["timestamp"],
          :value => leitura["value"],
          :gps => {
            :lat =>leitura["gps"]["lat"],
            :lon =>leitura["gps"]["lon"]
          }
        }
      )
    }
    #@db.close
    return result
  end


  def getLastLocationById( id )
      value = nil
      #@db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
      @db[:leituras].find({"_id.id" => id }).sort({"_id.timestamp" => -1 }).each { |last|
        value = last["gps"]["lat"] , last["gps"]["lon"]
        break
      }
      #@db.close
      return value
  end


  def countByCon( id, frist_timestamp)
    #@db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
    value = @db[:leituras].find({
      :$and => [
        { "_id.id" => id },
        { "_id.timestamp" => { :$gte => frist_timestamp}}
      ]
    }).count()
    #@db.close
    return value
  end

end
