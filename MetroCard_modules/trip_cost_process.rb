module Process_trip_change_and_discount
    def passenger_tarif_for (&passenger_type)            
        if trip_complete_status   
            trip_from[_station]['discount'] =  (passenger_type.call()/2).to_i   
            (passenger_type.call()/2).to_i
        else
            trip_from[_station]['discount']= 0
            passenger_type.call().to_i           
        end         
    end
    
    def get_trip_complete_status(&trip_is_return_type)          
        trip_from[_station]["complete"] = trip_is_return_type.call()        
    end

    def process_total_trip_cost(&trip_cost)        
       trip_from[_station]["trip_cost"] +=  trip_cost.call()        
    end    
        
    def process_balance_recharge_cost (&effective_cost)       
        trip_from[_station]["trip_cost"] +=  (effective_cost.call()*ProcessTrip::TRIP_COST_PERCENTAG).to_i        
    end    

    def process_trip_segment(trip_leg)     
        trip_from[_station] ||= {} 
        trip_from[_station]["trip_cost"]||=0;
        trip_from[_station]["passenger_type"] = _passenger_type;          
        trip_from[_station]["passenger"]||=[]
        trip_from[_station]["passenger"].push(_passenger_type);         
        trip_from[trip_leg]["complete"] = get_trip_complete_status {trip_leg!=_station}    
        process_total_trip_cost { passenger_tarif_for {ProcessTrip::TRIP_FARE[_passenger_type]} }   
    end

end
