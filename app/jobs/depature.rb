require 'net/http'

class Depature

  def initialize
    @data = data
  end

  def data
    @data ||= fetch_json
  end

  def fetch_json
    source = "http://api.sl.se/api2/realtimedepartures.json?key=#{ENV['SL_REALTIME_INFO_KEY']}&siteid=9163&timewindow=60"
    response = Net::HTTP.get_response(URI.parse(source))
    data = response.body
    result = JSON.parse(data)
  end

  def buses
    data["ResponseData"]["Buses"]
  end

  def metros
    data["ResponseData"]["Metros"]
  end

end
