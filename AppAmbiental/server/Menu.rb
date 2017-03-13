class Menu

  #Listar os clientes que estão ‘ligados’ e a sua respetiva localização.
  #Listar os valores lidos de um determinado sensor, sendo fornecido como parâmetro um identificador único do cliente.
  attr_reader :optionListarOnline, :optionListarSensor, :optionSair

  @@optionListarOnline = 1
  @@optionListarSensor = 2
  @@optionSair = 3

  def initialize( input, output)
    @input = input
    @output = output
  end


  def menu_geral
    @output.puts "----------------------------Menu----------------------------"
    @output.puts " #{@@optionListarOnline} - Listars clientes online;"
    @output.puts " #{@@optionListarSensor} - Listar valores lidos de um sensor ( ? - ID );"
    @output.puts " #{@@optionSair} - Sair"
    @output.puts "------------------------------------------------------------"
    @output.print " => "
    return @input.gets.strip.to_i
  end

  def requestID
    @output.puts " Introduza o ID do cliente "
    @output.print " => "
    begin
      id = Integer(@input.gets.strip)
    rescue ArgumentError
      @output.puts " Introduza um ID valido "
      @output.print " => "
      retry
    end
    return id
  end

  def errorComand
    @output.puts "Comando nao existe"
  end


  def displayAllOnline( list )
    list.each { |item|
      @output.puts "ID: #{item[:id]}; GPS: #{item[:gps][:lat]}º #{item[:gps][:lon]}º"
    }
  end

  def displayLeiturasSensor( list )
    list.each { |item|
      @output.puts "ID: #{item[:id]}; Type: #{item[:type]}; Value: #{item[:value]}; Timestamp: #{item[:timestamp]}; GPS: #{item[:gps][:lat]}º #{item[:gps][:lon]}º"
    }
  end


  def display_Menu( functions )
    @functions = functions

    loop {
      case menu_geral

      when @@optionListarOnline
          displayAllOnline @functions[@@optionListarOnline-1].call

        when @@optionListarSensor
          displayLeiturasSensor @functions[@@optionListarSensor-1].call( requestID )

        when @@optionSair
          @output.close
          break

        else
          errorComand
      end
    }
  end

end
