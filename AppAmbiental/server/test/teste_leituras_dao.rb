require_relative "../leituras_dao"

d = LeiturasDAO.new
d.insert(2,"ruido",5.2,Time.now.to_i, 58.1, -200)
d.getAllById(2).each { |e| puts e  }
puts d.countByCon(2,1488555126)
