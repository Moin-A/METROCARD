class MetroCardClassMethods
  @@card_list = []
  @@vertex = {};
  @@collection ={"CENTRAL"=>{"cost"=>0,"discount"=>0,"passengers"=>[]},"AIRPORT"=>{"cost"=>0,"discount"=>0,"passengers"=>[]}}
  @@station_from = {"CENTRAL"=>"AIRPORT","AIRPORT"=>"CENTRAL"}
  

  def initialize(*item)
    @travel_history =  {} if item 
    @metro_id = item.first["metro_id"] unless item.empty? 
    @station = item.first["station"] unless item.empty?  
    @passenger_type = item.first["passenger_type"] unless item.empty?  
    @destination = @@station_from[@station] 
  end

  class << self   
   
    def card_list=(card_list)
      @@card_list=card_list
    end 
    def card_list
      @@card_list
    end  
    def collection
      @@collection
    end  

    def station_from
      @@station_from
    end  
    def vertex
      @@vertex
    end  
  end  
 
end