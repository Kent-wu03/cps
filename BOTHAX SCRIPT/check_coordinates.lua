AddHook("onsendpacketraw", "hook", function(cor)
		if cor.type == 3 then
			LogToConsole("`2X : `^" .. cor.px .. " `2Y : `^" .. cor.py)
		end
		return false
	end)
