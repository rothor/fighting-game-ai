local matrix = require "matrix"
local REQUIRE_matrixHelper = require "matrixHelper"
local REQUIRE_vectorHelper = require "vectorHelper"
local REQUIRE_misc = require "misc"
local REQUIRE_setControllerMap = require "setControllerMap"


function ldf_calculateScore(p1Hp, p2Hp, timeLeft, blockScore)
	return blockScore
end

function ldf_runSingleTest(saveState, t)
		-- initialization
	local prevJoypadImage = createJoypadImage()
	local frameCounter = 0
	local lastTimeLeft = 99
	local blockScore = 0
	local prevP1Hp = 2880
	local blockedFlag = false
	local prevP2Ani = 0
	
		-- load save slot and enter loop
	savestate.loadslot(saveState)
	client.unpause()
	while true do
		local p1Hp = readFixedPointTwoBytes(0x0ADE94)
		local p2Hp = readFixedPointTwoBytes(0x0AE4E8)
		local timeLeft = mainmemory.read_u16_le(0x0AA958)
		local p1X = memory.read_s16_le(0x0AD98C)
		local p2X = memory.read_s16_le(0x0ADFE0)
		
			-- calculate block penalty
		if prevP2Ani ~= memory.readbyte(0x0AE00C) then
			blockedFlag = false
		end
		prevP2Ani = memory.readbyte(0x0AE00C)
		local isBlocking = false
		if (p1X < p2X and prevJoypadImage.Left) or (p1X > p2X and prevJoypadImage.Right) then
			isBlocking = true
		end
		local tookDamage = p1Hp < prevP1Hp
		
		if not blockedFlag and tookDamage then
			if isBlocking then blockScore = blockScore + 0
			else blockScore = blockScore - 10
			end
			blockedFlag = true
		elseif not blockedFlag then
			if isBlocking then blockScore = blockScore - 1
			else blockScore = blockScore + 0
			end
		else
			if isBlocking then blockScore = blockScore + 0
			else blockScore = blockScore - 1
			end
		end
		
		prevP1Hp = p1Hp
		
			-- detect freezing
		frameCounter = frameCounter + 1
		if (frameCounter % 1000 == 0) then --about once every 20 seconds
			if timeLeft == lastTimeLeft then --if timeLeft hasn't changed
				return {0, true}
			end
			lastTimeLeft = timeLeft
		end
		
			-- check values for round end
		if p1Hp == 0 or p2Hp == 0 or timeLeft == 0 or timeLeft <= 98 - 5 * 4 then
			client.pause()
			return {ldf_calculateScore(p1Hp, p2Hp, timeLeft, blockScore), false}
		end
		
			-- set controller map and continue to next frame
		setControllerMap(prevJoypadImage, t)
		emu.frameadvance()
	end
end

function ldf_runTests(t)
	local sstate = {5, 6, 7, 8, 9, 0}
	local score = {0, 0, 0, 0, 0, 0}
	for i = 1, 1, 1 do
		local tempScore = ldf_runSingleTest(sstate[i], t)
		if tempScore[2] then --if game froze
			return {0, true}
		end
		score[i] = tempScore[1]
		print("\tscore " .. i .. ": " .. score[i])
	end
	
	return {score[1], false}
end
