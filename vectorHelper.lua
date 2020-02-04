

-- Params
--   T: vector
-- Returns table with two elements
function getVectorDimensions(T)
  local rows = 0
  for _ in pairs(T) do rows = rows + 1 end
  return rows
end

function removeAt(v, index)
	local dim = getVectorDimensions(v)
	local c = {}
	local i = 1
	local j = 1
	for i = 1, dim, 1 do
		if i ~= index then
			c[j] = v[i]
			j = j + 1
		end
		i = i + 1
	end
	
	return c
end

function getHighest(v)
	local dim = getVectorDimensions(v)
	local highestIndex = 1
	for i = 2, dim, 1 do
		if v[i] > v[highestIndex] then
			highestIndex = i
		end
	end
	
	return highestIndex
end

function getLowest(v)
	local dim = getVectorDimensions(v)
	local lowestIndex = 1
	for i = 2, dim, 1 do
		if v[i] < v[lowestIndex] then
			lowestIndex = i
		end
	end
	
	return lowestIndex
end

function removeHighest(v)
	local c = v
	c = removeAt(c, getHighest(c))
	
	return c
end
