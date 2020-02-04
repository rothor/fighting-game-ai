local matrix = require "matrix"
local REQUIRE_matrixHelper = require "matrixHelper"
local REQUIRE_vectorHelper = require "vectorHelper"
local REQUIRE_misc = require "misc"

local scriptPath = "C:/Users/Joey/My Folder/programming/Lua/BizHawk/x-men mutant academy 2/neural network/"
function textFile(fileName)
	return scriptPath .. fileName .. ".txt"
end

print("----- test -----")

local test = loadMatrixFromFile(textFile("testTheta"), 2, 2)

print(test[1][1])
print(test[1][2])
print(test[2][1])
print(test[2][2])

print("-- end test --")