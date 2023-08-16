require_relative 'helper/fileModule'
require_relative 'MetroCard'
require_relative 'MetroCardHelperMethods'
class MetroCardApplication 
  include FileModule;
  include MetroCardHelperMethods
  def initialize(fileinput)
    @metrocard_list = {};
    @passengerData=[];
    @fileinput = fileinput
    @print_summary=true;
  end

  def main
    Parse_data(@fileinput)
    generate_metro_card()
    get_total_collection()
   end

  def generate_metro_card
    @passengerData.each do |item|
     MetroCard.new(item);            
    end      
  end
end


def get_total_collection
  total_collection =  MetroCard.total_amount_collected(@metrocard_list)
  sort_passengers(total_collection); 
  print_summary(total_collection) if @print_summary
end  

fileinput = ARGV[0]
app = MetroCardApplication.new(fileinput);
app.main();



