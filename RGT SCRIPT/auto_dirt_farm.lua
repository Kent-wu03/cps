SendPacket(2,"action|input\ntext|`2Dirt Farm SC By `bSekrip Cepees")



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
if(tile.y %2 == 1) or tile.x == 0 or tile.x == 1 or tile.x ==99 or tile.x == 98 then
if(tile.fg == 2) or (tile.bg == 14 and tile.fg == 0) or (tile.fg == 10) or (tile.fg == 4) then
                      FindPath(tile.x, tile.y-2)
                      breakfarm(tile.x, tile.y)
                     break
           else
                  end
               end
           end
       end
   end

finds()
