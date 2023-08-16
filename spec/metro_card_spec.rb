require_relative '../MetroCard' 
require 'rspec'
require 'pry'
describe MetroCard do

  passengerData= [{"metro_id"=>"MC1", "passenger_type"=>"ADULT", "station"=>"CENTRAL"},{"metro_id"=>"MC1", "passenger_type"=>"ADULT", "station"=>"AIRPORT"}]
  passengerData_with_low_balance = [{"metro_id"=>"MC2", "passenger_type"=>"ADULT", "station"=>"CENTRAL"},{"metro_id"=>"MC2", "passenger_type"=>"ADULT", "station"=>"AIRPORT"}]
  card_list =   {"MC1"=>{"metro_id"=>"MC1", "balance"=>"600"},"MC2"=>{"metro_id"=>"MC2", "balance"=>"50"} } 
  before do
    MetroCard.reset_class_variables
  end

  describe '#add_passenger' do
    it 'adds a passenger to travel history' do     
      add_passenger_data = {"metro_id"=>"MC1", "passenger_type"=>"KID", "station"=>"CENTRAL"}
      metro_card = MetroCard.new(add_passenger_data)
      expect(MetroCard.vertex["MC1"][0][ metro_card.station ][metro_card.destination]["passenger_type"]).to eq("KID")
    end
  end

  describe '.passenger_tarif_for' do
    it 'returns the correct tariff for a passenger type' do
      MetroCard.new(passengerData[0])
      MetroCard.new(passengerData[1])
      expect(MetroCard.passenger_tarif_for("ADULT")).to eq(200)
      expect(MetroCard.passenger_tarif_for("KID")).to eq(50)
      expect(MetroCard.passenger_tarif_for("SENIOR_CITIZEN")).to eq(100)
    end
  end



  describe '.find_amount_collected_for_metrocard' do
    it 'expect total cost at starting station of round trip to be 200 for ADULT' do    
      MetroCard.new(passengerData[0])
      MetroCard.new(passengerData[1])    
      result = MetroCard.total_amount_collected(card_list)             
      expect(result["AIRPORT"]["cost"]).to eq(100)
    end
  end

  describe '.find_amount_collected_for_metrocard' do
    it 'expect total cost at return station of round trip to be 100 for Adult' do   
      MetroCard.new(passengerData[0])
      MetroCard.new(passengerData[1])    
      result = MetroCard.total_amount_collected(card_list)  
      expect(result["AIRPORT"]["cost"]).to eq(100)
    end
  end



  describe '.find_amount_collected_for_metrocard' do
    it 'adds 3 rechange cost (2% of effective cost) to the actual cost' do
      MetroCard.new(passengerData_with_low_balance[0])
      MetroCard.new(passengerData_with_low_balance[1])    
      result = MetroCard.total_amount_collected(card_list)
      expect(result["CENTRAL"]["cost"]).to eq(203)
      expect(result["AIRPORT"]["cost"]).to eq(102)
    end
  end



end
