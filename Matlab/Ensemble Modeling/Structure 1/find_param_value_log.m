function parameterVal = find_param_value_log(meanConc,multiplier)
a = meanConc/multiplier;
b = meanConc*multiplier;
parameterVal = 10.^(log10(a) + (log10(b)-log10(a)).*rand(1,1));
% parameterVal = a + (b - a).*rand(1,1);
return