scriptPath = "C:/Users/Joey/Documents/a_coding_related/Lua/BizHawk/x-men mutant academy 2/neural network/";

t = floor(rand(66, 23) * 201) - 100;
dlmwrite([scriptPath, "t1.txt"],t,'precision','%.9f');

t = floor(rand(66, 67) * 201) - 100;
dlmwrite([scriptPath, "t2.txt"],t,'precision','%.9f');

t = floor(rand(8, 67) * 201) - 100;
dlmwrite([scriptPath, "t3.txt"],t,'precision','%.9f');
