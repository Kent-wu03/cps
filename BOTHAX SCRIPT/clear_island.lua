delay = 150

SendPacket(2,"action|input\ntext|`2SC `bCLEAR ISLAND `2BY `cROCKYBANDEL")
Sleep(500)
LogToConsole("`cDelay = "..delay)

for y2 = 193, 0, -10 do
	y1 = y2 - 9
	for x = 0, 199 do
		for y = y1, y2 do
			if y >= 0 then
				tile = GetTile(x, y)
			end
			if (tile.fg ~= 0 or tile.bg ~= 0) and tile.fg ~= 6 and tile.fg ~= 8 and tile.fg ~= 242 and tile.fg ~= 5638 and tile.fg ~= 1796 and tile.fg ~= 5260 and tile.fg ~= 11550 and tile.fg ~= 4992 and tile.fg ~= 7188 then
				SendPacketRaw(false, {state = 32, x = x * 32, y = y * 32})
				Sleep(1)
				while GetTile(x, y).fg ~= 0 or GetTile(x, y).bg ~= 0 do
					SendPacketRaw(false, {type = 3, value = 18, px = x, py = y, x = x * 32, y = y * 32})
					Sleep(delay)
				end
			end
		end
	end
end
SendPacket(2,"action|input\ntext|`cDONE CLEAR ISLAND `^SC BY `bROCKYBANDEL")
