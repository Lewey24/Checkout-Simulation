classdef Customer
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        lane_preference
        checkout_time
    end

    methods (Static)
      function out = percentSelf(data)
         persistent Var;
         if nargin
            Var = data;
         end
         out = Var;
      end
      function out = percentCashier(data)
         persistent Var;
         if nargin
            Var = data;
         end
         out = Var;
      end
      function out = percentBoth(data)
         persistent Var;
         if nargin
            Var = data;
         end
         out = Var;
      end
      function out = selfdist(data)
         persistent Var;
         if nargin
            Var = data;
         end
         out = Var;
      end
      function out = cashierdist(data)
         persistent Var;
         if nargin
            Var = data;
         end
         out = Var;
      end
    end

    methods
        function obj = Customer()
            % Constructs a new "Customer" instance
            %   This constructor randomly assigns a lane preference
            %   to each new instance
            r = rand;
            if r < Customer.percentBoth
                obj.lane_preference = Preference.BOTH;
            elseif r < Customer.percentBoth + Customer.percentCashier
                obj.lane_preference = Preference.CASHIER;
            else
                obj.lane_preference = Preference.SELF;
            end
        end 

        function obj = setCheckoutTime(obj, cashierbool)
            % setCheckoutTime: randomly assigns a checkout time based on
            % lane
            % Inputs: cashierbool: true if cashier checkout, false if self
            % checkout
            if cashierbool == true
                obj.checkout_time = round(random(Customer.cashierdist));
            else
                obj.checkout_time = round(random(Customer.selfdist));
            end
        end
    end

    methods (Static)
        function boolean = checkPercentageSum()
            % checkPercentageSum: checks that all customer preference 
            % percentages add up to 100%
            % Returns TRUE if percentBoth + percentCashier + percentSelf =
            % 100
            % Returns FALSE otherwise
            if Customer.percentBoth + Customer.percentCashier + Customer.percentSelf == 1
                boolean = true;
            else
                boolean = false;
            end
        end
    end
end