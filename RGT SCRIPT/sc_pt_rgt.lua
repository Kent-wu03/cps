setting = {
    idtree = 3005,
    takex = 12,
    takey = 23,
}

function log(text) 
    SendVariantList({[0] = "OnTextOverlay", [1] = "[ `^Sekriptopia Info `w] : " .. text}) 
end

function findItem(id) 
    for _, v in pairs(GetObjectList()) do if v.id == id then return v end end return nil 
end


local function ppt(x, y , id)
    pkt = {}
    pkt.type = 3
    pkt.value = id
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    pkt.px = GetLocal().pos.x//32
    pkt.py = GetLocal().pos.y//32
    SendPacketRaw(false , pkt)
end

function ts()
    while GetItemCount(setting.idtree) == 0 do
        for y = 1,54,1 do
        for x = 0,99,1 do
            if GetItemCount(setting.idtree) > 2 then break end
                local tile = GetTile(x, y)
                log("`9Take Seed in `cX`0:`p"..setting.takex.." `cY`0:`p"..setting.takey)
                Sleep(200)
                FindPath(setting.takex,setting.takey,500)
                Sleep(1000)
                log("`9Plant Seed")
            end
        pt()
        end
    end
end

function pt()
    for y = 1,54,1 do
    for x = 0,99,1 do
    local tile = GetTile(x,y)
    if tile.fg == 0  then
        FindPath(x,y,500)
        Sleep(200)
        ppt(x,y,setting.idtree)
        Sleep(200)
        ts()
    end
end
end
end

SendVariantList({[0] = "OnTextOverlay", [1] = "`^Auto Plant by Sekriptopia"}) 
while true do
    ts()
    pt()
end
