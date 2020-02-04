local matrix = require "matrix"
local REQUIRE_matrixHelper = require "matrixHelper"
local REQUIRE_vectorHelper = require "vectorHelper"
local REQUIRE_misc = require "misc"
local REQUIRE_sixTestsAverage = require "sixTestsAverage"
local REQUIRE_shortBasicTest = require "shortBasicTest"
local REQUIRE_learnDefense = require "learnDefense"


function textFile(fileName)
	return scriptPath .. fileName .. ".txt"
end

function loadThetasNamed(name)
	local L = {22, 66, 66, 8}
	local t1 = loadMatrixFromFile(textFile(name .. "1"), L[2], L[1] + 1)
	local t2 = loadMatrixFromFile(textFile(name .. "2"), L[3], L[2] + 1)
	local t3 = loadMatrixFromFile(textFile(name .. "3"), L[4], L[3] + 1)
	
	return {t1, t2, t3}
end

function loadThetas()
	return loadThetasNamed("t")
end

function loadThetasMutate()
	local L = {22, 66, 66, 8}
	local t1 = loadMatrixFromFile(textFile("t1"), L[2], L[1] + 1)
	local t2 = loadMatrixFromFile(textFile("t2"), L[3], L[2] + 1)
	local t3 = loadMatrixFromFile(textFile("t3"), L[4], L[3] + 1)
	
	return {mutate(t1), mutate(t2), mutate(t3)}
end

function saveThetasNamed(t, name)
	writeMatrixUnrolledToFile(t[1], textFile(name .. "1"))
	writeMatrixUnrolledToFile(t[2], textFile(name .. "2"))
	writeMatrixUnrolledToFile(t[3], textFile(name .. "3"))
end

function saveThetas(t)
	saveThetasNamed(t, "t")
end

function getPrevResults()
	local file = io.open(textFile("results"), "r")
	local result = file:read("*number")
	file:close()
	
	return result
end

function setResults(newResults)
	local file = io.open(textFile("results"), "w")
	file:write(newResults)
	file:close()
end

function mutate(m)
	local c = m
	local dim = getMatrixDimensions(c)
	for i = 1, dim[1], 1 do
		for j = 1, dim[2], 1 do
			local value = randRange(1, 100)
			if value <= 2 then
				c[i][j] = c[i][j] + randRange(-40, 40)
			end
		end
	end
	
	return c
end


function fullRoutine()
	print("Running test on new species...")
	
		-- initialize
	local t = loadThetasMutate() --new species
	
		-- run tests
	local result = sta_runTests(t)
	if result[2] then --if game froze during test
		print("Error: game froze.")
		return
	end
	local score = result[1]
	print("\tFinal: " .. score)
	local prevScore = getPrevResults()
	print("\tBest: " .. prevScore)
	
		-- compare score
	if score > prevScore then
		print("New species wins.")
		saveThetas(t)
		setResults(score)
	else
		print("New species loses.")
	end
	
	saveThetasNamed(t, "tPrev")
end

function recalcScore()
	print("Recalculating score...")
	
		-- initialize
	local t = loadThetas()
	
		-- run tests
	local result = sta_runTests(t)
	if result[2] then --if game froze during test
		print("Error: game froze.")
		return
	end
	local score = result[1]
	print("\tFinal: " .. score)
	
		-- save score
	setResults(score)
	print("Score saved.")
end

function loadPrevTheta()
	local t = loadThetasNamed("tPrev")
	saveThetas(t)
	print("Prev thetas loaded.")
end


	-- some global initialization
math.randomseed(os.time())
math.random(); math.random(); math.random()
scriptPath = "C:/Users/Joey/My Folder/programming/Lua/BizHawk/x-men mutant academy 2/neural network/"

while true do
	print("-----------------------------------")
	fullRoutine()
	--recalcScore()
	--loadPrevTheta()
	--break
end

