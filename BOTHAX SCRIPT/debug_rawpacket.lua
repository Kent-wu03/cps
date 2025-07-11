function on_sendpacketraw(packet)
    LogToConsole("Type : "..packet.type..
                 "\nX : "..packet.x..
                 "\nY : "..packet.y..
                 "\nPunchX : "..packet.px..
                 "\nPunchY : "..packet.py..
                 "\nState : "..packet.state..
                 "\nValue : "..packet.value..
                 "\nNetID : "..packet.netid)
    return false
end

AddHook("onsendpacketraw", "OnSendPacketRawKey", on_sendpacketraw)
