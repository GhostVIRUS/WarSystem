---===ListBox===---
-- includes
objects.Init()
engine.Require("msgbox", "classes")

-- declaring
dbg.Print("| Requiring 'ListBox' class.")
ListBox = objects.Class("ListBox", MsgBox)

-- public methods
function ListBox:initialize(name, props, sectionTab, chosedSectionNum, pointChar)
	MsgBox:initialize(name, props)

	self._sectionTab = sectionTab or {}
	self._chosedSectionNum = chosedSectionNum or 1
	self._pointChar = pointChar or ">"
	self._text = self._props["text"]
	
	self._props["text"] = self:_makeList()
	self._props["on_select"] = self._props["on_select"] or ""
	-- temply, i hope
	local num = math.random(1, 10000);
	temp[num] = self;
	self._props["on_select"] = "ListBox._onClickButton(temp["..num.."], n); "..self._props["on_select"]
	self._props["option1"] = texts.Read("other", 8)
	self._props["option2"] = texts.Read("other", 9)
	self._props["option3"] = texts.Read("other", 10)
end

function ListBox:refresh()
	self.link["text"] = self:_makeList()
	self:_hide()
	self:_show()
end

-- conditionally private methods
function ListBox:_makeList()
	local text = self._text;
	local sectionTab = self._sectionTab
	
	for i = 1, #sectionTab do -- list is divided on different sections, that has own titles, strings, etc.
		sectionTab[i].sectionTitle = sectionTab[i].sectionTitle or "\n";
		sectionTab[i].singedChar = sectionTab[i].singedChar or "*";
		sectionTab[i].stringsOnPage = sectionTab[i].stringsOnPage or 10;
		sectionTab[i].chosedStringNum = sectionTab[i].chosedStringNum or 1;	

		local sectionTitle = sectionTab[i].sectionTitle;
		local stringTab = sectionTab[i].stringTab;
		local funcTab = sectionTab[i].funcTab;
		local singedTab = sectionTab[i].signedTab;
		local singedChar = sectionTab[i].singedChar;
		local stringsOnPage = sectionTab[i].stringsOnPage;
		local chosedStringNum = sectionTab[i].chosedStringNum;
		local showNumeration = sectionTab[i].showNumeration;
		local currentPage = math.floor(chosedStringNum/(stringsOnPage + 1))+ 1;
		local listText = "";
		
		for num, str in pairs(stringTab) do
			if num > (currentPage - 1)*stringsOnPage and num <= currentPage*stringsOnPage then
				if num ~= chosedStringNum or i ~= self._chosedSectionNum then
					if not showNumeration then
						listText = listText.."\n  "..str;
					else
						listText = listText.."\n  "..num..")"..str;
					end;
				else
					if not showNumeration then
						listText = listText.."\n"..self._pointChar.." "..str;
					else
						listText = listText.."\n"..self._pointChar.." "..num..")"..str;
					end;
				end;
			end;
		end;
		
		if type(text) == "string" then -- i think, it doesn't useful now
			text = text..sectionTitle..listText;
		elseif type(text) == "table" then
			table.insert(text, "\n"..sectionTitle);
			table.insert(text, listText);
		end;
	end;
	
	return text;
end

function ListBox:_onClickButton(n)
	local sectionTab = self._sectionTab;
	local num = self._chosedSectionNum;
	
	if n == 1 then
		if #sectionTab[num].stringTab > sectionTab[num].chosedStringNum then
			sectionTab[num].chosedStringNum = sectionTab[num].chosedStringNum + 1;
		else
			sectionTab[num].chosedStringNum = 1;
			if #sectionTab > num then
				sectionTab[num].chosedStringNum = 1;
				self._chosedSectionNum = num + 1;
			elseif #sectionTab == num then
				sectionTab[num].chosedStringNum = 1;
				self._chosedSectionNum = 1;
			end;
		end;
		self.link["text"] = self:_makeList()
		self:refresh()
	elseif n == 2 then
		if 1 < sectionTab[num].chosedStringNum then
			sectionTab[num].chosedStringNum = sectionTab[num].chosedStringNum - 1;
		else
			sectionTab[num].chosedStringNum = #sectionTab[num].stringTab;
			if 1 < num then
				sectionTab[num].chosedStringNum = #sectionTab[num].stringTab;
				self._chosedSectionNum = num - 1;
			elseif 1 == num then
				sectionTab[num].chosedStringNum = #sectionTab[num].stringTab;
				self._chosedSectionNum = #sectionTab;
			end;
		end;
		self.link["text"] = self:_makeList()
		self:refresh()
	elseif n == 3 then
		if type(sectionTab[self._chosedSectionNum].funcTab[sectionTab[num].chosedStringNum]) == 'string' then
			loadstring(sectionTab[self._chosedSectionNum].funcTab[sectionTab[num].chosedStringNum])()
		elseif type(sectionTab[num].funcTab[sectionTab[num].chosedStringNum]) == 'function' then
			sectionTab[num].funcTab[sectionTab[num].chosedStringNum](sectionTab[num].chosedStringNum)
		end;
	end;
end
