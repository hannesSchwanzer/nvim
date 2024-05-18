local getOS = {}

function getOS.getName()
    local osname
    if jit then 
        return string.lower(jit.os)
    end

    local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
    if fh then
        osname = string.lower(fh:read())
    end

    return osname or "windows"
end

return getOS
