-- Wrap ME network as peripheral
local me = peripheral.wrap("top")


-- GLOBAL VARIABLES --

-- Sleep duration between checks in seconds
local sleepPeriod = 60

-- FUNCTIONS

-- Digits separated by comma by http://richard.warburton.it
function comma_value(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

-- Checks AE for item and returns quantity
function getItemAmount(item)
    local itemAmount = me.getItemDetail({id = item, dmg = 0})
    if itemAmount == nil then
        return 0
    else
        return itemAmount.basic().qty
    end
end

-- Checks AE for item with dmg attribute and returns quantity
function getDmgItemAmount(item, damage)
    local itemAmount = me.getItemDetail({id = item, dmg = damage})
    if itemAmount == nil then
        return 0
    else
        return itemAmount.basic().qty
    end
end

-- Checks existing bundled redstone output and returns boolean if color is on on side
function isOn(side, color)
    return colors.test(redstone.getBundledOutput(side), color)
end

-- Checks item quantity and adjusts redstone colors
function checkItem(item, lowerTreshold, upperTreshold, side, color)
    local itemAmount = getItemAmount(item)

    if (itemAmount < lowerTreshold) and not isOn(side, color) then
        redstone.setBundledOutput(side, colors.combine(redstone.getBundledOutput(side), color))
        print(item .. " @ " .. comma_value(tostring(itemAmount)) .. ", below lower threshold (" .. comma_value(tostring(lowerTreshold)) .. "), gathering ON.")
    elseif (itemAmount > upperTreshold) and isOn(side, color) then
        redstone.setBundledOutput(side, colors.subtract(redstone.getBundledOutput(side), color))
        print(item .. " @ " .. comma_value(tostring(itemAmount)) .. ", above upper threshold (" .. comma_value(tostring(upperTreshold)) .. "), gathering OFF.")
    end
end

-- Checks item quantity and adjusts redstone colors
function checkDmgItem(item, damage, lowerTreshold, upperTreshold, side, color)
    local itemAmount = getDmgItemAmount(item, damage)

    if (itemAmount < lowerTreshold) and not isOn(side, color) then
        redstone.setBundledOutput(side, colors.combine(redstone.getBundledOutput(side), color))
        print(item .. " @ " .. comma_value(tostring(itemAmount)) .. ", below lower threshold (" .. comma_value(tostring(lowerTreshold)) .. "), gathering ON.")
    elseif (itemAmount > upperTreshold) and isOn(side, color) then
        redstone.setBundledOutput(side, colors.subtract(redstone.getBundledOutput(side), color))
        print(item .. " @ " .. comma_value(tostring(itemAmount)) .. ", above upper threshold (" .. comma_value(tostring(upperTreshold)) .. "), gathering OFF.")
    end
end

-- Main body begins here

-- Turn off all redstone at startup to guarantee nothing is left on from previous run
redstone.setBundledOutput("right", 0)
redstone.setBundledOutput("left", 0)
redstone.setBundledOutput("back", 0)
redstone.setBundledOutput("front", 0)

-- Clear terminal and reset cursor position
term.clear()
term.setCursorPos(1,1)
print("xilni's stock monitor")

-- Main loop
while true do
    -- Elemental essences
    checkItem("magicalcrops:EarthEssence", 50000, 60000, "right", colors.orange)
    checkItem("magicalcrops:WaterEssence", 50000, 60000, "right", colors.magenta)
    checkItem("magicalcrops:AirEssence", 50000, 60000, "right", colors.lightBlue)
    checkItem("magicalcrops:FireEssence", 50000, 60000, "right", colors.black)
    checkItem("magicalcrops:NatureEssence", 50000, 60000, "back", colors.pink)
    checkItem("magicalcrops:DyeEssence", 50000, 60000, "back", colors.white)
    checkItem("magicalcrops:NetherEssence", 50000, 60000, "front", colors.lightBlue)
    -- Vanilla
    checkItem("magicalcrops:IronEssence", 100000, 110000, "right", colors.red)
    checkItem("magicalcrops:GoldEssence", 100000, 110000, "right", colors.green)
    checkItem("magicalcrops:ObsidianEssence", 50000, 60000, "back", colors.gray)
    checkItem("magicalcrops:QuartzEssence", 50000, 60000, "left", colors.black)
    checkItem("magicalcrops:CoalEssence", 100000, 110000, "right", colors.brown)
    checkItem("magicalcrops:EmeraldEssence", 100000, 110000, "right", colors.gray)
    checkItem("magicalcrops:RedstoneEssence", 100000, 110000, "right", colors.pink)
    checkItem("magicalcrops:DiamondEssence", 100000, 110000, "right", colors.yellow)
    checkItem("magicalcrops:GlowstoneEssence", 50000, 60000, "front", colors.brown)
    checkItem("magicalcrops:LapisEssence", 100000, 110000, "front", colors.blue)
    -- Thermal Foundantion
    checkItem("magicalcrops:ElectrumEssence", 100000, 110000, "right", colors.purple)
    checkItem("magicalcrops:EnderiumEssence", 100000, 110000, "right", colors.lightGray)
    checkItem("magicalcrops:PlatinumEssence", 100000, 110000, "right", colors.white)
    checkItem("magicalcrops:BronzeEssence", 50000, 60000, "back", colors.green)
    checkItem("magicalcrops:NickelEssence", 100000, 110000, "back", colors.lime)
    checkItem("magicalcrops:BlizzEssence", 50000, 60000, "left", colors.green)
    checkItem("magicalcrops:CopperEssence", 100000, 110000, "left", colors.blue)
    checkItem("magicalcrops:SaltpeterEssence", 50000, 60000, "left", colors.cyan)
    checkItem("magicalcrops:LeadEssence", 100000, 110000, "left", colors.pink)
    checkItem("magicalcrops:LumiumEssence", 100000, 110000, "left", colors.white)
    checkItem("magicalcrops:SignalumEssence", 100000, 110000, "front", colors.red)
    checkItem("magicalcrops:InvarEssence", 100000, 110000, "front", colors.purple)
    checkItem("magicalcrops:SilverEssence", 100000, 110000, "front", colors.lightGray)
    checkItem("magicalcrops:TinEssence", 100000, 110000, "front", colors.yellow)
    -- Ender IO
    checkItem("magicalcrops:VibrantAlloyEssence", 50000, 60000, "right", colors.cyan)
    checkItem("magicalcrops:ElectricalSteelEssence", 50000, 60000, "back", colors.orange)
    checkItem("magicalcrops:DarkSteelEssence", 100000, 110000, "back", colors.magenta)
    checkItem("magicalcrops:EnergeticAlloyEssence", 100000, 110000, "back", colors.lightBlue)
    checkItem("magicalcrops:PulsatingIronEssence", 50000, 60000, "back", colors.black)
    checkItem("magicalcrops:RedstoneAlloyEssence", 50000, 60000, "back", colors.red)
    checkItem("magicalcrops:ConductiveIronEssence", 50000, 60000, "back", colors.brown)
    checkItem("magicalcrops:SoulariumEssence", 100000, 110000, "back", colors.purple)
    -- Mekanism
    checkItem("magicalcrops:SteelEssence", 100000, 110000, "right", colors.blue)
    checkItem("magicalcrops:OsmiumEssence", 100000, 110000, "right", colors.lime)
    -- Tinkers
    checkItem("magicalcrops:AluminiumEssence", 50000, 60000, "back", colors.blue)
    checkItem("magicalcrops:AlumiteEssence", 50000, 60000, "left", colors.red)
    checkItem("magicalcrops:ManyullynEssence", 100000, 110000, "front", colors.gray)
    -- Botania
    checkItem("magicalcrops:ManasteelEssence", 50000, 60000, "back", colors.cyan)
    checkItem("magicalcrops:TerrasteelEssence", 50000, 60000, "back", colors.lightGray)
    -- AE2
    checkItem("magicalcrops:CertusQuartzEssence", 50000, 60000, "left", colors.lightGray)
    checkItem("magicalcrops:FluixEssence", 50000, 60000, "front", colors.orange)
    -- Mob essence
    checkItem("magicalcrops:SheepEssence", 50000, 60000, "back", colors.yellow)
    checkItem("magicalcrops:ExperienceEssence", 50000, 60000, "left", colors.orange)
    checkItem("magicalcrops:EndermanEssence", 50000, 60000, "left", colors.lightBlue)
    checkItem("magicalcrops:CowEssence", 50000, 60000, "left", colors.purple)
    checkItem("magicalcrops:GhastEssence", 50000, 60000, "left", colors.gray)
    checkItem("magicalcrops:SlimeEssence", 50000, 60000, "left", colors.yellow)
    checkItem("magicalcrops:BlazeEssence", 50000, 60000, "front", colors.magenta)
    checkItem("magicalcrops:CreeperEssence", 50000, 60000, "front", colors.black)
    checkItem("magicalcrops:SkeletonEssence", 50000, 60000, "front", colors.green)
    -- Misc essence
    checkItem("magicalcrops:RubberEssence", 50000, 60000, "left", colors.magenta)
    checkItem("magicalcrops:YelloriteEssence", 100000, 110000, "left", colors.brown)
    checkItem("magicalcrops:DraconiumEssence", 100000, 110000, "left", colors.lime)
    checkDmgItem("customthings:item", 16, 100000, 110000, "front", colors.cyan)  -- Electrotine essence

    os.sleep(sleepPeriod)
end