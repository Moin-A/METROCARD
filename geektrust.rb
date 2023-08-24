require_relative 'helper/fileModule'
require_relative 'MetroCard'
require_relative 'MetroCardHelperMethods'
require_relative 'ProcessTripCost'
require_relative 'MetroCardClassMethods'
class MetroCardApplication 
  include FileModule;
  include MetroCardHelperMethods
  def initialize(fileinput)
    @metrocard_list = {};
    @passengerData=[];
    @fileinput = fileinput
    @print_summary=false;
  end

  def main
    Parse_data(@fileinput)
    generate_metro_card()
    get_total_collection()
   end

  def generate_metro_card
    MetroCard.card_list=@metrocard_list;
    @passengerData.each do |item|
      MetroCard.new(item);            
    end   
  
  end
end


def get_total_collection
  trip =  ProcessTrip.new()
  total_collection = trip.total_amount_collected
  sort_passengers(total_collection); 
  print_summary(total_collection) if @print_summary
end  

fileinput = ARGV[0]
app = MetroCardApplication.new(fileinput);
app.main();



