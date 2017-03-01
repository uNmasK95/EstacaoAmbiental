module XdkSensor

  def initialize
    @temperatura = rand(10.0..35.0)
    @ruido = rand(50.0...140.0)
  end

  def getTemperatura
    if [true,false].sample then
      @temperatura += rand(0..0.5)
    else
      @temperatura -= rand(0..0.5)
    end
  end

  def getRuido
    if [true,false].sample then
      @ruido += rand(1.0..10.0)
    else
      @ruido -= rand(1.0..10.0)
    end
  end

end