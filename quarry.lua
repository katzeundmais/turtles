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

turtle.digDown()
turtle.down()
for i = 1, a, 1 do
    digAndMove(1)
end
