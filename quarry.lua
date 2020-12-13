io.write("length: ")
A = tonumber(io.read())
io.write("girth: ")
B = tonumber(io.read())

while turtle.digDown() == true do

    for i = 1, I < A, I + 1 do
        turtle.dig()
        turtle.forward()
    end

    turtle.turnLeft()

    for i = 1, I < B, I + 1 do
        turtle.dig()
        turtle.forward()
    end

    turtle.turnLeft()

    for i = 1, I < A, I + 1 do
        turtle.dig()
        turtle.forward()
    end

    turtle.turnLeft()

    for i = 1, I < B-1, I + 1 do
        turtle.dig()
        turtle.forward()
    end

    turtle.turnLeft()
end