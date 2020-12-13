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
        break
    end
end

function digAndMove(n)
    for x = 1, n, 1 do
        while turtle.detect() do
            turtle.dig()
        end
        turtle.forward()
        refuel()
    end
end

io.write("length: ")
a = tonumber(io.read())
io.write("girth: ")
b = tonumber(io.read())
local n = 1

refuel()
turtle.digDown()
turtle.down()
while turtle.detect() do
    for n = 1, a-1, 1 do
        digAndMove(1)
    end
    turtle.turnLeft()
    for n = 1, b-2, 1 do
        digAndMove(1)
    end
    if turtle.detect() == false then
        turtle.turnLeft()
        a = a-1
        b = b-2
    end
end