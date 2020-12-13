posX = 0
posY = 0
posZ = 0

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
	turtle.turnLeft()
	for step = posZ - 1, 0, -1 do
		turtle.forward()
	end
end