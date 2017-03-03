require_relative "../users_dao"

d = UsersDAO.new

d.insert(6,-40,-200,"ON")
d.updateGPS(2,20,-10)
d.updateState(4,"OFF")
puts d.containsUser 6

puts d.countUsers
