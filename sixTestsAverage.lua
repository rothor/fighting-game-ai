local matrix = require "matrix"
local REQUIRE_matrixHelper = require "matrixHelper"
local REQUIRE_vectorHelper = require "vectorHelper"
local REQUIRE_misc = require "misc"
local REQUIRE_setControllerMap = require "setControllerMap"


function sta_calculateScore(p1Hp, p2Hp, timeLeft)
	return (2880 - p2Hp) + p1Hp
end

function sta_runSingleTest(saveState, t)
		-- initialization
	local prevJoypadImage = createJoypadImage()
	local frameCounter = 0
	local lastTimeLeft = 99
	
		-- load save slot and enter loop
	savestate.loadslot(saveState)
	client.unpause()
	while true do
		local p1Hp = readFixedPointTwoBytes(0x0ADE94)
		local p2Hp = readFixedPointTwoBytes(0x0AE4E8)
		local timeLeft = mainmemory.read_u16_le(0x0AA958)
		
			-- detect freezing
		frameCounter = frameCounter + 1
		if (frameCounter % 1000 == 0) then --about once every 20 seconds
			if timeLeft == lastTimeLeft then --if timeLeft hasn't changed
				return {0, true}
			end
			lastTimeLeft = timeLeft
		end
		
			-- check values for round end
		if p1Hp == 0 or p2Hp == 0 or timeLeft == 0 then
			client.pause()
			return {sta_calculateScore(p1Hp, p2Hp, timeLeft), false}
		end
		
		setControllerMap(prevJoypadImage, t)
		emu.frameadvance()
	end
end

function sta_runTests(t)
	local sstate = {5, 6, 7, 8, 9, 0}
	local score = {0, 0, 0, 0, 0, 0}
	for i = 1, 6, 1 do
		local tempScore = sta_runSingleTest(sstate[i], t)
		if tempScore[2] then --if game froze
			return {0, true}
		end
		score[i] = tempScore[1]
		print("\tscore " .. i .. ": " .. score[i])
	end
	
	score = removeHighest(score)
	score = removeHighest(score)
	return {avg(score), false}
end
