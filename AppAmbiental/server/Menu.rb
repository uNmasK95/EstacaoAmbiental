module Menu

  #Listar os clientes que estão ‘ligados’ e a sua respetiva localização.
  #Listar os valores lidos de um determinado sensor, sendo fornecido como parâmetro um identificador único do cliente.

  @@optionListarOnline = "1"
  @@optionListarSensor = "2"
  @@optionSair = "3"

  def Menu.menu_geral
    puts "----------------------------Menu----------------------------"
    puts " #{@@optionListarOnline} - Listars clientes online;"
    puts " #{@@optionListarSensor} - Listar valores lidos de um sensor ( ? - ID );"
    puts " #{@@optionSair} - Sair"
    puts "------------------------------------------------------------"
    print " => "
    return $stdin.gets.strip
  end

  def Menu.requestID
    puts " Introduza o ID do cliente "
    print " => "
    begin
      id = Integer($stdin.gets.strip)
    rescue ArgumentError
      puts " Introduza um ID valido "
      print " => "
      retry
    end
    return id
  end


  def Menu.errorComand
    puts "Comando nao existe"
  end


  def Menu.displayAllOnline( list )
    list.each { |item|
      puts "ID: #{item[:id]}; GPS: #{item[:gps][:lat]}º\t#{item[:gps][:lon]}"
    }
  end

  def Menu.displayLeiturasSensor( list )
    list.each { |item|
      puts "ID: #{item[:id]};\tType: #{item[:type]};\tValue: #{item[:value]};\tTimestamp: #{item[:timestamp]};\tGPS: #{item[:gps][:lat]}º #{item[:gps][:lon]}"
    }
  end

  def Menu.display_for_page( list, n)

  end

end
