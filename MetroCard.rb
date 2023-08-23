require_relative "MetroCardClassMethods"
require 'pry'
class MetroCard <  MetroCardClassMethods
  attr_accessor :travel_history, :station, :destination 
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

  class << self      
     def update_balace_aumount(balance_details,trip_to,trip_complete)
        effective_tarif = trip_complete ? passenger_tarif_for(_passenger_type) / 2 : passenger_tarif_for(_passenger_type)
        trip_to['discount']= effective_tarif if trip_complete
        trip_to['discount']= 0 if !trip_complete
       if   balance_details["balance"].to_i < effective_tarif
        effective_trip_cost = effective_tarif  - balance_details["balance"].to_i
        trip_to["trip_cost"] +=  effective_trip_cost*0.02
        balance_details["balance"] = 0;
       else
        balance_details["balance"] =  balance_details["balance"].to_i - effective_tarif
       end      
      end 
  end
  
  def self.total_amount_collected 
    @@vertex.each do |metro_id, travel_history| 
      result = find_amount_collected_for_metrocard(@@card_list[metro_id], travel_history)     
      result.each do |key,value| 
        @@collection[key]["cost"]+=value["trip_cost"];
        @@collection[key]["discount"]+=value["discount"];   
        @@collection[key]["passengers"]+=value["passenger"];     
      end
     
    end
    return @@collection
  end

  def self.find_amount_collected_for_metrocard(card_list, trip_info)    
    trip_from={}
    trip_info.each do |station, destination| 
      @@station = station             
      if _is_return_journey(trip_from)    
        process_trip_segment(trip_from,_destination,_station)   
        trip_from[_station]["trip_cost"] = passenger_tarif_for(_passenger_type) * 0.5    
        update_balace_aumount(card_list, trip_from[_station], true); 
      
      else               
        process_trip_segment(trip_from,_station,_station)       
        trip_from[_station]["trip_cost"] = (trip_from[_station]["trip_cost"] || 0) + passenger_tarif_for(_passenger_type)          
        update_balace_aumount(card_list, trip_from[_station], false);  

      end           
    end    

  return  trip_from
  end    
end 
