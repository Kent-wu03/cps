-- Please Don't Change it anyhing except in Customize!! (Jangan mengganti apapun kecuali yang ada di Customize)

Customize = {
  
  TreeID = 15461,

  World = {
    Name = " ",
  },
  
    Start = {
    Mode = "PTHT", -- ada 2 mode. "PTHT" (Plant & Harvest) dan "HTPT" (Harvest & Plant)
    Loop = 25, -- GAS = UNLI
    PosX = 0, -- ini biarin aja
    PosY = 192, -- wajib pake checker tiles yg ada di dc
    Direction = "DEPAN" -- "BACK = PLANT DARI BELAKANG, "DEPAN" PLANT DARI DEPAN
},
  
  Delay = {
    Harvest = 50, --- minimal 40. normal 50-100
    entering = 50, -- jangan diotak atik
    Plant = 10, -- minimal 10

  },
  
  Other = {
    Plant = "VERTICAL", -- ada 2 mode.. "HORIZONTAL" dan "VERTICAL" kusaranin make vertical lebih fast
    AntiLag = false,
    Mray = true, -- kalo bukan mray, ganti jadi false
    AutoHarvest = true, -- tambahkan ini untuk mengaktifkan/mematikan auto-harvest
    UseUWS = true, -- tambahkan ini untuk mengaktifkan/mematikan penggunaan UWS
  },
  
  Magplant = {
    Limit = 100, -- ini untuk delay detek empty magplant
    bgseed = 3734 -- id background
  },
}


GrowID = GetLocal().name

SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_gems|1\n")

function Raw(a, b, c, d, e)
  SendPacketRaw(false, 
  {
    type = a,
    state = b,
    value = c,
    px = d,
    py = e,
    x = d * 32,
    y = e * 32,
  })
end

local TotalTree = 0
function GetTree(str)
if Customize.Other.AutoHarvest then
  if str == a then
      local Total = 0
      for y = Customize.Start.PosY + 1, Customize.Start.PosY % 2 == 0 and 0 or 1, -2 do
        for x = Customize.Start.PosX, 0, 1 do
          if GetTile(x, y).fg ~= Customize.TreeID or 0 then
            Total = Total + 1
          end
        end
      end
      return Total
    else
      for y = Customize.Start.PosY, Customize.Start.PosY % 2 == 0 and 0 or 1, -2 do
        for x = Customize.Start.PosX, 199, 1 do
          if (Plant and GetTile(x, y).fg == Customize.TreeID) or (Harvest and GetTile(x, y).fg == Customize.TreeID and GetTile(x, y).readyharvest) then
            TotalTree = TotalTree + 1
          end
        end
      end
      return TotalTree
    end
  end
  return 0
end


function GetMagplant()
    local Found = {}
    for x = 0, 199 do
        for y = 0, 199 do
            local tile = GetTile(x, y)
            if tile.bg == Customize.Magplant.bgseed and tile.fg == 5638 then
                table.insert(Found, {x, y})
            end
        end
    end
    return Found
end



UWSUsed = 0
function ChangeMode()
  if Plant then
    Plant = false
    if Customize.Other.UseUWS and GetTree(b) >= GetTree(a) then
      SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`oTotal `2Used `c" .. UWSUsed .. " UWS"
    })
      SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray")
      Sleep(9500)
      SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`cHarvest `#Mode"
    })
    UWSUsed = UWSUsed + 1
    File = "storage/emulated/0/Android/data/launcher.powerkuy/ScriptLua/"
  local LogFile = io.open(File .. "EL log PTHT.lua", "a")
  if LogFile then 
      LogFile:write("Finished PTHT [" .. UWSUsed .."] At " .. os.date("%H:%M:%S") .. " UWS Used : " .. UWSUsed .."\n")
    end 
  Harvest = true
else
SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`9Scanning `4Missing `cPlant"
    })
        Plant = true
    end
    TotalTree = 0
    else
    Harvest = false
    if GetTree(a) >= GetTree(b) then
    SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`cPlant `#Mode"
    })
      Plant = true
      else
                  SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`9Scanning `4Missing `cHarvest"
    })
      Harvest = true
    end
    TotalTree = 0
  end
end
Current = 1


function GetRemote()
  Magplant = GetMagplant()
  Raw(0, 32, 0, Magplant[Current][1], Magplant[Current][2])
  Sleep(5 * 10^2)
  Raw(3, 0, 32, Magplant[Current][1], Magplant[Current][2])
  Sleep(5 * 10^2)
  SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. Magplant[Current][1] .. "|\ny|" .. Magplant[Current][2] .. "|\nbuttonClicked|getRemote")
  Sleep(5 * 10^3)
end


LogPTHT, PTHT = {}, 0 
function Rotation()
  if Customize.Other.Plant == "HORIZONTAL" then
    for y = Customize.Start.PosY, Customize.Start.PosY % 2 == 0 and 0 or 1, -2 do
      if GetWorldName() ~= Customize.World.Name or RemoteEmpty then
        return
        else
    LogToConsole("`2 " .. os.date("%H`b:`2%M`b:`2%S").." `4[`cGano`#EL`4] `cCurrently `5" .. (Plant and "Planting" or "Harvest") .. " `4On `9Y `8: `2" .. y)
        for Loop = 1, 2, 1 do
          for x = (Loop == 1 and Customize.Start.PosX or 199),
          (Loop == 1 and 199 or Customize.Start.PosX),
          (Customize.Other.Mray and (Loop == 1 and 10 or -1) or (Loop == 1 and 1 or -1)) do
            if GetWorldName() ~= Customize.World.Name or RemoteEmpty then
              return
              else
              if (Plant and GetTile(x, y).fg == 0) or (Harvest and GetTile(x, y).fg == Customize.TreeID and GetTile(x, y).readyharvest) then
                Raw(0, 128, 0, x, y)
                Raw(3, (Loop == 1 and 32 or 48), (Plant and 5640 or 18), x, y)
                Sleep(Plant and Customize.Delay.Plant * 10 or Customize.Delay.Harvest * 10)
                if GetWorldName() ~= Customize.World.Name or RemoteEmpty then
                  return
                  else
                  px = (Loop == 1 and math.max(x - 2, 0) or math.min(x + 2, 199))
                  if (Plant and GetTile(px, y).fg == Customize.TreeID) then
                    Limiter = 0 
                    else
                    if (Plant and GetTile(px, y).fg ~= Customize.TreeID) then
                      Limiter = Limiter + 1
                    end
                  end
                end
              end
              if Limiter >= Customize.Magplant.Limit then
                Magplant = GetMagplant()
                Current = Current + 1
                if Current > #Magplant then
                  Current = 1
                end
                Limiter = 0
                RemoteEmpty = true
                return
              end
            end
          end
        end
      end
    end
    else
if Customize.Other.Plant == "VERTICAL" then
  local startPos, endPos, step
  if Plant then
    if Customize.Start.Direction == "BACK" then
      startPos, endPos, step = 190, 0, Customize.Other.Mray and -10 or -1
    elseif Customize.Start.Direction == "DEPAN" then
      startPos, endPos, step = 0, 190, Customize.Other.Mray and 10 or 1
    end
  else
    startPos, endPos, step = 0, 190, Customize.Other.Mray and 10 or 1
  end

  for x = startPos, endPos, step do
    if GetWorldName() ~= Customize.World.Name or RemoteEmpty then
      return
    else
      LogToConsole("`2 " .. os.date("%H`b:`2%M`b:`2%S").." `4[`cGano`#EL`4] `cCurrently `5" .. (Plant and "Planting" or "Harvest") .. " `4On `9X `8: `2" .. x)
      for Loop = 1, 2, 1 do
        for y = Customize.Start.PosY, Customize.Start.PosY % 2 == 0 and 0 or 1, -2 do
          if GetWorldName() ~= Customize.World.Name or RemoteEmpty then
            return
          else
            if (Plant and GetTile(x, y).fg == 0) or (Harvest and GetTile(x, y).fg == Customize.TreeID and GetTile(x, y).readyharvest) then
              Raw(0, 128, 0, x, y)
              Raw(3, 32, (Plant and 5640 or 18), x, y)
              Sleep(Plant and Customize.Delay.Plant * 10 or Customize.Delay.Harvest * 10)
              if GetWorldName() ~= Customize.World.Name or RemoteEmpty then
                return
              else
                py = math.min(y + 2, Customize.Start.PosY)
                if (Plant and GetTile(x, py).fg == Customize.TreeID) then
                  Limiter = 0
                else
                  if (Plant and GetTile(x, py).fg ~= Customize.TreeID) then
                    Limiter = Limiter + 1
                  end
                end
              end
            end
            if Limiter >= Customize.Magplant.Limit then
              Magplant = GetMagplant()
              Current = Current + 1
              if Current > #Magplant then
                Current = 1
              end
              Limiter = 0
              RemoteEmpty = true
              return
            end
          end
        end
      end
    end
  end
end
end
  
  
  if GetWorldName() ~= Customize.World.Name then
    return
    else 
    PTHT = PTHT + 1
    ChangeMode() 
  end
end

acaboo =
[[set_default_color||
add_label_with_icon|big|`oWelcome `b[ ]]..GrowID..[[ `b]|left|5212|
add_spacer|small|
add_textbox| DATE : `2]]..os.date("%d-%m-%Y")..[[|
add_textbox|   `oThanks for purchase this `2Custom PTHT MRAY with UWS`|
add_textbox|   `oOriginal script by : `cEL`#Group|
add_spacer|big|
add_url_button||`qDiscord Server ```w"```cGano`#EL `bScripts```w"``|NOFLAGS|https://discord.com/invite/NvmEdQfxYP|`wFree `9CreativePS `1Scripts `wfor `2GrowLauncher. `4JOIN NOW!!!``|0|0|
add_spacer|small|
add_label_with_icon|small|`wMake sure u already active /ghost command.|left|1432|
add_spacer|small|
add_label_with_icon|small|`wDon't make any moves after run the script!|left|1432|
add_spacer|small|
add_label_with_icon|small|`wStand on block with less animation to prevent lag or crash.|1432|
add_spacer|big|
add_label_with_icon|small|`wMore update coming soon...|left|9476|
add_spacer|small|
add_label_with_icon|small|`2Thanks To`` : ``|left|12158|
add_textbox|- `b@Piers `4[`cHelped`4]|left|
add_spacer|small|
end_dialog|c|ENJOY|]]

function textbox(txt)
    var = {}
    var.v0 = "OnDialogRequest"
    var.v1 = txt
    SendVariant(var)
end
textbox(acaboo)

Limiter = 0
function Reconnect()
  if GetWorldName() ~= Customize.World.Name then
        SendPacket(3, "action|join_request\nname|" .. Customize.World.Name .. "|\ninvitedWorld|0")
    SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`cEntering `#World `4: `2" .. Customize.World.Name
    })
    Sleep(Customize.Delay.entering * 10^2)
    RemoteEmpty = true
  else
    if RemoteEmpty then
    SendVariant({
      v0 = "OnTextOverlay", 
      v1 = "`cTaking `#Remote"
    })
      GetRemote()
      RemoteEmpty = false
    end
    Rotation()
  end
end
RemoteEmpty = true
if Customize.Start.Mode:upper() == "PTHT" then
  Plant, Harvest = true, false
  else
  Plant, Harvest = false, true
end
if (Customize.Other.Antilag) then
  List = { "AntiLag" }
  for _, Cheat in pairs(List) do
    EditToggle(Cheat, true)
  end
end
Current = 1
if Customize.Start.Loop == "GAS" then
  while true do
    Reconnect()
  end
  elseif type(Customize.Start.Loop) == "number" then
    repeat
      Reconnect()
      if PTHT // 2 == Customize.Start.Loop then
        SendPacket(2, "action|input\ntext|`4[`2PTHT`4] `9FINISHED `c" .. PTHT // 2 .. " `4LEAVE `8THE `#WORLD")
        LogToConsole("`9You're `4job `9PTHT `5its `2DONE")
        Sleep(5 * 10^2)
        SendPacket(3, "action|join_request\nname|EXIT|\ninvitedWorld|0")
      else
        if PTHT % 2 ~= 0 then
          SendPacket(2, "action|input\ntext|`4[`2PTHT`4][ `2Rotation `4: `9" .. PTHT // 2 .. " `b/ `9" .. Customize.Start.Loop .. " (wink) `w]")
          Sleep(5 * 10^2)
        end
      end
      until PTHT // 2 == Customize.Start.Loop
   end
