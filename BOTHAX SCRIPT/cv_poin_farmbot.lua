delay = 100


SendPacket(2,"action|input\ntext|`2SC `bCV POIN TO FARMING BOT `2BY `cROCKYBANDEL")
Sleep(500)
LogToConsole("`cDelay = "..delay)

while true do
SendPacket(2,"action|dialog_return|\ndialog_name|activity_purchase|\noffer|4|")
Sleep(delay)
end
