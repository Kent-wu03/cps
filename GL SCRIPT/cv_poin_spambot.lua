delay = 10


SendPacket(2,"action|input\ntext|`2SC `bCV POIN TO SPAMMER BOT `2BY `cROCKYBANDEL")
Sleep(500)
LogToConsole("`cDelay = "..delay)

while true do
SendPacket(2,"action|dialog_return|\ndialog_name|activity_purchase|\noffer|3|")
Sleep(delay)
end
