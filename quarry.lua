term.clear()
io.write("girth: ")
girth = io.read()
io.write("length: ")
length = io.read()
io.write("depth: ")
depth = io.read()
io.write("yeet? ")
tossGarbage = io.read()

x = 0
y = 0
z = 0

rotation = 0

fullSlots = 0

function digStraight()
	turtle.digDown()
	turtle.dig()
	turtle.foward()
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