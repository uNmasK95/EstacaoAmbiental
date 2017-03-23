require 'mongo'

class UsersDAO

  @@stateON = "ON"
  @@stateOFF = "OFF"

  Mongo::Logger.logger.level = ::Logger::FATAL

  def initialize
    @db = Mongo::Client.new(['127.0.0.1:27017'] , :database => 'xdkAmbiente' )
  end

  def insert( sensorID, gps_lat, gps_lon, state)
    user = {
        :_id => sensorID,
        :gps => {
          :lat => gps_lat,
          :lon => gps_lon
        },
        :state => state
    }
    @db[:users].insert_one user
  end

  def dropColletion
    @db[:users].drop
  end

  def createColletion
    Mongo::Collection.new(@db, 'users')
  end

  def updateState( id, state )
    @db[:users].update_one( {:_id => id } , :$set => { :state => state } )
  end

  def updateAllState( state )
    @db[:users].update_many({}, :$set => { :state => state } )
  end

  def updateGPS( id, gps_lat, gps_lon )
    @db[:users].update_one( {:_id => id } ,
      :$set => {
        :gps => {
          :lat => gps_lat,
          :lon => gps_lon
          }
      }
    )
  end

  def containsUser id
    return [false,true][@db[:users].find( { :_id => id } ).count]
  end

  def getAllOn

    result = Array.new

    @db[:users].find( {:state => "ON" }
    ).each { |user|
      result.push(
        {
          :id => user["_id"],
          :gps => {
            :lat => user["gps"]["lat"],
            :lon => user["gps"]["lon"]
          }
        }
      )
    }
    return result
  end


  def countUsers
    return @db[:users].find().count
  end

end
