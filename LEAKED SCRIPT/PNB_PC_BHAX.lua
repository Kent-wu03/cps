-- for android but i convert to pc
--[Recommended use /ghost]
--[Background ID of Magplant]
MagBG = 12840

--[Sit PNB Coordinate XY]
SitX, SitY = 47, 197

--[No Gems Drop][true/false]
NoGemsDrop = true

--[Auto Convert DL][true/false]
AutoConvertDL = false

--[Delay Convert DL][Secon]
DelayConvertDL = 5

--[Telephone Coordinate XY]
TelX, TelY = 161, 198

--[Auto Suck Gems][true/false]
AutoSuckGems = false

--[Delay On/Off Cheat][number]
DelayCheat = 5

--[Delay Take Remote][number]
DelayRemote = 2

--[Role Account][true/false]
RoleMVP = true
RoleMOD = false

--[Ignore Other Completely][true/false]
IgnoreCompletely = false

--[Locked Camera][true/false][Use /ghost]
LockedCamera = false

--[Consumables][true/false]
ConsumeItemID = {1056, 4604}

--[Webhook PNB][true/false]
--[Enable MakeRequest & os Bothax API for Webhook PNB]
WebhookPNB = true
WebhookLink = "https://discord.com/api/webhooks/1366409964536729764/-eEWTdN8Ief-IBtj1KloxtcKOevutqnjaC_U59qlOLoa7b0UTKJ-hwtgcf3dtaEo4Ol_"

--[New Version Bothax Android][true/false][beta]
NewVersionBothax = false

  DelayConvertDL = DelayConvertDL or 0
  WorldName = GetWorld().name or "Unknown"
  Nick = GetLocal().name:gsub("`(%S)", ""):match("%S+")
  if AutoSuckGems then
  end
  NoGemsDrop = NoGemsDrop
  PinkGems = GetItemInfo("Pink Gemstone").id
  CheckIgnore = IgnoreCompletely and 1 or 0
  BlackGems = GetItemInfo("Black Gems").id
  DelayConvertBlack = DelayConvertDL * 50
  if RoleMOD then
  end
  RoleMVP = RoleMVP
  DelayConvertBGL = DelayConvertDL * 20
  CheckGems = NoGemsDrop and 1 or 0
  StartTime = os and os.time() or 0
  Count = 1
  Now = 1
  GetRemote = false
  CheatOff = false
  CheatOn = false
  Ghost = false
  MagW = false
  Speed = 0
  RemoveHooks()
  
  function inv(id)
    for _, item in pairs(GetInventory()) do
      if item.id == id then
        return item.amount
      end
    end
    return 0
  end
  
  function obj(id)
    local total = 0
    for _, object in pairs(GetObjectList()) do
      if object.id == id then
        total = total + object.amount
      end
    end
    return total
  end
  
  PGems = pcall(obj) and obj(PinkGems) or 0
  BGems = pcall(obj) and obj(BlackGems) or 0
  Songpyeon = pcall(inv) and inv(1056) or 0
  Clover = pcall(inv) and inv(528) or 0
  Arroz = pcall(inv) and inv(4604) or 0
  BLK = pcall(inv) and inv(11550) or 0
  BGL = pcall(inv) and inv(7188) or 0
  DL = pcall(inv) and inv(1796) or 0
  TotalLocks = tonumber(BLK .. BGL .. DL)
  LockBefore = TotalLocks
  BGems = pcall(obj) and obj(BlackGems) or BGems
  BGemsBefore = BGems
  
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
  if NewVersionBothax then
    InvisiblePNB = true
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
  
  function SendWebhook(url, data)
    if NewVersionBothax then
      MakeRequest(url, "POST", {
        ["Content-Type"] = "application/json"
      }, data)
    else
      MakeRequest(url, "POST", {
        ["Content-Type"] = "application/json"
      }, data)
    end
  end
  
  function onvariant(var)
    if "OnSDBroadcast" == var[0] then
      if RoleMVP then
        SendPacket(2, [[
action|input
|text|/radio]])
      end
    elseif "OnTalkBubble" == var[0] and var[2]:find("You received a MAGPLANT 5000 Remote") then
      GetRemote = true
      CheatOn = true
      Count = 1
    elseif "OnTalkBubble" == var[0] and var[2]:find("The MAGPLANT 5000 is empty") and not CheatOff then
      GetRemote = false
      CheatOff = true
      MagW = false
      Count = 1
    elseif "OnConsoleMessage" == var[0] and var[1]:find("Where would you like to go") then
      MagW = false
      GetRemote = false
      SendPacket(3, [[
action|join_request
name|]] .. WorldName .. [[
|
invitedWorld|0]])
    elseif "OnConsoleMessage" == var[0] and var[1]:find("World Locked") then
      if var[1]:find(WorldName) then
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
    elseif "OnDialogRequest" == var[0] and not GetRemote then
      if var[1]:find("ACTIVE") and var[1]:find(Mag[Now].x .. "\n") and var[1]:find(Mag[Now].y .. "\n") then
        if var[1]:find("Seed") then
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
      elseif var[1]:find("DISABLED") and var[1]:find(Mag[Now].x .. "\n") and var[1]:find(Mag[Now].y .. "\n") then
        if WebhookPNB and Now == #Mag then
          SendWebhook(WebhookLink, "{\"content\": \"<@" .. DiscordID .. "> PNB Magplants is Empty!\"}")
        end
        Now = Now == #Mag and 1 or Now + 1
        FindTP(Mag[Now].x, Mag[Now].y - 1)
      end
    elseif "OnConsoleMessage" == var[0] and var[1]:find("Radio disabled,") and not RoleMVP then
      SendPacket(2, [[
action|input
|text|/radio]])
      return true
    elseif "OnConsoleMessage" == var[0] and var[1]:find("Spam detected!") and not RoleMVP then
      SendPacket(2, [[
action|input
|text|/radio]])
      return true
    elseif not (not ("OnConsoleMessage" == var[0] and var[1]:find("from")) or RoleMVP) or "OnNameChanged" == var[0] and RoleMVP then
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
  
  function FNum(num)
    num = tonumber(num)
    if num >= 1.0E9 then
      return string.format("%.2fB", num / 1.0E9)
    elseif num >= 1000000.0 then
      return string.format("%.1fM", num / 1000000.0)
    elseif num >= 1000.0 then
      return string.format("%.0fK", num / 1000.0)
    else
      return tostring(num)
    end
  end
  
  function FTime(sec)
    days = math.floor(sec / 86400)
    hours = math.floor(sec % 86400 / 3600)
    minutes = math.floor(sec % 3600 / 60)
    seconds = math.floor(sec % 60)
    if days > 0 then
      return string.format("%sd %sh %sm %ss", days, hours, minutes, seconds)
    elseif hours > 0 then
      return string.format("%sh %sm %ss", hours, minutes, seconds)
    elseif minutes > 0 then
      return string.format("%sm %ss", minutes, seconds)
    elseif seconds >= 0 then
      return string.format("%ss", seconds)
    end
  end
  
  function SendInfoPNB()
    math.randomseed(os.time())
    PGems = pcall(obj) and obj(PinkGems) or PGems
    BGems = pcall(obj) and obj(BlackGems) or BGems
    Songpyeon = pcall(inv) and inv(1056) or Songpyeon
    Clover = pcall(inv) and inv(528) or Clover
    Arroz = pcall(inv) and inv(4604) or Arroz
    BLK = pcall(inv) and inv(11550) or BLK
    BGL = pcall(inv) and inv(7188) or BGL
    DL = pcall(inv) and inv(1796) or DL
    if NoGemsDrop then
      if AutoConvertDL then
        TotalLocks = tonumber(BLK .. BGL .. DL)
        Speed = string.format("%.2f DL", (TotalLocks - LockBefore) / 30)
        LockBefore = TotalLocks
      end
    else
      if BGems >= BGemsBefore * 1.5 then
        Speed = string.format("%.2f BG", (BGems - BGemsBefore) / 30)
      else
        Speed = string.format("%.2f BG", BGems / 30)
      end
      BGemsBefore = BGems
    end
    Payload = [[
{"embeds": [{
"author": {"name": "PNB VIP BOTHAX ANDROID",
"icon_url": "https://i.imgur.com/EVbdcT3.png"},
"fields": [{"name": ":identification_card: Account",
"value": "]] .. Nick .. [[
",
"inline": true},
{"name": ":earth_asia: World",
"value": "]] .. WorldName .. [[
",
"inline": true},
{"name": ":atom: Magplant",
"value": "]] .. Now .. " of " .. #Mag .. [[
",
"inline": true},
{"name": ":pill: Consumables",
"value": "]] .. Songpyeon .. " :crescent_moon: " .. Clover .. " :four_leaf_clover: " .. Arroz .. [[
 :poultry_leg:",
"inline": true},
{"name": ":lock: Total Locks",
"value": "]] .. BLK .. "**BLK** " .. BGL .. "**BGL** " .. DL .. [[
**DL**",
"inline": true},
{"name": ":gem: Gems Drop",
"value": "]] .. FNum(BGems) .. "**BG** " .. FNum(PGems) .. [[
**PG**",
"inline": true},
{"name": ":zap: Speed Farm",
"value": "]] .. Speed .. [[
/min",
"inline": true}],
"footer": {"text": "Uptime : ]] .. FTime(os.time() - StartTime) .. [[
"},
"color": ]] .. math.random(0, 16777215) .. [[
}]
}]]
    SendWebhook(WebhookLink, Payload)
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
      Sleep(1500)
      if WebhookPNB then
        SendInfoPNB()
      end
      Sleep(1500)
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
add_label_with_icon|big|`2PNB VIP BooLua||5638|
add_spacer|small|
add_textbox|]] .. GetLocal().name:match("%S+") .. [[
||
add_textbox|]] .. teks .. [[
||
add_spacer|small|
add_smalltext|`9BooLua SC! Join now!|
add_url_button||`qDiscord``|NOFLAGS|https://discord.gg/Any9dcWNwE|`$BooLua SC.|0|0|
add_quick_exit|]]
    if NewVersionBothax then
      SendVariantList({
        [0] = Var0,
        [1] = Var1
      })
    else
      SendVariantList({
        [0] = Var0,
        [1] = Var1
      })
    end
  end
  
  if os or not WebhookPNB then
    if 0 == #Mag then
      dialog("`9Please Set Magplant Background")
    else
      dialog("`8Thanks for buy")
      Sleep(1000)
      AddHook("onvariant", "onvariant", onvariant)
      Sleep(1000)
      if HideAnimation and NewVersionBothax then
        AddHook("onprocesstankupdatepacket", "OnIncomingRawPacket", function(pkt)
          if 3 == pkt.type or 8 == pkt.type or 14 == pkt.type or 17 == pkt.type then
            return true
          end
        end)
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
  else
    dialog("`9Turn On API MakeRequest & os for Webhook PNB")
  end
error("Powered by BooLua")
