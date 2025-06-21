cid = 834
delay = 10



cx,cy = math.floor(GetLocal().pos.x / 32), math.floor(GetLocal().pos.y / 32)
SendPacket(2,"action|input\ntext|`4S`6C `9T`2A`4P `6T`9A`2P `4F`6I`9R`2E`4W`6O`9R`2K `4B`6Y `9R`2O`4C`6K`9Y")
while true do
	SendPacketRaw(false, {type = 3, value = cid, px = cx, py = cy, x = cx * 32, y = cy * 32})
	Sleep(delay)
end
