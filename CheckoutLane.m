classdef CheckoutLane

    properties
        checkout_type 
        customer
    end

    methods
        function obj = CheckoutLane(checkout_type)
            obj.checkout_type = checkout_type;
        end

        function obj = getNextCustomer(obj,inputArg)
            outputArg = obj.Property1 + inputArg;
        end
    end
end