--
-- State "enum" for stockMonitor.lua
--

local state = {
    [0] = "unknown",
    [1] = "on",
    [2] = "off"
}

do
    local keys = {}
    for k in pairs(state) do
        table.insert(keys, k)
    end
    for _, k in pairs(keys) do
        state[state[k]] = k
    end
end

return state