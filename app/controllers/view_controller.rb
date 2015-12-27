class ViewController < ApplicationController

  def index
    @msg = "hello"
    @time =  Time.now.strftime('%T')
  end

  def time_widget
    @date = Time.now + 1.hour #to fit timezone on heroku
    @time = @date.strftime('%H:%M')
    render layout: false
  end

  def weather_widget
    @forecast = Forecast.new
    @current = @forecast.list.first
    #to get all next day
    @list = @forecast.list.select{|f| f.date >= @forecast.list.first.date.beginning_of_day.next_day}

    #filter kl 09 and kl 18
    @list = @list.select{|f| f.date.hour == 9 || f.date.hour == 18}
    render layout: false
  end

  def depature_widget
    @buses = []
    @metros = []
    if DateTime.now.hour >= ENV['START_HOUR'].to_i && DateTime.now.hour < ENV['STOP_HOUR'].to_i
      @bus_h2 = "Buses"#"Bussar"
      @metro_h2 = "Metro"#"Tunnelbana"
      @depatures = Depature.new
      @buses = @depatures.buses
      @metros = @depatures.metros.select{ |m| m["JourneyDirection"] == 1} #only towards the city
    end
    render layout: false
  end

end
