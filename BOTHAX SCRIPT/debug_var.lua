

local function debugVar(var)
    LogToConsole("parameter 0: " ..var[0])
    LogToConsole("parameter 1: " ..var[1])
    if var[2] ~= nil then
        LogToConsole("parameter 2: " ..var[2])
    end

     if var[3] ~= nil then
        LogToConsole("parameter 3: " ..var[3])
    end
end

AddHook("onvariant", "Vardebug", debugVar)
