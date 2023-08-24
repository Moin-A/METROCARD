module Trip_station_helper
      
    def _station
        @station&.keys&.first
      end
      def _destination
        @station&.values&.first&.keys&.first
      end
      def _passenger_type
        @station&.values&.first&.values&.first["passenger_type"]
      end
      def _is_return_journey
        trip_from[_destination] && _passenger_type === trip_from[_destination]["passenger_type"] && trip_from[_destination]["complete"] == false
      end  
      def reset_class_variables
        @@vertex = {};
        @@collection ={"CENTRAL"=>{"cost"=>0,"discount"=>0,"passengers"=>[]},"AIRPORT"=>{"cost"=>0,"discount"=>0,"passengers"=>[]}}
      end

 end   
  