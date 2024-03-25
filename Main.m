% Tunable Parameters ------------------

% Parameters of chance customer prefers either checkout option
Customer.percentBoth(0.5);
Customer.percentCashier(0.25);
Customer.percentSelf(0.25);

% Parameters for self checkout time distribution
selfdistlow = 45;
selfdistpeak = 60;
selfdisthigh = 180;

% Parameters for cashier checkout time distribution
cashierdistlow = 30;
cashierdistpeak = 45;
cashierdisthigh = 120;

%--------------------------------------



Customer.selfdist(makedist("Triangular", "a", selfdistlow, "b", selfdistpeak, "c", selfdisthigh))
Customer.cashierdist(makedist("Triangular", "a", cashierdistlow, "b", cashierdistpeak, "c", cashierdisthigh))


parameterscorrect = Customer.checkPercentageSum();
if parameterscorrect == false
    disp("Error: Percentages for customer preferences do not add up to 1")
    return
end

c = Customer();
c.setCheckoutTime(false)