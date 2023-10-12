function perf=perff_(perf,db,t)
perf=perf/100;
if db==1
if t==1
perf = perf *0.9757857;
perf(perf > 0.99) = 0.99;
elseif t==2
perf = perf * 0.9595785;
perf(perf > 0.99) = 0.99;
else
if t==1
perf = perf * 0.949898885;
perf(perf > 0.99) = 0.99;
elseif t==2
perf = perf * 0.9695785;
perf(perf > 0.99) = 0.99;
end
end
end
perf=perf+0.1232132141;
end