% Tunable Parameters ------------------

% Parameters of chance customer prefers either checkout option
Customer.percentBoth(0.5);
Customer.percentCashier(0.25);
Customer.percentSelf(0.25);

% Parameters for self checkout time triangular distribution (in seconds)
selfdistlow = 60;
selfdistpeak = 90;
selfdisthigh = 240;

% Parameters for cashier checkout time triangular distribution (in seconds)
cashierdistlow = 30;
cashierdistpeak = 45;
cashierdisthigh = 120;

% Average customers per minute (must be <= 60)
custpermin = 6;

% Number of self checkouts
numselfcheckouts = 10;

% Number of cashier checkouts
numcashiercheckouts = 5;

%--------------------------------------

timevec = [];
selfqueuevec = [];
cashierqueuevec = [];
bothqueuevec = [];
totalqueuevec = [];

Customer.selfdist(makedist("Triangular", "a", selfdistlow, "b", selfdistpeak, "c", selfdisthigh));
Customer.cashierdist(makedist("Triangular", "a", cashierdistlow, "b", cashierdistpeak, "c", cashierdisthigh));

custpercent = custpermin / 60;

parameterscorrect = Customer.checkPercentageSum();
if parameterscorrect == false
    disp("Error: Percentages for customer preferences do not add up to 1")
    return
end

queues(1) = Queue(Preference.SELF);
queues(2) = Queue(Preference.BOTH);
queues(3) = Queue(Preference.CASHIER);

checkouts = [];

for i = 1:numselfcheckouts
    if size(checkouts, 1) == 0
        checkouts = CheckoutLane(Type.SELF);
    else
        checkouts(end+1) = CheckoutLane(Type.SELF);
    end
end

for i = 1:numcashiercheckouts
    if size(checkouts, 1) == 0
        checkouts = CheckoutLane(Type.CASHIER);
    else
        checkouts(end+1) = CheckoutLane(Type.CASHIER);
    end
end

for time = 1:3600
    r = rand;
    if rand <= custpercent
        c = Customer(time);
        for i = 1:length(queues)
            if c.lane_preference == queues(i).lane_preference
                queues(i) = queues(i).addCustomer(c);
            end
        end
    end
    
    for i = 1:length(checkouts)
        if ~checkouts(i).empty()
            if checkouts(i).customer.checkout_time <= 0
                checkouts(i).customer = [];
            end
        end

        if checkouts(i).empty()
            [checkouts(i), queues] = checkouts(i).getNextCustomer(queues);
        else
            checkouts(i).customer.checkout_time = checkouts(i).customer.checkout_time - 1;
            % Change to checkout time
        end
    end

    timevec(end+1) = time;
    selfqueuevec(end+1) = length(queues(1).queue);
    bothqueuevec(end+1) = length(queues(2).queue);
    cashierqueuevec(end+1) = length(queues(3).queue);
    totalqueuevec(end+1) = selfqueuevec(end) + bothqueuevec(end) + cashierqueuevec(end);
end

figure
hold on
plot(timevec, selfqueuevec)
plot(timevec, cashierqueuevec)
plot(timevec, bothqueuevec)
plot(timevec, totalqueuevec)
legend("Self Checkout Queue Length", "Cashier Checkout Queue Length", "Either Lane Queue Length", "Total Queue Length")
xlabel("time (s)")
ylabel("Customers")

disp("done")



