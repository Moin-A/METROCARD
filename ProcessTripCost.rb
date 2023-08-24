require_relative 'MetroCard_modules/trip_station_helper.rb'
require_relative 'MetroCard_modules/trip_cost_process.rb'
class ProcessTrip < MetroCardClassMethods
    include Process_trip_change_and_discount   
    include Trip_station_helper  
       
        attr_accessor :travel_history, :station, :destination , :collection, :trip_complete_status, :trip_from
        TRIP_COST_PERCENTAG = 0.02
        RETURN_TRIP_DISCOUNT = 0.5
        TRIP_FARE = {"ADULT"=>200,"SENIOR_CITIZEN"=>100,"KID"=>50}
          
        
        
    def initialize
        @collection ={"CENTRAL"=>{"cost"=>0,"discount"=>0,"passengers"=>[]},"AIRPORT"=>{"cost"=>0,"discount"=>0,"passengers"=>[]}}
        @trip_complete_status = false     
        @trip_from={}
    end

    def total_amount_collected    
        @@vertex.each do |metro_id, travel_history| 
            balance_details = @@card_list[metro_id]
            result = find_amount_collected_for_metrocard(balance_details,travel_history)    
                result.each do |key,value| 
                    collection[key]["cost"]+=value["trip_cost"];
                    collection[key]["discount"]+=value["discount"];   
                    collection[key]["passengers"]+=value["passenger"];     
                end
            
            end
    
        return collection
    end
    
 

    def update_balace_aumount(balance_details)       
        effective_tarif = passenger_tarif_for {TRIP_FARE[_passenger_type]}    
        process_discount(effective_tarif)
        if balance_details["balance"].to_i < effective_tarif                      
            process_balance_recharge_cost { effective_tarif -= balance_details["balance"].to_i}   
            balance_details["balance"] = 0;        
        else
            balance_details["balance"] =  balance_details["balance"].to_i - effective_tarif
        end      

    end
    



    def find_amount_collected_for_metrocard(balance_details, trip_info)            
        @trip_from={}                
        trip_info.each do |station, destination|       
             @station=station  
             @trip_complete_status=false        
            if _is_return_journey   
                @trip_complete_status=true
                process_trip_segment(_destination)                                                                                                                
                update_balace_aumount(balance_details);                                               
                else                
                process_trip_segment(_station)                                                                                                               
                update_balace_aumount(balance_details);                              

            end              
        end    
        
        result = trip_from.clone 
        trip_from.clear()
        @station=nil
        return  result      

    end   
end     
