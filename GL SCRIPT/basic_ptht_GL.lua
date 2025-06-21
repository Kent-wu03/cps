-- kenapa basic? karna gaada auto reconnect take mag ehen empty
CountPTHT = 2
--Berapa Kali

DelayPT = 100
-Delay Tanam

DelayHT = 300
-Delay Panen

AntiCrash = true
-Buat hidupin anti crash ketika ptht untuk mencegah crash

NoDrop = true













countUws = 0
Looping = 0
ey = GetLocal().posY//32
function path(x, y, state)
SendPacketRaw(false, {state = state, px = x, py = y, x = x*32,  y = y*32}) end
function h2(x, y, id)
SendPacketRaw(false,{type = 3, value = id, px = x, py = y, x = x*32, y= y*32}) end
function getTree()
local count = 0
for y = ey, 0, -1 do
for x = 0, 199, 1 do
if GetTile(x, y).fg == 0 and (GetTile(x, y + 1).fg ~= 0 and GetTile(x, y + 1).fg % 2 == 0) then
count = count + 1
			end
		end
	end
	return count
end
function getReady()
	local ready = 0
	for y = ey, 0, -1 do
		for x = 0, 199, 1 do
			if GetTile(x, y).fg == 14767 and GetTile(x, y).readyharvest then
				ready = ready + 1
			end
		end
	end
	return ready
end
function harvest()
	if getReady() > 0 then
		for y = ey, 0, -1 do
LogToConsole("`9" .. os.date("%H`0:`9%M`0:`9%S") .."  `4R`2O`3C`4K`2Y  `4HT `0on `2Line```c = ```9" .. y)
			for x = 0, 199, 1 do
				if (GetTile(x, y).fg == 14767 and GetTile(x, y).readyharvest) then
					path(x, y, 5640)
					Sleep(100)
					h2(x, y, 18)
					Sleep(DelayHT)
				end
			end
		end
	end
end
function var(var)
if var.v1 == "OnDialogRequest" then
return true
end
end
AddHook(var, "Onvariant")
function uws()
	if getTree() == 0 then
		Sleep(500) 
		SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray") 
countUws = countUws + 1
        Sleep(500)
        SendPacket(2, "action|input\ntext|`2UWS `4TERPAKAI `0= `0[ `2".. countUws .." `0// `2".. CountPTHT .." `0]")
		Sleep(2000) 
		harvest() 
	elseif getTree() ~= 0 then 
		plant() 
		Sleep(1000)
	end
end
function plant()
	if getReady() < 20000 then
		for y = ey, 0, -1 do
LogToConsole("`9" .. os.date("%H`0:`9%M`0:`9%S") .." `cMENARI`#SCRIPT `4Planting `0on `2Line```c = ```9" .. y)
			for x = 0, 199, 10 do
				if GetTile(x,y).fg == 0 and (GetTile(x,y+1).fg ~= 0 and GetTile(x,y+1).fg %2 == 0) then
					path(x, y, 32)
					Sleep(1)
					h2(x, y, 5640)
					Sleep(DelayPT)
				end
			end
			for x = 199, 0, -1 do
				if GetTile(x,y).fg == 0 and (GetTile(x,y+1).fg ~= 0 and GetTile(x,y+1).fg %2 == 0) then
					path(x, y, 48)
					Sleep(1)
					h2(x, y, 5640)
					Sleep(DelayPT)
				end
			end
		end
	end
	uws()
end

for i = 1, 1 do
	SendPacket(2, "action|input\ntext| `4P`2R`3E`4M`2I`3U`4M `2PT`9HT `2BY `4R`2O`3C`4K`2Y ")
	Sleep(1000)
end

if (AntiCrash == true) then
    EditToggle("Anti Lag", true)
    Sleep(200)
    EditToggle("Invisible V1", true)
    Sleep(200)
    EditToggle("Invisible V2", true)
    Sleep(200)
    EditToggle("Fix Private Server Crash", true)
    Sleep(200)
    EditToggle("Disable Auto Gravity", true)
    Sleep(200)
    EditToggle("Disable Auto ModZoom", true)
end

if (NoDrop == true) then
    SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_gems|1")
end


for i = 1, CountPTHT do
Sleep(200)
	harvest() 
Sleep(200)
  harvest()
   Sleep(200)
   plant()
   Sleep(500)
   harvest()
	Looping = Looping + 1
	SendPacket(2, "action|input\ntext| `0[ `cDone PTHT =  "..Looping.."`0// `2"..CountPTHT.."`0 ] (grin) ")
end
