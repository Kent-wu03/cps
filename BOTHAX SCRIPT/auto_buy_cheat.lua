local howmany = 230 -- 1 cheat = 8 hours (cost 50wl)
local delay = 100

for i = 1, howmany do
SendPacket(2, "action|dialog_return\ndialog_name|buycheat")
Sleep(delay)
end
