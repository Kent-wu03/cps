bgid = 52 -- id background
itemidb = 15756 -- id item


-- do not touch
SendPacket(2,"action|input|\ntext|`^Sc Cek Magplant Stock By `bSekrip Cepees")
rnmag = 1
totalblock = 0

function format_number(n)
    local str = tostring(n)
    local formatted = str:reverse():gsub("(%d%d%d)", "%1,")
    return formatted:reverse():gsub("^,", "")
end

function getmag()
    local find = {}
    local count = 0
    for x = 0, 199 do
        for y = 0, 199 do
            local tile = GetTile(x, y)
            if tile.fg == 5638 and tile.bg == bgid then
                count = count + 1
                table.insert(find, {x, y})
            end
        end
    end
    return find
end

function wrench(H, I, J, K, L)
    SendPacketRaw(false, {
        type = H,
        state = I,
        value = J,
        px = K,
        py = L,
        x = K * 32,
        y = L * 32,
    })
end

function ccekmag()
    local mp = getmag()
    while mp and #mp > 0 do
        local cmp = mp[rnmag]
        if cmp then
            wrench(0, 32, 0, cmp[1], cmp[2])
            Sleep(300)
            wrench(3, 0, 32, cmp[1], cmp[2])
            Sleep(300)
            SendPacket(2, "action|dialog_return\ndialog_name|mp_edit\nx|" .. cmp[1] .. "|\ny|" .. cmp[2] .. "|\nbuttonClicked|Close")
            Sleep(300)

            rnmag = rnmag + 1
            if rnmag > #mp then
                break
            end
        end
    end
    local total_stock = totalblock
    SendPacket(2, "action|input\n|text|`^Stock: `0"..format_number(total_stock).." `b#Sekrip Cepees")
   LogToConsole("`^Total Block: `w".. format_number(totalblock))
end


AddHook("onvariant", "cek", function(ccek)
    if ccek[0]:find("OnDialogRequest") then
        if ccek[1]:find("|" ..itemidb.. "|") then
            local stock = tonumber(ccek[1]:match("Stock: `$(%d+)"))
            totalblock = totalblock + stock
            LogToConsole("`^Now total stock: `0" .. format_number(totalblock))
        end
        return true
    end
    return false
end)


ccekmag()

result = [[
set_default_color||
add_label_with_icon|big|`cCek Magplant Stock|left|5638|
add_label_with_icon|small|`cScript by sekrip cepees|left|482|
add_spacer|small|
add_label_with_icon|small|`^Total:|left|]]..itemidb..[[|
add_textbox|`w]]..format_number(totalblock)..[[|
add_spacer|small|
add_url_button||`cSekrip Cepees``|NOFLAGS|https://whatsapp.com/channel/0029Vazh2wZD8SDozKXjIe1y|`^Link Saluran Sekrip cepees.|0|0|
add_quick_exit||
end_dialog|c|Exit|
        ]]
   SendVariantList{[0] = "OnDialogRequest", [1] = result}
