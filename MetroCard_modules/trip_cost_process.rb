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
    def process_trip_segment(trip_to,trip_leg,current_station)
        trip_to[_station] ||= {} 
        trip_to[_station]["passenger_type"] = _passenger_type;  
        trip_to[trip_leg]["complete"] =  trip_to[trip_leg]["complete"]==nil ?  false : !trip_to[trip_leg]["complete"]  
        trip_to[current_station]["passenger"]||=[]
        trip_to[current_station]["passenger"].push(_passenger_type);          
    end

end
