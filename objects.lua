require("class")

Player = class(function(p, x, y)
				p.x = x
				p.y = y

				p.velocity = {}
				p.velocity["x"] = 0
				p.velocity["y"] = 0

				input = PlayerInputComponent()
				physics = PlayerPhysicsComponent()
				end)

function Player:update()
	input:update(self)
	physics:update(self)
end

--##############################
--#         COMPONENTS         #
--##############################

InputComponent = class()

PlayerInputComponent = class(InputComponent)

function PlayerInputComponent:update(object)
	MOVE_SPEED = 3
	
	if love.keyboard.isDown("right") then
		object.velocity["x"] = MOVE_SPEED
	elseif love.keyboard.isDown("left") then
		object.velocity["x"] = -MOVE_SPEED
	else
		object.velocity["x"] = 0
	end

	if love.keyboard.isDown("down") then
		object.velocity["y"] = MOVE_SPEED
	elseif love.keyboard.isDown("up") then
		object.velocity["y"] = -MOVE_SPEED
	else
		object.velocity["y"] = 0
	end
end

--#################

PhysicsComponent = class()

PlayerPhysicsComponent = class(PhysicsComponent)


function PlayerPhysicsComponent:update(object)
	object.x = object.x + object.velocity["x"]
	object.y = object.y + object.velocity["y"]
end
