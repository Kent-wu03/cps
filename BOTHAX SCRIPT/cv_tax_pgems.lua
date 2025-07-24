-- stay on the telephone
delay = 200














SendPacket(2,"action|input\ntext|`2SC `bCV CREDIT TO PGEMS `2BY `c[ ROCKYBANDEL ]")
Sleep(500)
LogToConsole("`cDelay = "..delay)

function inv(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end
    end
    return 0
end

ex = math.floor(GetLocal().pos.x / 32)
ey = math.floor(GetLocal().pos.y / 32)

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
