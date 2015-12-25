require 'net/http'

class Jobs::Forecast

  def perform
    URL = "http://api.openweathermap.org/data/2.5/forecast?q=stockholm,sv&APPID=3b469cf40bdcb8533020c9b5c25cdda9"
    response = Net::HTTP.get_response(URI.parse(URL))
    data = response.body
    result = JSON.parse(data)
  end

end
