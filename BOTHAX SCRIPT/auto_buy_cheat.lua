local howmany = 230 -- 1 cheat = 8 hours (cost 50wl)
local delay = 100

SendPacket(2,"action|input\ntext|`2SC `bCV POIN TO FARMING BOT `2BY `cROCKYBANDEL")
Sleep(500)
LogToConsole("`cDelay = "..delay)

for i = 1, howmany do
SendPacket(2, "action|dialog_return\ndialog_name|buycheat")
Sleep(delay)
end
