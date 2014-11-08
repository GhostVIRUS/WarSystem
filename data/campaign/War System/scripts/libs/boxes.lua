-- КОСТЫЛЬ. В отличие от exists, работает и на ссылки.
function func.Exists(obj)
	checktype({obj}, {"string+userdata"}, "func.Exists");

	if type(obj) == "userdata" then
		return xpcall(function() if obj.name then end; end, 1);
	end;
	return exists(obj);
end

-- Убирает объект, если он не существует. Не выдаёт ошибки. *Переписать, сделать так, чтобы не выдавал ошибки только с положительным аргументом takeOffWarning. Slava98. 11.01.14.
function func.KillIfExists(obj)
	checktype({obj}, {"string+userdata"}, "func.KillIfExists");
	
	if func.Exists(obj) then kill(obj) end;
end

-- Выводит окно с сообщением. Slava98.
function func.MsgBox(text, msgTab, boxType)
	checktype({text, msgTab, boxType}, {"string+table", "table+nil", "string+nil"}, "func.MsgBox");

	msgTab = func.DoTable(msgTab);
	msgTab.name = boxType or msgTab.name or "msgbox";
	if #msgTab > 0 then
		msgTab.on_select = msgTab[1];
		msgTab.option1 = msgTab[2];
		msgTab.option2 = msgTab[3];
		msgTab.option3 = msgTab[4];
	end;
	-- converts table to string
	if type(text) == "table" then
		checktype({text}, {{"string", "number"}}, "func.MsgBox");
		check(type(texts.list[optional.language]) == "table", "bad arguments to 'func.MsgBox' or problems with lang");
		check(type(texts.list[optional.language][text[1]]) == "table", "bad variable #1 in argument #1  to 'func.MsgBox' (text '"..text[1].."' does not exist)");
		check(type(texts.list[optional.language][text[1]][text[2]]) == "string", "bad variable #2 in argument #1 to 'func.MsgBox' (number '"..text[2].."' in text '"..text[1].."' does not exist)")
		text = texts.Read(unpack(text));
	end;
	msgTab.text = text;
	for i = 1, #msgTab do -- clears message table from array values
		msgTab[i] = nil;
	end;
	func.KillIfExists(msgTab.name); -- clears boxes with messages
	service("msgbox", msgTab); -- creates service
	
	return text;
end;
