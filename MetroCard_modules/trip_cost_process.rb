module Process_trip_change_and_discount
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
    
    def get_trip_complete_status(&trip_is_return_type)          
        trip_from[_station]["complete"] = trip_is_return_type.call()        
    end
        

    def process_trip_segment(trip_leg)       
        trip_from[_station] ||= {} 
        trip_from[_station]["trip_cost"]||=0;
        trip_from[_station]["passenger_type"] = _passenger_type;          
        trip_from[_station]["passenger"]||=[]
        trip_from[_station]["passenger"].push(_passenger_type);         
        trip_from[trip_leg]["complete"] = get_trip_complete_status {trip_leg!=_station}
        # trip_from[trip_leg]["complete"] =  trip_from[trip_leg]["complete"]==nil ?  false : !trip_from[trip_leg]["complete"]         
    end

end
