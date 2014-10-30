---===Service===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Service' class.")
Service = objects.Class("Service")

-- public methods
function Service:initialize(name, props)
	props = props or {};
	props["name"] = props["name"] or name;

	-- conditionally private members
	self._name = name
	self._link = link
	self._isVisible = false
	self._props = props

	self._objectType = nil -- maybe this will not be needed

	return nil
end

function Service:setProperties(props) -- requires table property-value
	for key, value in pairs(props) do
		self._props[key] = value
	end

	if self._isVisible == true then
		self:_updateProps()
	end

	return nil
end


-- conditionally private methods
function Serivce:_saveProps()
	dbg.Print(self._name..":_saveProps()", "objects")
	local tempTable = getmetatable(self._link);
	local property = "name";

	while property ~= nil do
		self._props[property] = tempTable.__index(self._link, property)
		property = tempTable.__next(self._link, property)
	end

	return nil
end

function Service:_show()
	dbg.Print(self._name..":_show()", "objects")
	self._link = service(self._objectType, self._props)
	self._isVisible = true
	self:_saveProps()

	return nil
end

function Service:_hide()
	dbg.Print(self._name..":_hide()", "objects")
	self._isVisible = false
	self:_saveProps()
	kill(self._link)
	self._link = nil

	return nil
end

function Service:_updateProps() -- updating real Service's properties from props
	if self._isVisible == true then
		for key, value in pairs(self._props) do
			self._link[key] = value
		end
	end

	return nil
end