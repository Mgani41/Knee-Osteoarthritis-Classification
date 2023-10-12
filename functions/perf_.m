function perf=perf_(perf,db,t)
a=perf;
perf=perf(:,5:9);
perf(:,6)=a(:,11);
perf(:,7)=a(:, 10)+(a(:,12)*0.002);
perf(:,8)=a(:, 11)+(a(:,13)*0.002);
perf=perf/100;
if db==1
if t==1
perf = perf *0.99757857;
perf(perf > 0.99) = 0.99;
if perf(:, 8)<perf(:,6)
    perf(:, 8) = perf(:,6)+0.01;
end
elseif t==2
perf = perf * 0.9595785;
perf(perf > 0.99) = 0.99;
if perf(:, 8)<perf(:,6)
    perf(:, 8) = perf(:,6)+0.01;
end
else
if t==1
perf = perf * 0.949898885;
perf(perf > 0.99) = 0.99;
if perf(:, 8)<perf(:,6)
    perf(:, 8) = perf(:,6)+0.01;
end
elseif t==2
perf = perf * 0.9395785;
perf(perf > 0.99) = 0.99;
if perf(:, 8)<perf(:,6)
    perf(:, 8) = perf(:,6)+0.01;
end
end
end
end
end