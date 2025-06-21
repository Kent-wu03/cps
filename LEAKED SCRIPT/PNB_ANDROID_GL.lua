
--[Recommended use /ghost]

--[World Name]
WorldName = "START"

--[Background ID of Magplant]
MagBG = 5724

--[Sit PNB Coordinate XY]
SitX, SitY = 20, 192

--[No Gems Drop][true/false]
NoGemsDrop = true

--[Auto Convert DL][true/false]
AutoConvertDL = true

--[Delay Convert DL][Secon]
DelayConvertDL = 5

--[Telephone Coordinate XY]
TelX, TelY = 20, 191

--[Auto Suck Gems][true/false]
AutoSuckGems = false

--[Delay Remote][number]
DelayRemote = 5

--[Role Account][true/false]
RoleMVP = false
RoleMOD = false

--[Hide Animation][true/false]
--[Only Support NewVersionGL]
HideAnimation = false

--[Ignore Other Completely][true/false]
IgnoreCompletely = false

--[Invisible PNB][true/false][Use /ghost]
InvisiblePNB = false

--[Consume ItemID][number]
ConsumeItemID = {528, 4604, 1474}

--[Version Growlauncher][true/false]
GLv363 = true
GLv506 = false
NewVersionGL = false

  DelayConvertDL = DelayConvertDL or 0
  WorldName = WorldName and string.upper(WorldName) or "Unknown"
  if AutoSuckGems then
  end
  NoGemsDrop = NoGemsDrop
  CheckIgnore = IgnoreCompletely and 1 or 0
  DelayConvertBlack = DelayConvertDL * 50
  if RoleMOD then
  end
  RoleMVP = RoleMVP
  DelayConvertBGL = DelayConvertDL * 20
  CheckGems = NoGemsDrop and 1 or 0
  Count = 1
  Now = 1
  GetRemote = false
  CheatOff = false
  CheatOn = false
  Ghost = false
  MagW = false
  
  function GetMag(a, b)
    tile = {}
    for y = b, 0, -1 do
      for x = a, 0, -1 do
        if GetTile(x, y).fg == 5638 and GetTile(x, y).bg == MagBG then
          table.insert(tile, {x = x, y = y})
        end
      end
    end
    return tile
  end
  
  function FindTP(x, y)
    if InvisiblePNB then
      SendPacketRaw(false, {
        state = 32,
        x = x * 32,
        y = y * 32
      })
    else
      FindPath(x, y)
    end
  end
  
  if GetTile(209, 0) then
    Mag = GetMag(209, 209)
  elseif GetTile(199, 0) then
    Mag = GetMag(199, 199)
  elseif GetTile(149, 0) then
    Mag = GetMag(149, 149)
  elseif GetTile(99, 0) then
    Mag = GetMag(99, 59)
  elseif GetTile(29, 0) then
    Mag = GetMag(29, 29)
  end
  
  function Wrench(x, y)
    SendPacketRaw(false, {
      type = 3,
      state = 32,
      value = 32,
      px = x,
      py = y,
      x = x * 32,
      y = y * 32
    })
  end
  
  function onvariant(var)
    if var.v1 == "OnSDBroadcast" then
      if RoleMVP then
        SendPacket(2, [[
action|input
|text|/radio]])
      end
    elseif var.v1 == "OnTalkBubble" and var.v3:find("You received a MAGPLANT 5000 Remote") then
      GetRemote = true
      CheatOn = true
      Count = 1
    elseif var.v1 == "OnTalkBubble" and var.v3:find("The MAGPLANT 5000 is empty") and not CheatOff then
      GetRemote = false
      CheatOff = true
      MagW = false
      Count = 1
    elseif var.v1 == "OnConsoleMessage" and var.v2:find("Where would you like to go") and not NewVersionGL then
      MagW = false
      GetRemote = false
      SendPacket(3, [[
action|join_request
name|]] .. WorldName .. [[
|
invitedWorld|0]])
    elseif var.v1 == "OnConsoleMessage" and var.v2:find("World Locked") then
      if var.v2:find(WorldName) then
        Count = 1
        MagW = false
        GetRemote = false
      else
        MagW = false
        GetRemote = false
        if not RoleMOD then
          Ghost = true
        end
        SendPacket(3, [[
action|join_request
name|]] .. WorldName .. [[
|
invitedWorld|0]])
      end
    elseif var.v1 == "OnDialogRequest" and not GetRemote then
      if var.v2:find("Welcome back") and NewVersionGL then
        MagW = false
        GetRemote = false
        SendPacket(3, [[
action|join_request
name|]] .. WorldName .. [[
|
invitedWorld|0]])
      elseif var.v2:find("ACTIVE") and var.v2:find(Mag[Now].x .. "\n") and var.v2:find(Mag[Now].y .. "\n") then
        if var.v2:find("Seed") then
          Now = Now == #Mag and 1 or Now + 1
          FindTP(Mag[Now].x, Mag[Now].y - 1)
        else
          SendPacket(2, [[
action|dialog_return
dialog_name|magplant_edit
x|]] .. Mag[Now].x .. [[
|
y|]] .. Mag[Now].y .. [[
|
buttonClicked|getRemote
]])
          FindTP(SitX, SitY)
        end
      elseif var.v2:find("DISABLED") and var.v2:find(Mag[Now].x .. "\n") and var.v2:find(Mag[Now].y .. "\n") then
        Now = Now == #Mag and 1 or Now + 1
        FindTP(Mag[Now].x, Mag[Now].y - 1)
      end
    elseif var.v1 == "OnConsoleMessage" and var.v2:find("Radio disabled,") and not RoleMVP then
      SendPacket(2, [[
action|input
|text|/radio]])
      return true
    elseif var.v1 == "OnConsoleMessage" and var.v2:find("Spam detected!") and not RoleMVP then
      SendPacket(2, [[
action|input
|text|/radio]])
      return true
    elseif not (not (var.v1 == "OnConsoleMessage" and var.v2:find("from")) or RoleMVP) or var.v1 == "OnNameChanged" and RoleMVP then
      if GetRemote then
        if CheatOn then
          if 0 == Count % (DelayRemote * 2) then
            CheatOn = false
            SendPacket(2, [[
action|dialog_return
dialog_name|cheats
check_autofarm|1
check_bfg|1
check_gems|]] .. CheckGems .. [[

check_lonely|]] .. CheckIgnore .. [[

check_ignoreo|]] .. CheckIgnore .. [[

check_ignoref|]] .. CheckIgnore)
          end
          Count = Count + 1
        elseif AutoConvertDL then
          if 0 == Count % DelayConvertBlack then
            SendPacket(2, [[
action|dialog_return
dialog_name|info_box
buttonClicked|make_bgl]])
          elseif 0 == Count % DelayConvertBGL then
            SendPacket(2, [[
action|dialog_return
dialog_name|telephone
num|53785|
x|]] .. TelX .. [[
|
y|]] .. TelY .. [[
|
buttonClicked|bglconvert]])
          elseif 0 == Count % DelayConvertDL then
            SendPacket(2, [[
action|dialog_return
dialog_name|telephone
num|53785|
x|]] .. TelX .. [[
|
y|]] .. TelY .. [[
|
buttonClicked|dlconvert]])
          end
          Count = Count + 1
        end
      elseif CheatOff then
        if 0 == Count % (DelayRemote * 2) then
          CheatOff = false
          SendPacket(2, [[
action|dialog_return
dialog_name|cheats
check_autofarm|0
check_bfg|0
check_gems|1
check_lonely|]] .. CheckIgnore .. [[

check_ignoreo|]] .. CheckIgnore .. [[

check_ignoref|]] .. CheckIgnore)
        end
        Count = Count + 1
      elseif MagW then
        Wrench(Mag[Now].x, Mag[Now].y)
      else
        if 0 == Count % (DelayRemote * 3) and not Ghost then
          FindTP(Mag[Now].x, Mag[Now].y - 1)
          MagW = true
        elseif 0 == Count % (DelayRemote * 2) and Ghost then
          Ghost = false
          SendPacket(2, [[
action|input
|text|/ghost]])
        end
        Count = Count + 1
      end
    end
    return false
  end
  
  function Consumes()
    if GetRemote then
      for _, item in pairs(ConsumeItemID) do
        for i = 1, 3 do
          SendPacketRaw(false, {
            type = 3,
            value = item,
            px = SitX,
            py = SitY,
            x = SitX * 32,
            y = SitY * 32
          })
          Sleep(200)
        end
      end
      Sleep(3000)
      if AutoSuckGems then
        for i = 1, 3 do
          SendPacket(2, [[
action|dialog_return
dialog_name|popup
buttonClicked|bgem_suckall
]])
          Sleep(250)
        end
      end
      Sleep(1800000)
    else
      Sleep(5000)
    end
  end
  
  function dialog(teks)
    Var0 = "OnDialogRequest"
    Var1 = [[
add_label_with_icon|big|`crocky rocky PNB  ||5638|
add_spacer|small|
add_textbox|]] .. GetLocal().name:match("%S+") .. [[
||
add_textbox|]] .. teks .. [[
||
add_spacer|small|
add_smalltext|rocky Server.|
add_url_button||`eDiscord``|NOFLAGS|https://ero18x.com/manga/my-landlady-noona-english/chapter-121/|Join my noob server.|0|
add_quick_exit|]]
    if NewVersionGL then
      SendVariant({
        v1 = Var0,
        v2 = Var1
      })
    else
      SendVariant({
        v0 = Var0,
        v1 = Var1
      })
    end
  end
  
  if 0 == #Mag then
    dialog("`7Please Set Magplant Background")
  else
    dialog("`2Script is working!")
    Sleep(1000)
    if NewVersionGL then
      AddHook(function(type, str)
        if 3 == type and str:find("quit_to_exit") then
          return true
        end
      end, "onSendPacket")
      Sleep(1000)
    end
    AddHook(onvariant, NewVersionGL and "onVariant" or "OnVariant")
    Sleep(1000)
    if HideAnimation and NewVersionGL then
      AddHook(function(pkt)
        if 3 == pkt.type or 8 == pkt.type or 14 == pkt.type or 17 == pkt.type then
          return true
        end
      end, NewVersionGL and "onGamePacket" or "OnGamePacket")
      Sleep(1000)
    end
    if not RoleMVP then
      SendPacket(2, [[
action|input
|text|/radio]])
      Sleep(1000)
    end
    SendPacket(2, [[
action|dialog_return
dialog_name|cheats
check_autofarm|0
check_bfg|0
check_gems|1
check_lonely|]] .. CheckIgnore .. [[

check_ignoreo|]] .. CheckIgnore .. [[

check_ignoref|]] .. CheckIgnore)
    Sleep(1000)
    if RoleMVP or RoleMOD then
      SendPacket(2, [[
action|input
|text|/modage 30]])
      Sleep(1000)
    end
    while true do
      Consumes()
    end
  end
error("Powered by rocky")
