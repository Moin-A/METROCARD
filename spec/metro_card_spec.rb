require_relative '../MetroCard' 
require_relative '../ProcessTripCost' 
require 'rspec'
require 'pry'
describe MetroCard do

  passengerData= [{"metro_id"=>"MC1", "passenger_type"=>"ADULT", "station"=>"CENTRAL"},{"metro_id"=>"MC1", "passenger_type"=>"ADULT", "station"=>"AIRPORT"}]
  passengerData_with_low_balance = [{"metro_id"=>"MC2", "passenger_type"=>"ADULT", "station"=>"CENTRAL"},{"metro_id"=>"MC2", "passenger_type"=>"ADULT", "station"=>"AIRPORT"}]
  card_list =   {"MC1"=>{"metro_id"=>"MC1", "balance"=>"600"},"MC2"=>{"metro_id"=>"MC2", "balance"=>"50"} }   
  passengerData_with_different_passenger_type=[{"metro_id"=>"MC1", "passenger_type"=>"ADULT", "station"=>"CENTRAL"},{"metro_id"=>"MC2", "passenger_type"=>"ADULT", "station"=>"AIRPORT"}]
  

  describe '#initializing metrocard' do
    it 'add the travel iternary in travel vertex' do    
      cloned_card_list = Marshal.load(Marshal.dump(card_list))
      MetroCard.card_list=cloned_card_list
      passengerData.each do |item|
        MetroCard.new(item);            
      end  
      trip =  ProcessTrip.new()
      total_collection = trip.total_amount_collected
      expect(MetroCard.vertex["MC1"]).to eq([{"CENTRAL"=>{"AIRPORT"=>{"passenger_type"=>"ADULT"}}}, {"AIRPORT"=>{"CENTRAL"=>{"passenger_type"=>"ADULT"}}}])
    end
  end

  # describe '.passenger_tarif_for' do
  #   it 'returns the correct tariff for a passenger type' do
  #     cloned_card_list = Marshal.load(Marshal.dump(card_list))
  #     MetroCard.card_list=cloned_card_list
  #     passengerData.each do |item|
  #       MetroCard.new(item);            
  #     end 
  #     trip =  ProcessTrip.new() 
  #     total_collection = trip.total_amount_collected
  
     
  #   end
  # end

  # describe '.find_amount_collected_for_metrocard' do
  #   it 'expect total cost at starting station of round trip to be 200 for ADULT' do    
  #     MetroCard.new(passengerData[0])
  #     MetroCard.new(passengerData[1])    
  #     result = MetroCard.total_amount_collected(Marshal.load(Marshal.dump(card_list)))             
  #     expect(result["AIRPORT"]["cost"]).to eq(100)
  #   end
  #   it 'expect total cost and discount at return station of round trip to be 100 for Adult ' do   
  #     MetroCard.new(passengerData[0])
  #     MetroCard.new(passengerData[1])    
  #     result = MetroCard.total_amount_collected(Marshal.load(Marshal.dump(card_list))) 
  #     expect(result["AIRPORT"]["discount"]).to eq(100)
  #     expect(result["AIRPORT"]["cost"]).to eq(100)
  #   end
  #   it 'adds 3 rechange cost (2% of effective cost) to the actual cost' do
  #     MetroCard.new(passengerData_with_low_balance[0])
  #     MetroCard.new(passengerData_with_low_balance[1])    
  #     result = MetroCard.total_amount_collected(Marshal.load(Marshal.dump(card_list)))
  #     expect(result["CENTRAL"]["cost"]).to eq(203)
  #     expect(result["AIRPORT"]["cost"]).to eq(102)
  #   end   
  #   it 'ensure  discount is 0 if to and fro trip from  station is covered by same passenger_type but having different metro_id' do
  #     MetroCard.new( passengerData_with_different_passenger_type[0])
  #     metro_card= MetroCard.new( passengerData_with_different_passenger_type[1])   
  #     result = MetroCard.total_amount_collected(Marshal.load(Marshal.dump(card_list))) 
  #     expect(result["CENTRAL"]["discount"]).to eq(0)
  #     expect(result["AIRPORT"]["discount"]).to eq(0)
  #   end   
   
  # end



end
