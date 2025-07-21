SendPacket(2,"action|input\ntext|`2Clear World SC By `bSekrip Cepees")
Sleep(100)
function breakfarm(x, y)
pkt = {}
pkt.type = 3
pkt.value = 18
pkt.px = x
pkt.py = y
pkt.x = GetLocal().pos.x
pkt.y = GetLocal().pos.y
SendPacketRaw(false,pkt)
Sleep(150)
finds()
end


function finds() do
for _, tile in pairs(GetTiles()) do
if(tile.fg == 2) or (tile.bg == 14 and tile.fg == 0) or (tile.fg == 10) or (tile.fg == 4) then
                      FindPath(tile.x, tile.y-2)
                      breakfarm(tile.x, tile.y)
                     break
           else
                  end
               end
           end
       end

finds()
