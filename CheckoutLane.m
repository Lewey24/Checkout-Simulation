classdef CheckoutLane

    properties
        checkout_type 
        customer
    end

    methods
        function obj = CheckoutLane(checkout_type)
            obj.checkout_type = checkout_type;
            obj.customer = [];
        end

        function bool = empty(obj)
            if isempty(obj.customer)
                bool = true;
            else
                bool = false;
            end
        end

        function [obj, queues] = getNextCustomer(obj, queues)
            earliest = 0;
            earliest_time = -1;
            for i = 1:length(queues)
                if obj.checkout_type == Type.SELF
                    if queues(i).lane_preference == Preference.SELF || queues(i).lane_preference == Preference.BOTH
                        if queues(i).empty() ~= true
                            if earliest_time == -1
                                earliest = i;
                                earliest_time = queues(i).getArrivalTime();
                            elseif earliest_time > queues(i).getArrivalTime()
                                earliest = i;
                                earliest_time = queues(i).getArrivalTime();
                            end
                        end
                    end
                else
                    if queues(i).lane_preference == Preference.CASHIER || queues(i).lane_preference == Preference.BOTH
                        if queues(i).empty ~= true
                            if earliest_time == -1
                                earliest = i;
                                earliest_time = queues(i).getArrivalTime();
                            elseif earliest_time > queues(i).getArrivalTime()
                                earliest = i;
                                earliest_time = queues(i).getArrivalTime();
                            end
                        end
                    end
                end
            end
            if earliest ~= 0
                [queues(earliest), obj.customer] = queues(earliest).popFront();
                obj.customer = obj.customer.setCheckoutTime(obj.checkout_type);

                if obj.customer.lane_preference == Preference.SELF
                    disp("Self customer arrived")
                elseif obj.customer.lane_preference == Preference.CASHIER
                    disp("Cashier customer arrived")
                else
                    disp("Both customer arrived")
                end
            end
        end
    end
end