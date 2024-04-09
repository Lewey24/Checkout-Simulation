% Tunable Parameters ------------------

% Parameters of chance customer prefers either checkout option
Customer.percentBoth(0.5);
Customer.percentCashier(0.25);
Customer.percentSelf(0.25);

% Parameters for self checkout time distribution
selfdistlow = 60;
selfdistpeak = 90;
selfdisthigh = 240;

% Parameters for cashier checkout time distribution
cashierdistlow = 30;
cashierdistpeak = 45;
cashierdisthigh = 120;

% Average customers per minute (must be <= 60)
custpermin = 6;

%--------------------------------------

Customer.selfdist(makedist("Triangular", "a", selfdistlow, "b", selfdistpeak, "c", selfdisthigh));
Customer.cashierdist(makedist("Triangular", "a", cashierdistlow, "b", cashierdistpeak, "c", cashierdisthigh));

custpercent = custpermin / 60;

parameterscorrect = Customer.checkPercentageSum();
if parameterscorrect == false
    disp("Error: Percentages for customer preferences do not add up to 1")
    return
end


q = Queue(Preference.BOTH);

for i = 1:3600
    r = rand;
    if rand <= custpercent
        c = Customer(i);
        q = q.addCustomer(c);
    end
end

disp("done")



