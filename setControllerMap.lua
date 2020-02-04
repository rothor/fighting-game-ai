local matrix = require "matrix"
local REQUIRE_matrixHelper = require "matrixHelper"
local REQUIRE_vectorHelper = require "vectorHelper"
local REQUIRE_misc = require "misc"


function setControllerMap(prevJoypadImage, t)
		-- get inputs and form a1
	local a1 = matrix(1, 22, 1)
	a1[1][1] = memory.readbyte(0x0AD9B8) --p1 animation
	a1[1][2] = memory.readbyte(0x0ADDA0) --on ground
	a1[1][3] = readFixedPointTwoBytes(0x0ADF72) --super 1
	a1[1][4] = readFixedPointTwoBytes(0x0ADF74) --super 2
	a1[1][5] = readFixedPointTwoBytes(0x0ADF76) --super 3
	a1[1][6] = memory.read_s16_le(0x0AD98C) --x pos
	a1[1][7] = memory.read_s16_le(0x0AD98E) --y pos
	a1[1][8] = prevJoypadImage.Right and 1 or 0 --prev controller map
	a1[1][9] = prevJoypadImage.Up and 1 or 0
	a1[1][10] = prevJoypadImage.Left and 1 or 0
	a1[1][11] = prevJoypadImage.Down and 1 or 0
	a1[1][12] = prevJoypadImage.Circle and 1 or 0
	a1[1][13] = prevJoypadImage.Triangle and 1 or 0
	a1[1][14] = prevJoypadImage.Square and 1 or 0
	a1[1][15] = prevJoypadImage.Cross and 1 or 0
	a1[1][16] = memory.readbyte(0x0AE00C) --p2 animation
	a1[1][17] = memory.readbyte(0x0AE3F4) --on ground
	a1[1][18] = readFixedPointTwoBytes(0x0AE5C6) --super 1
	a1[1][19] = readFixedPointTwoBytes(0x0AE5C8) --super 2
	a1[1][20] = readFixedPointTwoBytes(0x0AE5CA) --super 3
	a1[1][21] = memory.read_s16_le(0x0ADFE0) --x pos
	a1[1][22] = memory.read_s16_le(0x0ADFE2) --y pos
	
		-- calculate activations and output
	--a2
	local z2 = addBiasUnit(a1) * t[1] ^ 'T'
	local a2 = sigmoid(z2)
	--a3
	local z3 = addBiasUnit(a2) * t[2] ^ 'T'
	local a3 = sigmoid(z3)
	--a4 and out
	local z4 = addBiasUnit(a3) * t[3] ^ 'T'
	local a4 = sigmoid(z4)
	local out = convertMatrixToBool(a4)
	
		-- set p1 controller map
	prevJoypadImage = createJoypadImage(out[1][8], out[1][5], out[1][7], out[1][6], out[1][2], out[1][4], out[1][3], out[1][1])
	--prevJoypadImage = createJoypadImage(randZeroOne(), randZeroOne(), randZeroOne(), randZeroOne(), randZeroOne(), randZeroOne(), randZeroOne(), randZeroOne())
	joypad.set(prevJoypadImage, 1)
end
