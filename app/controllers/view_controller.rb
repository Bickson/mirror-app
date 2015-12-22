class ViewController < ApplicationController
  #layout proc {|controller| controller.request.xhr? ? false: "application" }

  def index
    @msg = "hello"
    @time =  Time.now.strftime('%T')
  end

  def time_widget
    @time = Time.now.strftime('%T')
    @date = Time.now.strftime('%Y-%m-%d')
    #render :file => "/view/time_widget"
    render layout: false
  end

end
