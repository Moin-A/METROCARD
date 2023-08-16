module FileModule
    # Module code goes here
    def Parse_data(conten) # def main
        
        file = File.open(@fileinput)
      
        file.readlines.each do |line|         
            parameter,key,value,station = line.strip.split(" ");
            @metrocard_list[key]={"metro_id" =>key,"balance" => value.strip} if parameter === "BALANCE";
            @passengerData.push({"metro_id" =>key,"passenger_type" => value.strip,"station"=>station}) if parameter === "CHECK_IN";
        end 
    end    

  end