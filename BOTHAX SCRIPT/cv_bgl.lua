delay_cv = 100
ex = math.floor(GetLocal().pos.x / 32)
ey = math.floor(GetLocal().pos.y / 32)

while true do
	SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|".. ex .."|\ny|".. ey .."|\nbuttonClicked|bglconvert2")
	Sleep(delay_cv)
end
