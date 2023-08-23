require_relative 'MetroCard_modules/trip_station_helper.rb'
require_relative 'MetroCard_modules/trip_cost_process.rb'
class ProcessTrip < MetroCardClassMethods
        include Trip_station_helper  
        include Process_trip_change_and_discount
        attr_accessor :travel_history, :station, :destination 

    def initialize
       
    end


    def total_amount_collected    
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



    def update_balace_aumount(balance_details,trip_to,trip_complete)
        effective_tarif = trip_complete ? passenger_tarif_for(_passenger_type) / 2 : passenger_tarif_for(_passenger_type)
        trip_to['discount']= effective_tarif if trip_complete
        trip_to['discount']= 0 if !trip_complete
        if balance_details["balance"].to_i < effective_tarif
        effective_trip_cost = effective_tarif  - balance_details["balance"].to_i
        trip_to["trip_cost"] +=  effective_trip_cost*0.02
        balance_details["balance"] = 0;
        else
        balance_details["balance"] =  balance_details["balance"].to_i - effective_tarif
        end      

    end
    

    def find_amount_collected_for_metrocard(balance_details, trip_info)    
        
        trip_from={}
        trip_info.each do |station, destination| 
            binding.pry    
             @station = station             
            if _is_return_journey(trip_from)    
                process_trip_segment(trip_from,_destination,_station)   
                trip_from[_station]["trip_cost"] = (passenger_tarif_for(_passenger_type) * 0.5 ).to_i   
                update_balace_aumount(balance_details, trip_from[_station], true); 
                
                else               
                process_trip_segment(trip_from,_station,_station)       
                trip_from[_station]["trip_cost"] = (trip_from[_station]["trip_cost"] || 0) + passenger_tarif_for(_passenger_type)          
                update_balace_aumount(balance_details, trip_from[_station], false);  

            end              
        end    
        return  trip_from        

    end   
end     
