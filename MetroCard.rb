require_relative "MetroCardClassMethods"

class MetroCard    
  @@collection ={"CENTRAL"=>{"cost"=>0,"discount"=>0,"passengers"=>[]},"AIRPORT"=>{"cost"=>0,"discount"=>0,"passengers"=>[]}}
  @@vertex = {};
  @@station_from = {"CENTRAL"=>"AIRPORT","AIRPORT"=>"CENTRAL"}
    
  def initialize(item)  
    @travel_history =  {}  
    @metro_id = item["metro_id"] 
    @station = item["station"]
    @passenger_type = item["passenger_type"]  
    @destination = @@station_from[@station] 
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
    def vertex
      @@vertex
    end
    def _station
      @@station&.keys&.first
    end
    def _destination
      @@station&.values&.first&.keys&.first
    end
    def _passenger_type
      @@station&.values&.first&.values&.first["passenger_type"]
    end
    def _is_return_journey(trip_from)
      trip_from[_destination] && _passenger_type === trip_from[_destination]["passenger_type"] && trip_from[_destination]["complete"] == false
    end  
    include MetroCardClassMethods
  end
  
  def self.total_amount_collected(card_list) 
    @@vertex.each do |metro_id, travel_history| 
      result = find_amount_collected_for_metrocard(card_list[metro_id], travel_history)     
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
