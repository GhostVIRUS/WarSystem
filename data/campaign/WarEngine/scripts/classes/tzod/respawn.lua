---===RespawnPoint===---
-- includes
objects.Init()
engine.Require("entity", "classes")

-- declaring
dbg.Print("| Requiring 'RespawnPoint' class.")
Sprite = objects.Class("RespawnPoint", Entity)

-- public methods
function RespawnPoint:initialize(--[[name,]] pos, props)
	Entity:initialize(self, --[[name,]] pos, props)

	self._objectType = "respawn_point"
end

function RespawnPoint:follow(whoName, speed, iteration, copyDir) -- speed here and above in px/sec
	if iteration == 0 then
		if self._props.name then
			dbg.Print("| '"..self._props.name.."' follows '"..whoName.."'", "objects") 
		end
		self._allowMoving = true
	end
	self._isMoving = true

	pushcmd( function()
		local whoX, whoY = position(whoName)
		local distance, angle = self:getVector({ x = whoX, y = whoY }) -- rework access to position (maybe)
		if distance > 8*32 then
			self._pos.x = self._pos.x + math.cos(angle)*speed/100
			self._pos.y = self._pos.y + math.sin(angle)*speed/100
			self:_updatePos()
		end

		if copyDir then
			self._props["dir"] = object(whoName)["dir"];
			self:_updateProps()
		end
		
		self._isMoving = false

		if self._allowMoving then
			self:follow(whoName, speed, 1) -- recursion
		end

	end, 1/100)

	return nil
end