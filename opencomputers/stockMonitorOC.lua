local component = require('component')
local sides = require('sides')
local colors = require('colors')
local t = require('term')
local state = require('state')
local text = require('text')

local rs = component.redstone
local me = component.me_controller
local gpu = component.gpu


-- GLOBAL VARIABLES --

-- Sleep duration between checks
local sleepPeriod = 30

-- FUNCTIONS

-- Digits separated by comma by http://richard.warburton.it
function comma_value(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-- Returns the amount of specified fluid in AE
function getFluidAmount(fluid)
    local fluids = me.getFluidsInNetwork({label = fluid})

    for _,f in pairs(fluids) do
        if type(f) == "table" then
            if f.label == fluid then
                return f.amount
            end
        end
    end
    return 0
end

-- Returns a number of the item amount in AE
function getItemAmount(item)
    local items = me.getItemsInNetwork({label = item})

    for _,i in pairs(items) do
        if type(i) == "table" then
            if i.label == item then
                return i.size
            end
        end
    end
    return 0
end

function check(item, lowerThreshold, upperThreshold, side, color, position, type)
    local type = type or "item"
    local amount = (type == 'item' and getItemAmount(item)) or getFluidAmount(item)
    local status = state.unknown

    if (amount < lowerThreshold) and not isOn(side, color) then
        rs.setBundledOutput(side, color, 15)
        status = state.on
    elseif (amount > upperThreshold) and isOn(side, color) then
        rs.setBundledOutput(side, color, 0)
        status = state.off
    end

    updateScreen(item, amount, lowerThreshold, upperThreshold, position, status, type)
end

function setupScreen(count)
    gpu.set(1, 1, "Name:")
    gpu.set(24, 1, text.padLeft("Lower:", 12))
    gpu.set(38, 1, text.padLeft("Amount:", 12))
    gpu.set(52, 1, text.padLeft("Upper:", 12))
    gpu.set(66, 1, "Status:")
    gpu.setForeground(0x00FF00)
    for i=3,(2 + count) do gpu.set(66, i, "OFF") end
    gpu.setForeground(0xFFFFFF)
end

-- Update screen
function updateScreen(item, amount, lowerThreshold, upperThreshold, position, status, type)
    gpu.set(1, position + 2, item)
    gpu.set(24, position + 2, type == 'item' and text.padLeft(comma_value(tostring(lowerThreshold)), 12) or text.padLeft((comma_value(tostring(math.floor(lowerThreshold/1000)))), 12))
    gpu.set(38, position + 2, type == 'item' and text.padLeft(comma_value(tostring(amount)), 12) or text.padLeft((comma_value(tostring(math.floor(amount/1000)))), 12))
    gpu.set(52, position + 2, type == 'item' and text.padLeft(comma_value(tostring(upperThreshold)), 12) or text.padLeft((comma_value(tostring(math.floor(upperThreshold/1000)))), 12))

    if status == state.on then
        gpu.setForeground(0xFF0000)
        gpu.set(66, position + 2, "ON ")
        gpu.setForeground(0xFFFFFF)
    elseif status == state.off then
        gpu.setForeground(0x00FF00)
        gpu.set(66, position + 2, "OFF")
        gpu.setForeground(0xFFFFFF)
    end

end

-- Checks if output is already set and returns true/false
function isOn(side, color)
    if rs.getBundledOutput(side, color) > 0 then
        return true
    else
        return false
    end
end

-- Main body begins here

--  Reset status
for i=0,15 do rs.setBundledOutput(sides.left, i, 0) end

-- Setup terminal
t.clear()
setupScreen(6)

-- Main loop
while true do
    check("Lubricant", 10000000, 12000000, sides.left, colors.red, 1, "fluid")
    check("Canola Seeds", 50000, 60000, sides.left, colors.green, 2)
    check("Cinderpearl", 50000, 60000, sides.left, colors.white, 3)
    check("Sugar Canes", 50000, 60000, sides.left, colors.blue, 4)
    check("Jet Fuel", 10000000, 12000000, sides.left, colors.yellow, 5, "fluid")
    check("Industrial Hemp Fiber", 50000, 60000, sides.left, colors.black, 6)

    os.sleep(sleepPeriod)
end