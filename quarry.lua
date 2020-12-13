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

function square(n)
    while turtle.detect() do
        digAndMove(n)
    end
    turtle.turnLeft()
end

io.write("length: ")
a = tonumber(io.read())
io.write("girth: ")
b = tonumber(io.read())

if a < 3 or b < 3 then
    print("fuck you")
    return
end
refuel()
