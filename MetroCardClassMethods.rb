class MetroCardClassMethods
  @@collection ={"CENTRAL"=>{"cost"=>0,"discount"=>0,"passengers"=>[]},"AIRPORT"=>{"cost"=>0,"discount"=>0,"passengers"=>[]}}
  @@vertex = {};
  @@station_from = {"CENTRAL"=>"AIRPORT","AIRPORT"=>"CENTRAL"}
  @@station = []
  @@card_list = []

  def initialize(item)
    @travel_history =  {}  
    @metro_id = item["metro_id"] 
    @station = item["station"]
    @passenger_type = item["passenger_type"]  
    @destination = @@station_from[@station] 
  end
 
    class << self    
        def card_list=(item)
          @@card_list = item         
        end 
         
        def passenger_tarif_for (passenger_type)
            case passenger_type
            when "ADULT"
              200
            when "SENIOR_CITIZEN"
              100 
            when "KID"
              50
            else  
              0
            end
        end   

        def process_trip_segment(trip_to,trip_leg,current_station)
            trip_to[_station] ||= {} 
            trip_to[_station]["passenger_type"] = _passenger_type;  
            trip_to[trip_leg]["complete"] =  trip_to[trip_leg]["complete"]==nil ?  false : !trip_to[trip_leg]["complete"]  
            trip_to[current_station]["passenger"]||=[]
            trip_to[current_station]["passenger"].push(_passenger_type);          
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
        def reset_class_variables
          @@vertex = {};
          @@collection ={"CENTRAL"=>{"cost"=>0,"discount"=>0,"passengers"=>[]},"AIRPORT"=>{"cost"=>0,"discount"=>0,"passengers"=>[]}}
        end
    
   end 

end