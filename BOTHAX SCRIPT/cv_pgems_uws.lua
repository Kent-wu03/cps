-- stay on princess
-- after run sc wrench the princess
delay = 200














SendPacket(2,"action|input\ntext|`2SC `bCV PGEMS TO UWS `2BY `c[ ROCKYBANDEL ]")
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
			SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|12600|\nitem_count|250")
	end

function rocky()
		SendPacket(2,"action|dialog_return\ndialog_name|princess_dialog|\nx|"..ex.."|\ny|"..ey.."|\nbuyitem|actuallybuyitem13|\nbuy_count|1")
	end

while true do
Sleep(200)
rocky()
Sleep(delay)
drop()
end
