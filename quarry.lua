io.write("Rows: ")
rows = io.read()

function digAndMove()
	turtle.dig()
	turtle.forward()
end

function quarry()
	turtle.digDown()
	for r = rows, 2, -1 do
		digAndMove()
	end
end

quarry()