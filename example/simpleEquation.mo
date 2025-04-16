model SimpleEx
Real a, b, c, d, e;
equation
sqrt ( a ) = 65 " Equation f1";
d = a /( b* e ) " Equation f2";
e = d ^3 " Equation f3";
b = sqrt ( e ) " Equation f4";
0 = a ^2 + c " Equation f5";
end SimpleEx ;
