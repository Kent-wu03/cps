
-- do not touch
SendPacket(2,"action|input|\ntext|`^Sc Auto Geiger By `bSekrip Cepees")
startsc = [[
set_default_color||
add_label_with_icon|big|`cAuto Geiger V1|left|2204|
add_label_with_icon|small|`cScript by sekrip cepees|left|482|
add_spacer|small|
add_url_button||`cSekrip Cepees``|NOFLAGS|https://whatsapp.com/channel/0029Vazh2wZD8SDozKXjIe1y|`^Link Saluran Sekrip cepees.|0|0|
add_quick_exit||
end_dialog|c|Exit|
        ]]
   SendVariantList{[0] = "OnDialogRequest", [1] = startsc}

listreward = {
	rc = 2242,
	wc = 2248,
	blackc = 2250,
	gc = 2244,
	bluec = 2246,
	hchem= 1962,
	rchem = 2206,
	dbat = 3306,
	gtoken = 1486
}

uselessitem = {
	pst = 1498,
	orenst = 1500,
	gst = 2804,
	bluest = 2806,
	blackst = 8274,
	wst = 8272,
	batre = 15250
}

bestspot = {
  {4, 26},
  {24, 26},
  {24, 2},
  {4, 2},
  {14, 26},
  {14, 2}
}
fsig = false
yellsig = 1
greensig = 2
redsig = 0
carisignal = redsig
world_name = GetWorld().name or "Unknown"

function limittp(num)
  return math.max(0, math.min(num, 28))
end

function cd()
  while not fsig do
    Sleep(150)
  end
  fsig = false
end

function getyellsig()
  teles = 2
  if px <= 14 then
  end
  teleright = true
  if py <= 14 then
  end
  teledown = true
  while true do
    if teleright then
      px = limittp(px - teles)
      FindPath(px, py)
      teleright = false
    else
      px = limittp(px + teles)
      FindPath(px, py)
      teleright = true
    end
    cd()
    if carisignal ~= yellsig then
      break
    end
    if teleright then
      px = limittp(px - teles)
      FindPath(px, py)
      teleright = false
    else
      px = limittp(px + teles)
      FindPath(px, py)
      teleright = true
    end
    cd()
    if carisignal ~= yellsig then
      break
    end
    teles = teles + 2
  end
  if carisignal == redsig then
    if teleright then
      px = limittp(px - 12)
      FindPath(px, py)
      cd()
      if carisignal ~= greensig then
        if py >= 20 then
          py = limittp(py - 8)
          FindPath(px, py)
        else
          py = limittp(py + 8)
          FindPath(px, py)
        end
        return
      end
    else
      px = limittp(px + 12)
      FindPath(px, py)
      cd()
      if carisignal ~= greensig then
        if py >= 20 then
          py = limittp(py - 8)
          FindPath(px, py)
        else
          py = limittp(py + 8)
          FindPath(px, py)
        end
        return
      end
    end
    Sleep(10000)
  elseif carisignal == greensig then
    if teleright then
      px = limittp(px + 4)
      FindPath(px, py)
    else
      px = limittp(px - 4)
      FindPath(px, py)
    end
    Sleep(10000)
  end
  teles = 1
  while true do
    if teledown then
      py = limittp(py - teles)
      FindPath(px, py)
      teledown = false
    else
      py = limittp(py + teles)
      FindPath(px, py)
      teledown = true
    end
    cd()
    if carisignal ~= greensig then
      break
    end
    if teledown then
      py = limittp(py - teles)
      FindPath(px, py)
      teledown = false
    else
      py = limittp(py + teles)
      FindPath(px, py)
      teledown = true
    end
    cd()
    if carisignal ~= greensig then
      break
    end
    teles = teles + 1
  end
  if carisignal == yellsig then
    if teledown then
      py = limittp(py - 5)
      FindPath(px, py)
    else
      py = limittp(py + 5)
      FindPath(px, py)
    end
    Sleep(10000)
  end
end

function getgreensig()
  teles = 1
  teleright = px <= 14 and true or false
  teledown = py <= 14 and true or false
  while true do
    if teleright then
      px = limittp(px - teles)
      FindPath(px, py)
      teleright = false
    else
      px = limittp(px + teles)
      FindPath(px, py)
      teleright = true
    end
    cd()
    if carisignal ~= greensig then
      break
    end
    if teleright then
      px = limittp(px - teles)
      FindPath(px, py)
      teleright = false
    else
      px = limittp(px + teles)
      FindPath(px, py)
      teleright = true
    end
    cd()
    if carisignal ~= greensig then
      break
    end
    teles = teles + 1
  end
  if carisignal == yellsig then
    if teleright then
      px = limittp(px - 5)
      FindPath(px, py)
    else
      px = limittp(px + 5)
      FindPath(px, py)
    end
    Sleep(10000)
  end
  teles = 1
  while true do
    if teledown then
      py = limittp(py - teles)
      FindPath(px, py)
      teledown = false
    else
      py = limittp(py + teles)
      FindPath(px, py)
      teledown = true
    end
    cd()
    if carisignal ~= greensig then
      break
    end
    if teledown then
      py = limittp(py - teles)
      FindPath(px, py)
      teledown = false
    else
      py = limittp(py + teles)
      FindPath(px, py)
      teledown = true
    end
    cd()
    if carisignal ~= greensig then
      break
    end
    teles = teles + 1
  end
  if carisignal == yellsig then
    if teledown then
      py = limittp(py - 5)
      FindPath(px, py)
    else
      py = limittp(py + 5)
      FindPath(px, py)
    end
    Sleep(10000)
  end
end

function inv(id)
  for _, item in pairs(GetInventory()) do
    if item.id == id then
      return item.amount
    end
  end
  return 0
end

function trash_useless(id)
  SendPacket(2, [[
action|dialog_return
dialog_name|trash
item_trash|]] .. id .. [[
|
item_count|]] .. inv(id) .. "\n")
  Sleep(1000)
end

geiger_redi = pcall(inv) and inv(2204) or 0
geiger_ded = pcall(inv) and inv(2286) or 0


function go_trash()
  for i, item in pairs(uselessitem) do
    if inv(item) >= 15 then
      trash_useless(item)
      Sleep(500)
    end
  end
end

function go_bestspot()
  for _, tile in ipairs(bestspot) do
    if carisignal ~= redsig then
      break
    end
    px, py = tile[1], tile[2]
    FindPath(px, py)
    cd()
  end
end

Sleep(1000)
AddHook("onprocesstankupdatepacket", "OnIncomingRawPacket", function(pkt)
  if 17 == pkt.type then
    if 2.0 == pkt.xspeed then
      carisignal = greensig
      LogToConsole("`^Find `2green `^signal")
      fsig = true
    elseif 1.0 == pkt.xspeed then
      carisignal = yellsig
      LogToConsole("`^Find `9yellow `^signal")
      fsig = true
    else
      carisignal = redsig
      LogToConsole("`^Find `4red `^signal")
      fsig = true
    end
  end
end)
while true do
  go_bestspot()
  if carisignal == yellsig then
    getyellsig()
  elseif carisignal == greensig then
    getgreensig()
  end
  go_trash()
end
