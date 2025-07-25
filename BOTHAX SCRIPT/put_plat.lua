pid = 3126
delay = 100

sx, sy = 200, 200








SendPacket(2,"action|input\ntext|`2SC `bPUT PLAT `2BY `cROCKYBANDEL")
Sleep(3500)
SendPacket(2,"action|input\ntext|`2Platform ID:`^"..pid.." `2delay:`^"..delay)

put = 10
function inv(id)
	for _, item in pairs(GetInventory()) do
		if item.id == id then
			return item.amount
		end
	end
	return 0
end
AddHook("onvariant", "hook", function(var)
	if var[0] == "OnDialogRequest" and var[1]:find("item_finder") then
		return true
	end
	return false
end)
for y = sy -2, 0, -1 do
	for x1 = 0, put - 1 do
		for x2 = 0, sx/put - 1 do
			x = x2 * put + x1
			tile = GetTile(x, y)
			if inv(pid) == 0 then
				SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. pid .. "|1")
				Sleep(1000)
			end
			if tile.fg == 0 and y%2 == 1 then
				SendPacketRaw(false, {state = 32, x = x * 32 - 32, y = y * 32})
				Sleep(1)
				SendPacketRaw(false, {type = 3, value = platID, px = x, py = y, x = x * 32, y = y * 32})
				Sleep(delay)
			end
		end
	end
end
RemoveHooks()
SendPacket(2,"action|input\ntext|`9PUT PLAT `2DONE `9SC BY `bROCKYBANDEL")
