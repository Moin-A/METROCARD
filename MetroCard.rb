require_relative "MetroCardClassMethods"
require 'pry'
class MetroCard <  MetroCardClassMethods
  attr_accessor :travel_history, :station, :destination , :station_from, :station, :collection 
  def initialize(item)
    super  
    self.add_passenger
  end    

  def add_passenger  
    @@vertex[@metro_id] ||= []
    @travel_history[@station] ||= {}
    @travel_history[@station][@destination] ||= {}
    @travel_history[@station][@destination]["passenger_type"] = @passenger_type
    @@vertex[@metro_id].push(@travel_history)
  end
  
end 
