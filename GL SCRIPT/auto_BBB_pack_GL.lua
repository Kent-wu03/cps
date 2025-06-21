-- settings
delay = 100



-- do not touch
SendPacket(2,"action|input|\ntext|`4A`6U`9T`2O `4B`6U`9Y `2B`4B`6B `9P`2A`4C`6K `9B`2Y `4R`6O`9C`2K`4Y")
item_id = {834, 836, 830}

function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

function drop(id)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|" .. id .. "|\nitem_count|" .. findItem(id))
end

while true do
    SendPacket(2, "action|buy\nitem|buy_bbb")
    Sleep(500)
    for y, x in pairs(item_id) do
        if findItem(x) >= 100 then
            drop(x)
            Sleep(delay)
        end
    end
end
