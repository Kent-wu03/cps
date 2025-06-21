-- auto surg bothax



















AddHook("onsendpacket", "sp", function(tipe, roki)
    if roki:find("/ma (.+)") then 
        ma = roki:match("/ma (.+)") 
        SendPacket(2,"action|input|\n|text|/modage "..ma)
		LogToConsole("`^Modage "..ma.." Minute")
        return true   
	elseif roki:find("/tutor") then
		SendVariantList({[0] = "OnDialogRequest", [1] = [[
set_default_color|`w
add_label_with_icon|small|`cAuto Surg Script|left|1256|
add_label_with_icon|small|`9Script by RockyBandel|left|2480|
add_spacer|small|
add_label_with_icon|small|`c1.Just Wrench The Patient you want to surg|left|482|
add_label_with_icon|small|`c2.If You Got Any Effect Do /ma (amount)|left|482|
add_label_with_icon|small|`c3.If The Hook Removed Rerun Sc And dont wrench yourself|left|482|
add_quick_exit|]]})
		return true
	end
	return false
end)



function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

SendPacket(2,"action|input|\n|text|`bBotHax Surgery Script `9by `cRockyBandel")
SendVariantList({[0] = "OnDialogRequest", [1] = [[
set_default_color|`w
add_label_with_icon|small|`cAuto Surg Script|left|1256|
add_label_with_icon|small|`9Script by RockyBandel|left|2480|
add_spacer|small|
add_label_with_icon|small|`c/tutor `b- `cTutorial How To Use Script|left|482|
add_label_with_icon|small|`c/ma (amount) `b- `cModage Shortcut|left|482|
add_quick_exit|]]})


AddHook("onvariant", "surg", function(var)
if var[0]:find("OnDialogRequest") and var[1]:find("Status: `4Awake(.+)")then
    if findItem(1262) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_2
]])
        LogToConsole("`c[ROCKYBANDEL]`2Using AnesThetic")
    else
        SendVariantList({[0] = "OnTextOverlay", [1] = "`2AnesThetic habis"})
    end
return true

elseif var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|surge_edit")then
SendPacket(2,[[
action|dialog_return
dialog_name|surge_edit
x|]]..var[1]:match("embed_data|x|(%d+)")..[[|
y|]]..var[1]:match("embed_data|y|(%d+)")..[[|
]])
LogToConsole("`c[ROCKYBANDEL]`4Auto Surgery Start")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|popup")then
SendPacket(2,[[
action|dialog_return
dialog_name|popup
netID|]]..var[1]:match("embed_data|netID|(%d+)")..[[|
buttonClicked|surgery
]])
LogToConsole("`c[ROCKYBANDEL]`4Auto Surgery Start")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("`4You can't see what you are doing!(.+)")then
if findItem(1258) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_0
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Sponge")
    else
        FChat("`2you don't have enough Sponge")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `3slowly rising.")then
if findItem(1266) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_4
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Antibiotics")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Antibiotic habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `6climbing.")then
if findItem(1266) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_4
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Antibiotics")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Antibiotic habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `4climbing rapidly!.")then
if findItem(1266) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_4
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Antibiotics")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Antibiotic habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `3Not sanitized")then
if findItem(1264) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_3
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Antiseptic")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Antiseptic habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `6Unclean")then
if findItem(1264) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_3
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Antiseptic")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Antiseptics habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `4Unsanitary")then
if findItem(1264) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_3
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Antiseptic")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Antiseptics habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("`6It is becoming hard to see your work.")then
if findItem(1258) > 1 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_0
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Sponge")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Sponge habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `4very quickly!")then
if findItem(1270) > 1 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_6
]])
LogToConsole("`c[ROCKYBANDEL]`9Using Stitches")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Stitches habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is `6losing blood!")then
if findItem(1270) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_6
]])
LogToConsole("`c[ROCKYBANDEL]`9Using Stitches")
    else
		SendVariantList({[0] = "OnTextOverlay", [1] = "`2Stitches habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `3slowly")then
if findItem(1270) > 1 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_6
]])
LogToConsole("`c[ROCKYBANDEL]`9Using Stitches")
    else
        SendVariantList({[0] = "OnTextOverlay", [1] = "`2Stitches habis"})
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `30(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `31(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `32(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `33(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `44(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `45(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`c[ROCKYBANDEL]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1260") then
if findItem(1262) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_1
]])
LogToConsole("`c[ROCKYBANDEL]`6Using Scalple")
    else
        SendVariantList({[0] = "OnTextOverlay", [1] = "`2Scalple habis"})
    end
return true
end
return false
end)
