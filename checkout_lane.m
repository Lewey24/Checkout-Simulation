classdef checkout_lane
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明

    properties
        checkout_type
        customer
    end

    methods
        function obj = checkout_lane(checkout_type)
            %UNTITLED2 构造此类的实例
            %   此处显示详细说明
            obj.checkout_type = checkout_type;
        end

        function obj = getNEXTcustomer(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end