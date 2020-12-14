io.write("length: ")
length = io.read()
io.write("girth: ")
girth = io.read()
io.write("depth: ")
depth = io.read()
io.write("yeet? ")
yeet = io.read()

xpos = 0
ypos = 0
zpos = 0

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

function home()
	rotate()
	local step = 0
	for step = ypos-1, 0, -1 do
		turtle.up()
	end
	for step = xpos-1, 0, -1 do
		turtle.forward()
	end
	for step = zpos-1, 0, -1 do
		turtle.forward()
	end
end

function go()
	turtle.turnLeft()
	turtle.turnLeft()
	local step = 0
	for step = 0, zpos-1, 1 do
		turtle.forward()
	end
	turtle.turnRight()
	for step = 0, xpos-1, 1 do
		turtle.forward()
	end
	for step = 0, ypos-1, 1 do
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

function checkFuel()
	turtle.select(1)
	turtle.refuel()
	if turtle.getFuelLevel() <= xpos + ypos + zpos + 1 then
		refill = 1
		empty()
		refill = 0
	end
end

function empty()
	home()
	local search = 0
	for search = 1, 16, 1 do
		turtle.select(search)
		turtle.drop()
	end
	if refill == 1 then
		turtle.turnRight()
		while turtle.getFuelLevel() <= xpos + ypos + zpos + 1 do
			if turtle.suck() == true then
				turtle.suck()
				turtle.select(1)
				turtle.refuel()
			elseif turtle.suck() == false then
				turtle.select(1)
				turtle.refuel()
				term.clear()
				term.setCursorPos(1,1)
				io.write("out of fuel")
			end
		end
		turtle.turnLeft()
		go()
	end
end

function checkFull()
	fullSlots = 0
	local search = 0
	for search = 16, 1, -1 do
		turtle.select(search)
		if turtle.getItemCount() > 0 then
			if tossGarbage == "yes" then
				if turtle.getItemDetail().name == "minecraft:cobblestone" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "minecraft:stone" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "minecraft:dirt" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "minecraft:gravel" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "chisel:marble2" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "chisel:limestone2" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "minecraft:netherrack" then
					turtle.drop()
				elseif turtle.getItemDetail().name == "natura:nether_tainted_soil" then
					turtle.drop()
				end
			end
		end
		if turtle.getItemCount() > 0 then
			fullSlots = fullSlots + 1
		end
	end
	if fullSlots == 16 then
		empty()
	end
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
	checkFuel()
	local step = 0
	for step = 2, 0, -1 do
		turtle.digDown()
		if turtle.down() == true then
			ypos = ypos + 1
		end
	end
end

function digStraight()
	checkFuel()
	turtle.digDown()
	turtle.dig()
	turtle.forward()
	if rotation == 0 then
		zpos = zpos+1
	elseif rotation == 1 then
		xpos = xpos+1
	elseif rotation == 2 then
		zpos = zpos-1
	elseif rotation == 3 then
		xpos = xpos-1
	end
	turtle.digUp()
end

function quarry()
	turn = 0
	done = 0
	depth = tonumber(depth)
	checkFuel()
	turtle.digUp()
	turtle.up()
	ypos = ypos-1
	while ypos < depth-2 do
		digDown()
		for c = girth, 1, -1 do
			for r = length, 2, -1 do
				digStraight()
			end
			checkFull()
			if c == 1 then
				turtle.turnRight()
				turtle.turnRight()
				if rotation == 0 then
					rotation=2
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
	empty()
end

quarry()