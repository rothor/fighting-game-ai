function readFixedPointTwoBytes(adr)
	local x = mainmemory.read_u16_be(adr)
	local x0 = math.floor(x / 16 ^ 3)
	x = x % 16 ^ 3
	x = x % 16 ^ 2
	local x2 = math.floor(x / 16)
	x = x % 16 
	local x1 = x

	return x2 * 16 ^ 2 + x1 * 16 + x0
end

function randRange(low, high)
	return math.floor(math.random() * (high - low + 1) + low)
end

function randZeroOne()
	if math.random() >= 0.5 then
		return true
	else
		return false
	end
end

function boolToNum(bool)
	return bool and 1 or 0
end

function avg(v)
	local total = 0
	local count = 0
	for e in pairs(v) do
		count = count + 1
		total = total + v[e]
	end
	
	return total / count
end

function standardDeviation(v)
	local total = 0
	local count = 0
	local average = avg(v)
	for n in ipairs(v) do
		count = count + 1
		local diff = v[n] - average
		total = total + diff * diff
	end
	
	return math.sqrt(total / count)
end

function createJoypadImage(x, o, sqr, tri, up, down, left, right, l1, l2, r1, r2)
	x = x or false;
	o = o or false;
	sqr = sqr or false;
	tri = tri or false;
	up = up or false;
	down = down or false;
	left = left or false;
	right = right or false;
	l1 = l1 or false;
	l2 = l2 or false;
	r1 = r1 or false;
	r2 = r2 or false;
	
	local joypadImage = {};
	joypadImage.Cross = x;
	joypadImage.Circle = o;
	joypadImage.Square = sqr;
	joypadImage.Triangle = tri;
	joypadImage.L1 = l1;
	joypadImage.L2 = l2;
	joypadImage.R1 = r1;
	joypadImage.R2 = r2;
	joypadImage.Up = up;
	joypadImage.Down = down;
	joypadImage.Left = left;
	joypadImage.Right = right;
	
	return joypadImage;
end
