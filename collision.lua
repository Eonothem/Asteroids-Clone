require("helper_classes/class")
Circle = class(function(c, x, y, radius)
				c.x = x
				c.y = y
				c.radius = radius
				end)

function checkCircleCollision(circle1, circle2)
	return getDistance(circle1.x, circle1.y, circle2.x, circle2.y) <= circle1.radius + circle2.radius
end

function getDistance(x1, y1, x2, y2)
	xDiff = (x2 - x1)^2
	yDiff = (y2 - y1)^2

	return math.sqrt(xDiff+yDiff)
end