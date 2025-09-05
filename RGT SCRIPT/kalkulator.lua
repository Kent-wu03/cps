

SendVariantList({[0] = 'OnTextOverlay',[1] = '`2Made by Sekriptopia'})
AddHook("onsendpacket", "chook", function(tipe, roki)
    if roki:find("/c") then
        local detek = roki:match("/c%s+(.+)")
        if not detek then
            LogToConsole("`4Please use + - * /")
            return true
        end

        local a, op, b = detek:match("(%-?%d+)%s*([%+%-%*/])%s*(%-?%d+)")
        if not (a and op and b) then
            LogToConsole("`4Only Number")
            return true
        end

        a, b = tonumber(a), tonumber(b)
        local hasil

        if op == "+" then
            hasil = a + b
        elseif op == "-" then
            hasil = a - b
        elseif op == "*" then
            hasil = a * b
        elseif op == "/" then
            if b == 0 then
                LogToConsole("`4Cant divided by 0")
                return true
            end
            hasil = a / b
        end

        LogToConsole("`^Hasil "..a.." "..op.." "..b.." = `2"..hasil)
		SendVariantList({[0] = 'OnTextOverlay',[1] = "`^Hasil "..a.." "..op.." "..b.." = `2"..hasil})
        return true
    end
    return false
end)

