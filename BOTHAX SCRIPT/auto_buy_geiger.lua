local howmany = 2
local delay = 100

for i = 1, howmany do
SendPacket(2,"action|buy\nitem|buy_geigercounter")
Sleep(delay)
end
