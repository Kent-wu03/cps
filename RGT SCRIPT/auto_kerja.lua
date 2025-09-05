id_break = 324

LogToConsole("`^Auto Kerja by rockybandel (1ACC)")
Sleep(100)

function breakkerja(x, y)
    pkt = {}
    pkt.type = 3
    pkt.value = 18
    pkt.px = x
    pkt.py = y
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
    Sleep(150)
    finds()
end

function finds()
    for _, tile in pairs(GetTiles()) do
        if tile.fg == id_break then
            if GetTile(tile.x, tile.y-2).fg == 0 then
                FindPath(tile.x, tile.y-2)
                breakkerja(tile.x, tile.y)
                return
            end
        end
    end

    for _, tile in pairs(GetTiles()) do
        if tile.fg == id_break then
            if GetTile(tile.x, tile.y+2).fg == 0 then
                FindPath(tile.x, tile.y+2)
                breakkerja(tile.x, tile.y)
                return
            end
        end
    end

    Sleep(300)
    finds()
end

finds()
