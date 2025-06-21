cid = 834
delay = 10
world = GetWorld().name

fx,fy = math.floor(GetLocal().pos.x / 32), math.floor(GetLocal().pos.y / 32)
function eat()
    local posi = GetLocal()
    if not posi or not posi.pos then return end

    local cx = math.floor(posi.pos.x / 32)
    local cy = math.floor(posi.pos.y / 32)
	SendPacketRaw(false, {type = 3, value = cid, px = cx, py = cy, x = cx * 32, y = cy * 32})
    Sleep(delay)
end

SendPacket(2, "action|input\ntext|`4S`6C `9T`2A`4P `6T`9A`2P `4F`6I`9R`2E`4W`6O`9R`2K `4B`6Y `9R`2O`4C`6K`9Y")

while true do
    local current = GetWorld()
    if current and current.name == world then
        eat()
    else
		LogToConsole("`9Going back to > `2"..world)
        SendPacket(3, "action|join_request\nname|" .. world .. "\ninvitedWorld|0")
        Sleep(2000)
		FindPath(fx,fy)
    end
    Sleep(100)
end
