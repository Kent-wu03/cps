-- auto tap,reconnect,take
-- do not resell :D
cid = 834 -- id item yang mau di consume
delay = 10
fwbg = 118 -- id background tempat fw


-- do not touch
world = GetWorld().name
fwp = {} 

local fx, fy = math.floor(GetLocal().pos.x / 32), math.floor(GetLocal().pos.y / 32)

function eat()
    local posi = GetLocal()
    if not posi or not posi.pos then return end
    local cx = math.floor(posi.pos.x / 32)
    local cy = math.floor(posi.pos.y / 32)
    SendPacketRaw(false, {type = 3, value = cid, px = cx, py = cy, x = cx * 32, y = cy * 32})
    Sleep(delay)
end

function bp_item(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end
    end
    return 0
end

function bgtile(bgId)
    local tiles = {}
    local worldX = GetTile(199, 199) and 199 or 99
    local worldY = GetTile(199, 199) and 199 or 59
    for y = worldY, 0, -1 do
        for x = 0, worldX do
            local tile = GetTile(x, y)
            if tile and tile.bg == bgId then
                table.insert(tiles, { x = x, y = y })
            end
        end
    end
    return tiles
end

function closesttile(tiles)
    local px, py = math.floor(GetLocal().pos.x / 32), math.floor(GetLocal().pos.y / 32)
    local closest = nil
    local minDist = math.huge
    for i, tile in ipairs(tiles) do
        local dist = math.abs(tile.x - px) + math.abs(tile.y - py)
        if dist < minDist then
            minDist = dist
            closest = i
        end
    end
    return closest
end

SendPacket(2, "action|input\ntext|`4S`6C `9T`2A`4P `6T`9A`2P `4F`6I`9R`2E`4W`6O`9R`2K `4B`6Y `9R`2O`4C`6K`9Y")

fwp = bgtile(fwbg)
LogToConsole("`9total `2"..#fwp.." `9tiles #rockyy")

while true do
    local current = GetWorld()
    if current and current.name == world then
        if bp_item(cid) <= 5 then
            if #fwp > 0 then
                local index = closesttile(fwp)
                if index then
                    local target = table.remove(fwp, index)
                    LogToConsole("`9Tp to: `2("..target.x..","..target.y..") #rockyy")
                    FindPath(target.x, target.y)
                    Sleep(1000)
                end
            else
                LogToConsole("`4Done sc by rockyy")
				break
            end
        else
            eat()
        end
    else
        LogToConsole("`9Returning to world: `2"..world)
        SendPacket(3, "action|join_request\nname|" .. world .. "\ninvitedWorld|0")
        Sleep(2000)
        FindPath(fx, fy)
    end
    Sleep(100)
end
