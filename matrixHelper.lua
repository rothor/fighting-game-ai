local matrix = require "matrix"


-- Params
--   T: matrix
-- Returns table with two elements
function getMatrixDimensions(T)
  local rows = 0
  for _ in pairs(T) do rows = rows + 1 end
  local columns = 0
  for _ in pairs(T[1]) do columns = columns + 1 end
  return {rows, columns}
end

-- Params
--   m: matrix
-- Returns nothing
function outputMatrixDimensions(m)
	local dim = getMatrixDimensions(m)
	print("[ " .. dim[1] .. ", " .. dim[2] .. " ]")
end

-- Params
--   m: row vector
-- Returns new matrix
function addBiasUnit(m)
	local dim = getMatrixDimensions(m)
	local newM = matrix(1, dim[2] + 1)
	newM[1][1] = 1
	for i = 1, dim[2], 1 do
		newM[1][i + 1] = m[1][i]
	end
	
	return newM
end

-- Params
--   m: matrix
-- Returns nothing (modifies m)
function sigmoid(m)
	local c = m
	local dim = getMatrixDimensions(c)
	for i = 1, dim[1], 1 do
		for j = 1, dim[2], 1 do
			c[i][j] = 1 / (1 + 2.71828183 ^ -(c[i][j]))
		end
	end
	
	return c
end

-- Params
--   m: matrix
-- Returns nothing (modifies m)
function convertMatrixToBool(m)
	local c = m
	local dim = getMatrixDimensions(c)
	for i = 1, dim[1], 1 do
		for j = 1, dim[2], 1 do
			if c[i][j] >= 0.5 then
				c[i][j] = true
			else
				c[i][j] = false
			end
		end
	end
	
	return c
end

function writeMatrixUnrolledToFile(m, fileName)
	local file = io.open(fileName, "w")
	local dim = getMatrixDimensions(m)
	for i = 1, dim[1], 1 do
		for j = 1, dim[2], 1 do
			file:write(m[i][j] .. ",")
		end
	end
	file:close()
end

function appendMatrixUnrolledToFile(m, fileName)
	local file = io.open(fileName, "a")
	local dim = getMatrixDimensions(m)
	for i = 1, dim[1], 1 do
		for j = 1, dim[2], 1 do
			file:write(m[i][j] .. ",")
		end
	end
	file:write("\n")
	file:close()
end

-- Params
--   fileName: string, path to file
--   rows: num, num of rows
--   cols: num, num of cols
-- Returns matrix
function loadMatrixFromFile(fileName, rows, cols)
	local m = matrix(rows, cols)
	local file = io.open(fileName)
	for i = 1,rows,1 do
		for j = 1,cols,1 do
			m[i][j] = file:read("*number")
			file:read(1)
		end
	end
	file:close();
	
	return m
end

-- Params
--   m: matrix
-- Returns nothing (modifies m)
function randomize(m)
	local dim = getMatrixDimensions(m)
	for i = 1, dim[1], 1 do
		for j = 1, dim[2], 1 do
			m[i][j] = 3
		end
	end
	
	return m
end