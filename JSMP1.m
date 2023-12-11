function x = JSMP1(x0,r,times)
x = zeros(1,times + 1001);
x(1)=x0;
for i=1:(times + 1001)
    x(i+1)=mod(r^2*(x(i)-5)*(1-r*(x(i)^2-5)),1);
end
x=x(1002:end);
x=floor(mod(x*10^12,256));