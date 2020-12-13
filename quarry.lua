io.write("current y: ")
iniY = io.read()

posX = 0
posY = 0
posX = 0

rotation = 0

function rotate()
    if rotation == 0 then
            turtle.turnLeft()
    elseif rotation == 1 then
            turtle.turnLeft()
            turtle.turnLeft()
    elseif rotation == 2 then
            turtle.turnRight()
    end
end

function recover()
    rotate()
    local step = 0
    for step = posY - 1, 0, -1 do
        turtle.up()
    end
    for step = posX - 1, 0, -1 do
        turtle.forward()
    end
    for step = posZ - 1, 0, -1 do
        turtle.forward()
    end
end

function resume()
    turtle.turnLeft()
    turtle.turnleft()
    local step = 0
    for step = 0, posZ - 1, 1 do
        turtle.forward()
    end
    turtle.turnRight()
    for step = 0, posX - 1, 1 do
        turtle.down()
    end
    if rotation == 0 then
        turtle.turnLeft()
    elseif rotation == 2 then
        turtle.turnRight()
    elseif rotation == 3 then
        turtle.turnRight()
        turtle.turnRight()
    end
end

function refuel()
    while turtle.getFuelLevel() == 0 do
        for i = 1, 16 do
            turtle.select(i)
            item = turtle.getItemDetail()
            if item and item.name == "minecraft:coal" then  
                turtle.refuel()
            end
        end
        turtle.select(1)
    end
end

function yeet()
    recover()
    local search = 0
    for search = 16, 1, -1 do
        turtle.select(search)
        turtle.drop()
    end
end

function checkInventory()
    fullSlots = 0
    local search = 0
    for search = 16, 1, -1 do
        turtle.select(search)
        if turtle.getItemCount() > 0 then
            fullSlots = fullSlots + 1
        end
    end
    if fullSlots == 16 then
        yeet()
    end
end

function digStraight()
    refuel()
    turtle.digDown()
    turtle.dig()
    turtle.dig()
    turtle.forward()
    if rotation == 0 then
        posz = posZ + 1
    elseif rotation == 1 then
        posX = posX + 1
    elseif rotation == 2 then
        posZ = posZ -1
    elseif rotation == 3 then
        posX = posX - 1
    end
end

function nextRow()
    if turn == 0 then
        turtle.turnRight()
        rotation = 1
        digStraigt()
        turtle.turnRight()
        rotation = 2
        turn = 1
    elseif turn == 1 then
        turtle.turnLeft()
        rotation = 1
        digStraight()
        turtle.turnLeft()
        rotation = 0
        turn = 0
    elseif turn == 2 then
        turtle.turnRight()
        rotation = 3
        digStraight()
        turtle.turnRight()
        rotation = 0
        turn = 3
    elseif turn == 3 then
        turtle.turnLeft()
        rotation = 3
        digStraight()
        turtle.turnLeft()
        rotation = 2
        turn = 2
    end
end

function digDown()
    refuel()
    local step = 0
    for step = 2, 0, -1 do
        turtle.digDown()
        if turtle.down() == true then
            posY = posY + 1
        end

    end
end

function quarry()
    turn = 0
    done = 0
    iniY = tonumber(iniY)
    refuel()
    turtle.digUp()
    turtle.up()
    posY = posY-1
    while posY < iniY - 2 do
        for c = columns, 1, -1 do
            for r = rows, 2, -1 do
                    digStraight()
            end
            checkInventory()
            if c == 1 then
                turtle.turnRight()
                turtle.turnRight()
                if rotation == 0 then
                    rotation = 2
                elseif rotation == 2 then
                    rotation = 0
                end
                if turn == 0 then
                    turn = 2
                elseif turn == 1 then
                    turn = 3
                elseif turn == 2 then
                    turn = 0
                elseif turn == 3 then
                    turn = 1
                end
            elseif c > 1 then
                nextRow()
            end
        end
    end
    turtle.digDown()
    done = 1
    yeet()
end

quarry()