function level.CommSpeak(0, a)
	if a == 1 then
		object("ourwarrior2_speak").active = 0 
		object("ourwarrior2_speak").on_enter = "level.CommSpeak(0, 2)"
		func.dialog.Show("halos", "test", 1, "", "object('ourwarrior2_speak').active = 1; func.SetWeap('ourplayer_tank','weap_minigun')", "OK")
--		service("msgbox", {
--							on_select="object('ourwarrior2_speak').active = 1; func.SetWeap('ourplayer_tank','weap_minigun')", 
--							text="Халос: Спасибо, что спас меня от сошедшей с ума турели.\nВот, держи пулемёт и уничтожь те дураукие ящики.",  
--							option1="1" } )
	elseif a == 2 then
		func.Message("halos", "test", 2)
	end
end
