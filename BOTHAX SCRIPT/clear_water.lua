SendPacket(2,"action|input\ntext|`2SC `bCLEAR WATER `2BY `cROCKYBANDEL")
Sleep(500)

for x = 0, 199, 1 do
	for y = 199, 0, -1 do
		tile = GetTile(x,y)
		if tile.flags.water == true then
			SendPacketRaw(false, {state = 32, x = x * 32, y = y * 32})
			Sleep(1)
			while GetTile(x,y).flags.water ~= false do
				SendPacketRaw(false, {type = 3, value = 822, px = x, py = y, x = x * 32, y = y * 32})
				Sleep(400)
			end
		end
	end
end
SendPacket(2,"action|input\ntext|`cDONE CLEAR ISLAND `^SC BY `bROCKYBANDEL")
