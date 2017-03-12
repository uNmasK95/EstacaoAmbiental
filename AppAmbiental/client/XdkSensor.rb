module XdkSensor

  def initialize
    @temperatura = rand(10.0..35.0).round(1)
    @ruido = rand(50.0...140.0).round(1)
  end

  def getTemperatura
    if [true,false].sample then
      @temperatura += rand(0..0.5).round(1)
    else
      @temperatura -= rand(0..0.5).round(1)
    end
  end

  def getRuido
    if [true,false].sample then
      @ruido += rand(1.0..10.0).round(2)
    else
      @ruido -= rand(1.0..10.0).round(2)
    end
  end

end