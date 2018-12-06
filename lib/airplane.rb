class Airplane
  attr_reader :type, :wing_loading, :horsepower, :fuel
  attr_writer :started
  def initialize(type, wing_loading, horsepower, fuel = 1000)
    @type = type
    @wing_loading = wing_loading
    @horsepower = horsepower
    @started = false
    @landed = true
    @fuel = fuel
  end

  def start
    if @started
      'Airplane already started'
    else
      if @fuel <= 1
        'Airplane needs more fuel to start'
      else
        @started = true
        @fuel -= 1
        'Airplane started'
      end
    end
  end

  def takeoff
    if @started && @landed
      if @fuel <= 30
        'Not enough fuel to take off'
      else
        @landed = false
        @fuel -= 20
        'Airplane launched'
      end
    elsif !@started
      'Airplane not started, please start'
    else
      'Airplane in the air already'
    end
  end

  def land
    if @started && @landed
      'Airplane already on the ground'
    elsif @started && !@landed
      @fuel -= 10
      'Airplane landed'
    else
      'Airplane not started, please start'
    end
  end

  def miles_left
    @fuel * 5
  end

  def flyto(distance)
    if (distance / 5 + 10) >= @fuel
      'Not enough fuel to make it'
    else
      @fuel -= distance / 5
      'The airplane made the distance'
    end
  end
end
