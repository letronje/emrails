class UsersController < ApplicationController
  def show
    #Rails.logger.info params
    Rails.logger.ap "about to enter event loop"
    EM.run do
      Rails.logger.ap "creating new fiber"
      Fiber.new do
        Rails.logger.ap "executing in fiber"
        Net::HTTP.start('www.google.com') do |http|
          Rails.logger.ap "GETing via Net::HTTP"
          res = http.get('/search?q=manoj')
          Rails.logger.ap "THIS NEVER GETS PRINTED, WHY??"
          render :text => res.body    
        end      
        EM.stop_event_loop
      end.resume
      Rails.logger.ap "after creating new fiber"
    end
    Rails.logger.ap "event loop exited"
    render :text => :blah
  end
end
