local SLOT_COUNT = 16
local d = "north"
local width, depth, height = 10, 10, 2

if (#arg == 3) then
    width = tonumber(arg[1])
    depth = tonumber(arg[2])
    height = tonumber(arg[3])
else
    print('ok asshole ur getting default 10x10x2')
end

YEET = {
    "minecraft:stone",
    "minecraft:dirt",
    "minecraft:cobblestone",
    "minecraft:sand",
    "minecraft:gravel",
    "miencraft:redstone",
    "minecraft:flint",
    "railcraft:ore_metal",
    "extrautils2:ingredients",
    "minecraft:dye",
    "thaumcraft:nugget",
    "thaumcraft:crystal_essence",
    "thermalfoundation:material",
    "projectred-core:resource_item",
    "thaumcraft:ore_cinnabar",
    "deepresonance:resonating_ore",
    "forestry:apatite"
}

function yeet()
    print("finna yeet")
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            for filterIndex = 1, #YEET, 1 do
                if(item["name"] == YEET[filterIndex]) then
                    print("yeeting " .. item["name"])
                    turtle.select(slot)
                    turtle.dropDown()
                end
            end
        end
    end
end

function getEnderIndex()
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if(item["name"] == "enderstorage:ender_storage") then
                return slot
            end
        end
    end
    return nil
end

function emptyInventory()
    yeet()
    index = getEnderIndex()
    if(index ~= nil) then
        turtle.select(index)
        turtle.digUp()
        turtle.placeUp()
    end
    -- chest deployed
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if(item ~= nil) then
            if(item["name"] ~= "minecraft:coal_block" and item["name"] ~= "minecraft:coal") then
                turtle.select(slot)
                turtle.dropUp()
            end
        end
    end
    -- shit stored
    turtle.digUp()
end

function checkFuel()
    turtle.select(1)
    if(turtle.getFuelLevel() < 50) then
        for slot = 1, SLOT_COUNT, 1 do
            turtle.select(slot)
            if(turtle.refuel(1)) then
                return true
            end
        end
        return false
    else
        return true
    end
end

function lookAndDig()
    while(turtle.detect()) do
        turtle.dig()
        turtle.digUp()
        turtle.digDown()
    end
end

function forward()
    lookAndDig()
    turtle.forward()
end

function turnLeft()
    turtle.turnLeft()
    lookAndDig()
    turtle.forward()
    turtle.turnLeft()
    lookAndDig()
end

function turnRight()
    turtle.turnRight()
    lookAndDig()
    turtle.forward()
    turtle.turnRight()
    lookAndDig()
end

function flip()
    if(d == "north") then
        d = "south"
    elseif(d == "south") then
        d = "north"
    elseif(d == "west") then
        d = "east"
    elseif(d == "east") then
        d = "west"
    end
end

function turnAround(tier)
    if(tier % 2 == 1) then
        if(d == "north" or d == "east") then
            turnRight()
        elseif(d == "south" or d == "west") then
            turnLeft()
        end
    end
    flip()
end

function riseTier()
    turtle.turnRight()
    turtle.turnRight()
    flip()
    turtle.digUp()
    turtle.up()
end

function go()
    for tier = 1, height, 1 do
        for col = 1, width, 1 do
            for row = 1, depth - 1, 1 do
                if(not checkFuel()) then
                    print("have no fuel")
                    return
                end
                forward()
                print(string.format("Row: %d   Col: %d", row, col))
            end
            if(col ~= width) then
                turnAround(tier)
            end
            emptyInventory()
        end
        riseTier()
    end
end

go()