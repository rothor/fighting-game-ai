scriptPath = "C:/Users/Joey/Documents/a_coding_related/Lua/BizHawk/x-men mutant academy 2/neural network/";

t = load("tBest1.txt");
dlmwrite([scriptPath, "tBest1Avg.txt"],mean(t),'precision','%.9f');

t = load("tBest2.txt");
dlmwrite([scriptPath, "tBest2Avg.txt"],mean(t),'precision','%.9f');

t = load("tBest3.txt");
dlmwrite([scriptPath, "tBest3Avg.txt"],mean(t),'precision','%.9f');
