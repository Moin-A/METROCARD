module GeektrustInstanceMethods
def  sort_by_count(arr)
    arr.sort_by { |a,b| arr.count(a)<arr.count(a)}
  end  


  def sort_by_seniority(arr)
    list =[ "ADULT","KID","SENIOR_CITIZEN"]
    arr.sort { |a,b| list.index(a) <=> list.index(b) }
  end 

  def  sort_by_count(arr)
    arr.sort_by { |a,b| arr.count(a)<arr.count(a)}
  end 

  def sort_by_seniority(arr)
    list =[ "ADULT","KID","SENIOR_CITIZEN"]
    arr.sort { |a,b| list.index(a) <=> list.index(b) }
  end  

  def print_summary(result)
    result.each do |station, info|
      total_collection = info["cost"]
      discount_given = info["discount"]
      passengers = info["passengers"]
      puts "TOTAL_COLLECTION #{station} #{total_collection} #{discount_given}"    
      puts "PASSENGER_TYPE_SUMMARY"
      passengers.uniq.each do |passenger_type|
        count = passengers.count(passenger_type)
        puts "#{passenger_type} #{count}"
      end
    end
  end

  def sort_passengers(result)
    result.each do |station,station_info|
        if (station_info["passengers"].uniq.size % 2 == 0)||(station_info["passengers"].uniq.size== station_info["passengers"].size)
          station_info["passengers"] = sort_by_seniority(station_info["passengers"])  
        else  
          station_info["passengers"] = sort_by_count(station_info["passengers"])  
        end
    end
  end

end