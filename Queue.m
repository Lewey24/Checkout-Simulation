classdef Queue
    %Queue
    %   This class creates the queue that holds customers before they are
    %   served by a cashier

    properties
        lane_preference
        queue
    end

    methods
        function obj = Queue(lane_preference)
            %Queue: Construct an instance of this class
            %   This takes an enum of lane_preference from the Preference.m
            %   class
            obj.lane_preference = lane_preference;
        end

        function obj = addCustomer(obj, customer)
            % addCustomer: Takes a customer object, and adds that customer
            % to the end of the queue
            if size(obj.queue, 1) == 0
                obj.queue = customer;
            else
                obj.queue(end+1) = customer;
            end
        end
        
        function bool = empty(obj)
            % empty: returns true if the queue is empty, returns false
            % otherwise
            if size(obj.queue, 1) == 0
                bool = true;
            else
                bool = false;
            end
        end

        function time = getArrivalTime(obj)
            % getArrivalTime: returns the arrival time of the first
            % customer in the queue
            % Note: if queue is empty, returns -1
            if size(obj.queue, 1) == 0
                time = -1;
            else
                time = obj.queue(1).arrival_time;
            end
        end

        function [obj, customer] = popFront(obj)
            % popFront: pops the front customer from the queue, and returns
            % that customer
            customer = obj.queue(1);
            obj.queue = obj.queue(2:end);
        end
    end
end