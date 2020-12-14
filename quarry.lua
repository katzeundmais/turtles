term.clear()
io.write("girth: ")
girth = io.read()
io.write("length: ")
length = io.read()
io.write("depth: ")
depth = io.read()
io.write("yeet? ")
yeet = io.read()

x = 0
y = 0
z = 0

rotation = 0

fullSlots = 0

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

function digStraight()
	turtle.digDown()
	turtle.dig()
	turtle.dig()
	turtle.forward()
	if rotation == 0 then
		z = z + 1
	elseif rotation == 1 then
		x = x + 1
	elseif rotation == 2 then
		z = z - 1
	elseif rotation == 3 then
		x = x - 1
	end
	turtle.digUp()
end

function nextRow()
	if turn == 0 then
		turtle.turnRight()
		rotation = 1
		digStraight()
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
	local step = 0
	for step = 2, 0, -1 do
		turtle.digDown()
		if turtle.down() == true then
			y = y + 1
		end
	end
end

function quarry()
	turn = 0
	done = 0
	depth = tonumber(depth)
	turtle.digUp()
	turtle.up()
	y = y - 1
	while y < depth - 2 do
		digDown()
		for c = length, 1, -1 do
			for r = girth, 2, -1 do
				digStraight()
			end
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
end

quarry()