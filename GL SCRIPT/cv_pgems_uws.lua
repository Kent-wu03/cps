delay = 300

























SendPacket(2,"action|input\ntext|[`2SC `9CV PGEMS TO UWS `2BY `4[ROCKYBANDEL]`0]")
Sleep(1000)
SendPacket(2,"action|input\ntext|`9Delay = `2"..delay)

function inv(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end
    end
    return 0
end

ex = math.floor (GetLocal().posX/32)
ey = math.floor (GetLocal().posY/32)

function drop()
			SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|12600|\nitem_count|250")
	end

function rocky()
		SendPacket(2,"action|dialog_return\ndialog_name|princess_dialog|\nx|"..ex.."|\ny|"..ey.."|\nbuyitem|actuallybuyitem14|\nbuy_count|2")
	end

while true do
Sleep(200)
rocky()
Sleep(delay)
drop()
end
