findid = 2
delay = 120
posy = "up" -- diatas/dibawah magplant (up/down)
delay_put = 500 -- delay put ke mag setelah find menghindari find terlalu banyak


-- do not touch
local my = 0
if posy == "up" then
my = math.floor(GetLocal().pos.y / 32 + 1)
elseif posy == "down" then
my = math.floor(GetLocal().pos.y / 32 - 1)
end






SendPacket(2,"action|input|\ntext|`^Sc Find Add Mag By `bSekrip Cepees `0(`4START`0)")
mx = math.floor(GetLocal().pos.x / 32)
AddHook("onvariant", "hook", function(var)
	if var[0] == "OnDialogRequest" and var[1]:find("item_finder") then
		return true
	end
	if var[0] == "OnDialogRequest" and var[1]:find("MAGPLANT") then
		SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. mx .. "|\ny|" .. my .. "|\nitemToSelect|" .. findid .. "\n")
		return true
	end
	if var[0] == "OnConsoleMessage" and var[1]:find("This doesn't fit into the Magplant anymore!") then
		find = false
	end
	return false
end)
SendPacketRaw(false, {type = 3, value = 32, px = mx, py = my, x = mx * 32, y = my * 32})
Sleep(1000)
find = true
while find do
	SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. findid .. "|1")
	Sleep(delay_put)
	SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. mx .. "|\ny|" .. my .. "|\nbuttonClicked|additems")
	Sleep(delay)
end
RemoveHooks()
SendPacket(2,"action|input|\ntext|`^Sc Find Add Mag By `bSekrip Cepees `0(`2DONE`0)")
