class MetroCardClassMethods
  @@card_list = []
  @@vertex = {};
  STATION_FROM = {"CENTRAL"=>"AIRPORT","AIRPORT"=>"CENTRAL"}
  

  def initialize(*item)
    @travel_history =  {} if item 
    @metro_id = item.first["metro_id"] unless item.empty? 
    @station = item.first["station"] unless item.empty?  
    @passenger_type = item.first["passenger_type"] unless item.empty?  
    @destination = STATION_FROM[@station] unless item.empty? 
  end

  class << self   
   
    def card_list=(card_list)
      @@card_list=card_list
    end 
    def card_list
      @@card_list
    end  
   
    def station_from
      STATION_FROM
    end  
    def vertex
      @@vertex
    end  
  end  
 
end