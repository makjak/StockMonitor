local component = require('component')
local sides = require('sides')
local colors = require('colors')
local t = require('term')

-- GLOBAL VARIABLES --

-- Threshold variables
-- Lubricant thresholds in mB
local lowLubeThreshold = 500000000
local highLubeThreshold = 600000000

-- Canola thresholds
local lowCanolaThreshold = 200000
local highCanolaThreshold = 300000

-- Bundled redstone side
local bundledSide = sides.back

-- Bundled redstone transmitter colors
local lubeColor = colors.red
local canolaColor = colors.green

-- Sleep duration between checks
local sleepPeriod = 60

-- FUNCTIONS

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
function checkFluid(fluid, lowThreshold, upperTreshold, side, color)
    local fluidAmount = getFluidAmount(fluid)

    if fluidAmount < lowThreshold then
        component.redstone.setBundledOutput(side, color, 15)
        print(fluid .. " @ " .. fluidAmount .. ", below lower threshold (" .. lowThreshold .. "), turning on processing.")
    elseif fluidAmount > upperTreshold then
        component.redstone.setBundledOutput(side, color, 0)
        print(fluid .. " @ " .. fluidAmount .. ", above upper threshold (" .. upperTreshold .. "), turning off processing.")
    end
end

-- Checks item against thresholds and turns farm ON/OFF if needed
function checkItem(item, lowTreshold, upperTreshold, side, color)
    local itemAmount = getItemAmount(item)

    if itemAmount < lowTreshold then
        component.redstone.setBundledOutput(side, color, 15)
        print(item .. " @ " .. itemAmount .. ", below lower threshold (" .. lowTreshold .. "), turning on farm.")
    elseif itemAmount > upperTreshold then
        component.redstone.setBundledOutput(side, color, 0)
        print(item .. " @ " .. itemAmount .. ", above upper threshold (" .. upperTreshold .. "), turning off farm.")
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
