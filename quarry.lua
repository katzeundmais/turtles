io.write("Rows: ")
rows = io.read()

x = 0
y = 0
z = 0

rotation = 0

function digAndMove()
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
end

function row()
	if turn == 0 then
		turtle.turnRight()
		rotation = 1
		digAndMove()
		turtle.turnRight()
		rotation = 2
		turn = 1
	elseif turn == 1 then
		turtle.turnLeft()
		rotation = 1
		digAndMove()
		turtle.turnLeft()
		rotation = 0
		turn = 0
	elseif turn == 2 then
		turtle.turnRight()
		rotation = 3
		digAndMove()
		turtle.turnRight()
		rotation = 0
		turn = 3
	elseif turn == 3 then
		turtle.turnLeft()
		rotation = 3
		digAndMove()
		turtle.turnLeft()
		rotation = 2
		turn = 2
	end
end

function quarry()
	turtle.digDown()
	turtle.down()
	for c = columns, 1, -1 do
		for r = rows, 2, -1 do
			digAndMove()
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
			row()
		end
	end
end

quarry()