local function debugPacket(type, packet)
    LogToConsole('\nSendPacket('.. type ..', "'.. packet ..'")')
end

AddHook("onsendpacket", "packetDebug", debugPacket)
