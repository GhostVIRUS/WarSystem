---===Service===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Service' class.")
Service = objects.Class("Service")

-- public methods
function Service:initialize(--[[name,]] props)
	checktype({props}, {"table+nil"}, "Service")
	
	props = props or {};
--	props["name"] = props["name"] or name;

	-- public members
	self.link = false
	
	-- conditionally private members
--	self._name = name
--	self._isVisible = false
	self._props = props

	self._objectType = nil -- maybe this will not be needed

	return nil
end

function Service:setProperties(props) -- requires table property-value
	for key, value in pairs(props) do
		self._props[key] = value
	end

	if self:exists() then
		self:_updateProps()
	end

	return nil
end

function Service:setVisibility(value)
	if self._props.name then
		dbg.Print("| Setting visibility of '"..self._props.name.."' to "..tostring(value)..".", "objects")
	end
	if value == true then
		self:_show()
	elseif value == false then
		self:_hide()
	end

	return nil
end

function Service:refresh() -- use only if service is visiable
	if self:exists() then
		self:_hide()
		self:_show()
	end
	
	return nil
end

function Service:exists()
	local existTest = xpcall(function() 
		if self.link.name then -- crutch
		end 
	end, 1)
	if existTest then
		return true
	else
		return false
	end
end

-- conditionally private methods
function Service:_saveProps()
	if self._props.name then
		dbg.Print("| Saving props of '"..self._props.name.."'.", "objects")
	end
	local tempTable = getmetatable(self.link);
	local property = "name";

	while property ~= nil do
		self._props[property] = tempTable.__index(self.link, property)
		property = tempTable.__next(self.link, property)
	end

	return nil
end

function Service:_show()
	if self._props.name then
		dbg.Print("| Showing '"..self._props.name.."'.", "objects")
	end
	self.link = service(self._objectType, self._props)
--	self._isVisible = true
	self:_saveProps()

	return nil
end

function Service:_hide()
	if self._props.name then
		dbg.Print("| Hidding '"..self._props.name.."'.", "objects")
	end
--	self._isVisible = false
	self:_saveProps()
	kill(self.link)
	self.link = nil

	return nil
end

function Service:_updateProps() -- updating real Service's properties from props
	if self:exists() then
		for key, value in pairs(self._props) do
			self.link[key] = value
		end
	end

	return nil
end
