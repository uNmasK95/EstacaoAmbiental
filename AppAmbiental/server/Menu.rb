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
    return gets.strip
  end

  def Menu.requestID
    puts " Introduza o ID do cliente "
    print " => "
    begin
      id = Integer(gets.strip)
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

end
