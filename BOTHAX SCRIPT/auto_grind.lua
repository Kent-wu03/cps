pilihan = "s"  -- p/s
--  p for pepper
--  s for salt

-- do not touch
SendPacket(2,"action|input\ntext|`^Auto Grinder by `bSekrip Cepees")
Sleep(1000)
pilihans = 0
if pilihan == "p" then
	pilihans = 4584
elseif pilihan == "s" then
	pilihans = 4566
end

AddHook("onvariant", "hook", function(var)
	if var[0] == "OnDialogRequest" and var[1]:find("item_finder") then
		return true
	end
	return false
end)
grindX = math.floor(GetLocal().pos.x / 32)
grindY = math.floor(GetLocal().pos.y / 32)
while true do
	SendPacket(2, "action|dialog_return\ndialog_name|item_search\n" .. pilihans .. "|1")
	Sleep(150)
	for i = 1, 3 do
		SendPacket(2, "action|dialog_return\ndialog_name|grinder\nx|" .. grindX .. "|\ny|" .. grindY .. "|\nitemID|" .. pilihans .. "|\namount|2")
		Sleep(150)
	end
	for _, item in pairs(GetInventory()) do
		if item.id == pilihans and item.amount > 200 then
			SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..pilihans.."|\nitem_count|" .. item.amount)
			Sleep(150)
		end
	end
end
