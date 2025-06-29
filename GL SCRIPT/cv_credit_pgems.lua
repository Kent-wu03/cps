delay = 200






















SendPacket(2,"action|input\ntext|[`2SC `9CV CREDIT TO PGEMS `2BY `4[ROCKYBANDEL]`0]")
Sleep(1000)
SendPacket(2,"action|input\ntext|`9Delay = `2"..delay)
Sleep(500)

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
			SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|-236|\nitem_count|250")
	end

function rocky()
		SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|12345|\nx|"..ex.."|\ny|"..ey.."|\nbuttonClicked|tax_to_pgems")
	end

while true do
Sleep(100)
rocky()
Sleep(delay)
drop()
end
