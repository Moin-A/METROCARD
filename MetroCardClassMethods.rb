module MetroCardClassMethods
    
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