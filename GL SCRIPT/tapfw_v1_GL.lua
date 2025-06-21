delay = 10
SendPacket(2,"action|input\ntext|`4S`6C `9T`2A`4P `6T`9A`2P `4F`6I`9R`2E`4W`6O`9R`2K `4B`6Y `9R`2O`4C`6K`9Y")

function tapfw(id)
    pkt = {}
     pkt.type = 3
     pkt.value = id
     pkt.px = GetLocal().posX//32
     pkt.py = GetLocal().posY//32
     pkt.x = GetLocal().posX
     pkt.y = GetLocal().posY
     SendPacketRaw(false,pkt)
 end
 
 while true do
    tapfw(834)
    Sleep(delay)
end
