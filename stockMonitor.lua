local component = require('component')
local sides = require('sides')
local colors = require('colors')
local t = require('term')

-- GLOBAL VARIABLES --

-- Threshold variables
-- Lubricant thresholds in mB
local lowLubeThreshold = 900000000
local highLubeThreshold = 1000000000

-- Canola thresholds
local lowCanolaThreshold = 400000
local highCanolaThreshold = 500000

-- Bundled redstone side
local bundledSide = sides.back

-- Bundled redstone transmitter colors
local lubeColor = colors.red
local canolaColor = colors.green

-- Sleep duration between checks
local sleepPeriod = 60

-- FUNCTIONS

-- Digits separated by comma by http://richard.warburton.it
function comma_value(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-- Returns the amount of specified fluid in AE
function getFluidAmount(fluid)
    local fluids = component.me_controller.getFluidsInNetwork({label = fluid})

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
    local items = component.me_controller.getItemsInNetwork({label = item})

    for _,i in pairs(items) do
        if type(i) == "table" then
            if i.label == item then
                return i.size
            end
        end
    end
    return 0
end

-- Checks fluid against thresholds and turns processing ON/OFF if needed
function checkFluid(fluid, lowerThreshold, upperTreshold, side, color)
    local fluidAmount = getFluidAmount(fluid)

    if (fluidAmount < lowerThreshold) and not isOn(side, color) then
        component.redstone.setBundledOutput(side, color, 15)
        print(fluid .. " @ " .. comma_value(tostring(math.floor(fluidAmount/1000))) .. " B, below lower threshold (" .. comma_value(tostring(math.floor(lowerThreshold/1000))) .. " B), turning on processing.")
    elseif (fluidAmount > upperTreshold) and isOn(side, color) then
        component.redstone.setBundledOutput(side, color, 0)
        print(fluid .. " @ " .. comma_value(tostring(math.floor(fluidAmount/1000))) .. " B, above upper threshold (" .. comma_value(tostring(math.floor(upperTreshold/1000))) .. " B), turning off processing.")
    end
end

-- Checks item against thresholds and turns gathering ON/OFF if needed
function checkItem(item, lowerTreshold, upperTreshold, side, color)
    local itemAmount = getItemAmount(item)

    if (itemAmount < lowerTreshold) and not isOn(side, color) then
        component.redstone.setBundledOutput(side, color, 15)
        print(item .. " @ " .. comma_value(tostring(itemAmount)) .. ", below lower threshold (" .. comma_value(tostring(lowerTreshold)) .. "), gathering ON.")
    elseif (itemAmount > upperTreshold) and isOn(side, color) then
        component.redstone.setBundledOutput(side, color, 0)
        print(item .. " @ " .. comma_value(tostring(itemAmount)) .. ", above upper threshold (" .. comma_value(tostring(upperTreshold)) .. "), gathering OFF.")
    end
end

-- Checks if output is already set and returns true/false
function isOn(side, color)
    if component.redstone.getBundledOutput(side, color) > 0 then
        return true
    else
        return false
    end
end

-- Main body begins here

if t.isAvailable() then
    t.clear()
    print("xilni's stock monitor")
end

while true do
    checkFluid("Lubricant", lowLubeThreshold, highLubeThreshold, bundledSide, lubeColor)
    checkItem("Canola Seeds", lowCanolaThreshold, highCanolaThreshold, bundledSide, canolaColor)
    os.sleep(sleepPeriod)
end