--[PTHT VIP BOOLUA BOTHAX ANDROID]
--[Use /ghost]

--[Seed ItemID]
SeedID = 15757

--[Background ID of Magplant]
MagBG = 3734

--[Start Count PTHT][number]
StartCount = 0

--[Total PTHT][number]
TotalPTHT = 1

--[Coordinate Y Bottom Plant/Plat/Gate/Door]
PlantY = math.floor(GetLocal().pos.y / 32)

--[Mode PTHT][true/false]
MirrorPlant = false
VerticalPlant = true

--[Delay Enter World][Milisecon]
DelayEntering = 5000

--[Delay Harvest][Milisecon][Recommended 200+]
DelayHarvest = 200

--[Delay Plant][Milisecon][Recommended 80+].
DelayPlant = 80

--[Delay UWS][Milisecon][Recommended 10000+].
DelayUWS = 5000

--[Max Miss Tree][Set to 0 for No Miss][Recommended 1000]
MissTree = 1000

--[Use Mray][true/false]
UseMRAY = true

--[Use UWS][true/false]
--[UseUWS = false for 2nd Acc]
UseUWS = true

--[Version Bothax Android][true/false]
NewVersionBothax = true

--[Webhook PTHT][true/false]
--[Enable MakeRequest & os Bothax API for Webhook PTHT]
WebhookPTHT = true
WebhookLink = "https://discord.com/api/webhooks/1352653604980265053/TeiwHPfXFoBWAPY_ms1reOB3tECesAVR1JxvjX1Ew0LWWOeeG3MqrBHJBCD4PK2SMABS"
DiscordID = 1234567890

  WorldName = GetWorld().name or "Unknown"
  TotalPTHT = UseUWS and TotalPTHT or true
  
  function TextOverlay(text)
    if NewVersionBothax then
      SendVariantList({
        [0] = "OnTextOverlay",
        [1] = text
      })
    else
      SendVariant({
        [0] = "OnTextOverlay",
        [1] = text
      })
    end
  end
  
  PlantY = (0 == GetTile(20, 0 == PlantY % 2 and 20 or 21).fg or GetTile(20, 0 == PlantY % 2 and 20 or 21).fg == SeedID) and PlantY or PlantY - 1
  Nick = GetLocal().name:gsub("`(%S)", ""):match("%S+")
  StartY = 0 == PlantY % 2 and 0 or 1
  StartTime = os and os.time() or 0
  PlantFar = UseMRAY and 10 or 1
  MissTree = MissTree / 10
  SprayUWS = StartCount
  RemoteEmpty = true
  PTHT = StartCount
  Harvest = true
  Plant = false
  RemoveHooks()
  Missed = 0
  Now = 1
  if GetTile(209, 0) then
    PlantX = 210
  elseif GetTile(199, 0) then
    PlantX = 200
  elseif GetTile(149, 0) then
    PlantX = 150
  elseif GetTile(99, 0) then
    PlantX = 100
  elseif GetTile(29, 0) then
    PlantX = 30
  end
  PlantX = MirrorPlant and PlantX - 1 or PlantX - PlantFar
  
  function SendWebhook(url, data)
    if NewVersionBothax then
      MakeRequest(url, "POST", {
        ["Content-Type"] = "application/json"
      }, data)
    else
      MakeRequests(url, "POST", {
        ["Content-Type"] = "application/json"
      }, data)
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
  
  function inv(id)
    for _, item in pairs(GetInventory()) do
      if item.id == id then
        return item.amount
      end
    end
    return 0
  end
  
  UWS = pcall(inv) and inv(12600) or 0
  
  function GetFarm()
    local tiles = {}
    for x = MirrorPlant and PlantX or 0, MirrorPlant and 0 or PlantX, MirrorPlant and -10 or 10 do
      for y = MirrorPlant and StartY or PlantY, MirrorPlant and PlantY or StartY, MirrorPlant and 2 or -2 do
        local tile1 = GetTile(x, y)
        local tile2 = GetTile(x, y + 1)
        local tilefg = tile1 and tile1.fg or -1
        local tileb = tile2 and tile2.fg or -1
        if 0 ~= tileb and (tilefg == SeedID or 0 == tilefg) then
          table.insert(tiles, {x = x, y = y})
        end
      end
    end
    return tiles
  end
  
  FarmTiles = GetFarm()
  
  function GetTree(int)
    if int then
      TotalTree = 0
      for _, tile in pairs(FarmTiles) do
        local tile1 = GetTile(tile.x, tile.y)
        local tilefg = tile1 and tile1.fg or -1
        local tiler = tilefg == SeedID and tile1.extra.progress or -1
        if tilefg == SeedID and 1 == tiler then
          TotalTree = TotalTree + 1
        end
      end
      return TotalTree
    else
      TotalLand = 0
      for _, tile in pairs(FarmTiles) do
        local tile1 = GetTile(tile.x, tile.y)
        local tilefg = tile1 and tile1.fg or -1
        if 0 == tilefg then
          TotalLand = TotalLand + 1
        end
      end
      return TotalLand
    end
  end
  
  function GetHarvest()
    local tiles = {}
    for x = MirrorPlant and PlantX or 0, MirrorPlant and 0 or PlantX, MirrorPlant and -PlantFar or PlantFar do
      for i = 1, 2 do
        for y = MirrorPlant and StartY or PlantY, MirrorPlant and PlantY or StartY, MirrorPlant and 2 or -2 do
          local tile1 = GetTile(x, y)
          local tile2 = GetTile(x, y + 1)
          local tilefg = tile1 and tile1.fg or -1
          local tileb = tile2 and tile2.fg or -1
          if 0 ~= tileb and (tilefg == SeedID or 0 == tilefg) then
            table.insert(tiles, {x = x, y = y})
          end
        end
      end
    end
    return tiles
  end
  
  HarvestTiles = GetHarvest()
  
  function GetVertical()
    local tiles = {}
    for x = MirrorPlant and PlantX or 0, MirrorPlant and 0 or PlantX, MirrorPlant and -PlantFar or PlantFar do
      for i = 1, 2 do
        for y = MirrorPlant and StartY or PlantY, MirrorPlant and PlantY or StartY, MirrorPlant and 2 or -2 do
          local tile1 = GetTile(x, y)
          local tile2 = GetTile(x, y + 1)
          local tilefg = tile1 and tile1.fg or -1
          local tileb = tile2 and tile2.fg or -1
          if 0 ~= tileb and (tilefg == SeedID or 0 == tilefg) then
            table.insert(tiles, {x = x, y = y})
          end
        end
      end
    end
  end
  
  VerticalTiles = GetVertical()
  
  function GetHorizontal()
    local tiles = {}
    for y = MirrorPlant and StartY or PlantY, MirrorPlant and PlantY or StartY, MirrorPlant and 2 or -2 do
      for i = 1, 2 do
        for x = MirrorPlant and PlantX or 0, MirrorPlant and 0 or PlantX, MirrorPlant and -PlantFar or PlantFar do
          local tile1 = GetTile(x, y)
          local tile2 = GetTile(x, y + 1)
          local tilefg = tile1 and tile1.fg or -1
          local tileb = tile2 and tile2.fg or -1
          if 0 ~= tileb and (tilefg == SeedID or 0 == tilefg) then
            table.insert(tiles, {x = x, y = y})
          end
        end
      end
    end
    return tiles
  end
  
  HorizontalTiles = GetHorizontal()
  
  function GetMag(a, b)
    tile = {}
    for y = 0, b do
      for x = 0, a do
        if GetTile(x, y).fg == 5638 and GetTile(x, y).bg == MagBG then
          table.insert(tile, {x = x, y = y})
        end
      end
    end
    return tile
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
  
  function Scanning()
    if Plant then
      Plant = false
      CheckLand = GetTree(false)
      if CheckLand <= MissTree then
        SprayUWS = SprayUWS + 1
        Missed = 0
        if UseUWS then
          TextOverlay("`2" .. SprayUWS .. " `wUWS Used")
          SendPacket(2, [[
action|dialog_return
dialog_name|ultraworldspray]])
          Sleep(DelayUWS)
          TextOverlay("Harvesting...")
          Harvest = true
        else
          Sleep(DelayUWS)
          TextOverlay("Checking Farm...")
          Plant = true
        end
      else
        TextOverlay("Checking Farm...")
        Plant = true
      end
      Sleep(2000)
    elseif Harvest then
      Harvest = false
      CheckTree = GetTree(true)
      if 0 == CheckTree then
        TextOverlay("Planting...")
        Plant = true
      else
        TextOverlay("Checking Tree...")
        Harvest = true
      end
      Sleep(2000)
    end
  end
  
  function GetRemote()
    SendPacketRaw(false, {
      px = Mag[Now].x,
      py = Mag[Now].y,
      x = Mag[Now].x * 32,
      y = Mag[Now].y * 32
    })
    Sleep(500)
    SendPacketRaw(false, {
      type = 3,
      value = 32,
      px = Mag[Now].x,
      py = Mag[Now].y,
      x = Mag[Now].x * 32,
      y = Mag[Now].y * 32
    })
    Sleep(500)
    SendPacket(2, [[
action|dialog_return
dialog_name|magplant_edit
x|]] .. Mag[Now].x .. [[
|
y|]] .. Mag[Now].y .. [[
|
buttonClicked|getRemote]])
    Sleep(5000)
  end
  
  function Loop()
    if VerticalPlant then
      for _, tile in pairs(Plant and VerticalTiles or HarvestTiles) do
        if pcall(GetTile) or RemoteEmpty then
          return
        else
          local tile1 = GetTile(tile.x, tile.y)
          local tilefg1 = tile1 and tile1.fg or -1
          local tiles = tilefg1 == SeedID and tile1.extra.progress or -1
          if Plant and 0 == tilefg1 or Harvest and 1 == tiles then
            SendPacketRaw(false, {
              state = MirrorPlant and 48 or 32,
              x = tile.x * 32,
              y = tile.y * 32
            })
            SendPacketRaw(false, {
              type = 3,
              value = Plant and 5640 or 18,
              state = MirrorPlant and 48 or 32,
              x = tile.x * 32,
              y = tile.y * 32,
              px = tile.x,
              py = tile.y
            })
            Sleep(Plant and DelayPlant or DelayHarvest)
            if Plant and (MirrorPlant and tile.x < PlantX or not MirrorPlant and tile.x > 0) then
              local tile2 = GetTile(MirrorPlant and tile.x + 1 or tile.x - 1, tile.y)
              local tilefg2 = tile2 and tile2.fg or -1
              if tilefg2 ~= SeedID then
                Missed = Missed + 1
              end
            end
          end
          if Missed >= 200 then
            Now = Now < #Mag and Now + 1 or 1
            Missed = 0
            RemoteEmpty = true
            return
          end
        end
      end
    else
      for _, tile in pairs(Plant and HorizontalTiles or HarvestTiles) do
        if pcall(GetTile) or RemoteEmpty then
          return
        else
          local tile1 = GetTile(tile.x, tile.y)
          local tilefg1 = tile1 and tile1.fg or -1
          local tiles = tilefg1 == SeedID and tile1.extra.progress or -1
          if Plant and 0 == tilefg1 or Harvest and 1 == tiles then
            SendPacketRaw(false, {
              state = MirrorPlant and 48 or 32,
              x = tile.x * 32,
              y = tile.y * 32
            })
            SendPacketRaw(false, {
              type = 3,
              value = Plant and 5640 or 18,
              state = MirrorPlant and 48 or 32,
              x = tile.x * 32,
              y = tile.y * 32,
              px = tile.x,
              py = tile.y
            })
            Sleep(Plant and DelayPlant or DelayHarvest)
            if Plant and (MirrorPlant and tile.y > StartY or not MirrorPlant and tile.y < PlantY) then
              local tile2 = GetTile(tile.x, MirrorPlant and tile.y - 2 or tile.y + 2)
              local tilefg2 = tile2 and tile2.fg or -1
              if tilefg2 ~= SeedID then
                Missed = Missed + 1
              end
            end
          end
          if Missed >= 200 then
            Now = Now < #Mag and Now + 1 or 1
            Missed = 0
            RemoteEmpty = true
            return
          end
        end
      end
    end
    if pcall(GetTile) then
      return
    else
      Scanning()
      if Plant and PTHT ~= SprayUWS then
        PTHT = PTHT + 1
        if UseUWS then
          if WebhookPTHT then
            math.randomseed(os.time())
            UWS = pcall(inv) and inv(12600) or UWS
            SendWebhook(WebhookLink, [[
{"embeds": [{
"author": {"name": "PTHT VIP BOTHAX ANDROID",
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
{"name": ":ear_of_rice: Status",
"value": "]] .. PTHT .. (type(TotalPTHT) == "number" and "/" .. TotalPTHT or "X") .. [[
 Done",
"inline": true},
{"name": ":squeeze_bottle: UWS",
"value": "]] .. UWS .. [[
**Pcs**",
"inline": true},
{"name": ":timer: Uptime",
"value": "]] .. FTime(os.time() - StartTime) .. [[
",
"inline": true}],
"color": ]] .. math.random(0, 16777215) .. [[
}]
}]])
          end
          SendPacket(2, [[
action|input
text|`2]] .. PTHT .. " `8PTHT Done")
        end
      end
    end
  end
  
  function Entering()
    if pcall(GetTile) then
      if WebhookPTHT then
        SendWebhook(WebhookLink, "{\"content\": \"<@" .. DiscordID .. "> " .. Nick .. " PTHT Reconnecting...\"}")
      end
      SendPacket(3, [[
action|join_request
name|]] .. WorldName .. [[
|
invitedWorld|0]])
      TextOverlay("Entering World...")
      Sleep(DelayEntering)
      RemoteEmpty = true
    else
      if RemoteEmpty then
        TextOverlay("Taking Remote...")
        GetRemote()
        RemoteEmpty = false
      end
      Loop()
    end
  end
  
  function dialog(teks)
    Var0 = "OnDialogRequest"
    Var1 = [[
add_label_with_icon|big|`2PTHT VIP BooLua||7064|
add_spacer|small|
add_textbox|]] .. GetLocal().name:match("%S+") .. [[
||
add_textbox|]] .. teks .. [[
||
add_spacer|small|
add_smalltext|`9BooLua SC! Join now!|
add_url_button||`qDiscord|NOFLAGS|https://discord.gg/Any9dcWNwE|`$BooLua SC.|0|0|
add_quick_exit|]]
    if NewVersionBothax then
      SendVariantList({
        [0] = Var0,
        [1] = Var1
      })
    else
      SendVariant({
        [0] = Var0,
        [1] = Var1
      })
    end
  end
  
  if os or not LogFilePTHT then
    if os or not WebhookPTHT then
      dialog("`8Thanks for buy")
      Sleep(200)
      SendPacket(2, [[
action|dialog_return
dialog_name|cheats
check_gems|1
]])
      Sleep(200)
      Scanning()
      Sleep(200)
      if type(TotalPTHT) == "number" then
        repeat
          Entering()
          if PTHT == TotalPTHT then
            LogToConsole("`9[BooLua] `^PTHT " .. PTHT .. "X Is DONE! `c#BooLua")
            Sleep(820)
            if WebhookPTHT then
              SendWebhook(WebhookLink, "{\"content\": \"<@" .. DiscordID .. "> PTHT " .. PTHT .. "X Is DONE!\"}")
            end
          end
        until PTHT == TotalPTHT
      elseif TotalPTHT then
        while true do
          Entering()
        end
      end
    else
      dialog("`9Turn On API MakeRequest & os for Webhook PTHT")
    end
  else
    dialog("`9Turn On API io & os for Log PTHT")
  end
