require 'net/http'

class Forecast

  class ListObj
    attr_reader :icon, :desc, :date, :temp, :wind_dir
    def initialize(icon, desc, date, temp, wind_dir)
      @icon = icon
      @desc = desc
      @date = date
      @temp = temp
      @wind_dir = wind_dir
    end
  end

  def initialize
    #@data = data
    @list = list
  end

  def data
    @data ||= fetch_json
  end

  def fetch_json
    source = "http://api.openweathermap.org/data/2.5/forecast?q=stockholm&units=metric&APPID=#{ENV['WEATHER_API_KEY']}"
    response = Net::HTTP.get_response(URI.parse(source))
    data = response.body
    result = JSON.parse(data)
  end

  def list
    array = []
    # Calls method data, if @data is loaded it will not fetch again
    data["list"].each do |cast|
      array << ListObj.new(
                      cast["weather"].first["icon"],
                      cast["weather"].first["description"],
                      DateTime.parse(cast["dt_txt"]),
                      cast["main"]["temp"],
                      direction(cast["wind"]["deg"])
                      )
    end
    array
  end

  #=======================================================================#
  #======================= Data sanitize methods =========================#
  #=======================================================================#

  def direction degree
    val = ((degree/22.5)+0.5).to_i
    arr = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    arr[(val % 16)]
  end




# Cardinal Direction	Degree Direction
# N 348.75 - 11.25
# NNE 11.25 - 33.75
# NE 33.75 - 56.25
# ENE 56.25 - 78.75
# E 78.75 - 101.25
# ESE 101.25 - 123.75
# SE 123.75 - 146.25
# SSE 146.25 - 168.75
# S 168.75 - 191.25
# SSW 191.25 - 213.75
# SW 213.75 - 236.25
# WSW 236.25 - 258.75
# W 258.75 - 281.25
# WNW 281.25 - 303.75
# NW 303.75 - 326.25
# NNW 326.25 - 348.75


end
