dropid = 2
-- gunakan script debug packet kemudian drop dan liat id item minesnya
-- hanya berlaku untuk custom item cps sisanya id item angka positif
delay = 100
posy = "up" -- diatas/dibawah magplant (up/down)




-- do not touch



SendPacket(2,"action|input|\ntext|`^Sc Take & Drop By `bSekrip Cepees `0(`4START`0)")
mx = math.floor(GetLocal().pos.x / 32)
local my = 0
if posy == "up" then
my = math.floor(GetLocal().pos.y / 32 + 1)
elseif posy == "down" then
my = math.floor(GetLocal().pos.y / 32 - 1)
end
AddHook("onvariant", "hook", function(var)
	if var[0] == "OnDialogRequest" and var[1]:find("MAGPLANT") then
		return true
	end
	if var[0] == "OnTextOverlay" and var[1]:find("You can't drop that here") then
		godrop = false
	end
	return false
end)
SendPacketRaw(false, {type = 3, value = 32, px = mx, py = my, x = mx * 32, y = my * 32})
Sleep(1000)
godrop = true
while godrop do
	SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. mx .. "|\ny|" .. my .. "|\nbuttonClicked|withdraw")
	Sleep(delay)
	SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|" .. dropid .. "|\nitem_count|250\n")
	Sleep(delay)
end
RemoveHooks()
SendPacket(2,"action|input|\ntext|`^Sc Take & Drop By `bSekrip Cepees `0(`2DONE`0)")
