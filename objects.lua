require("class")

--Generic class that can be any object in the game (Player/Asteroid)
GameObject = class(function(p, x, y, name)
				--X/Y Coordinates
				p.x = x
				p.y = y

				--Object's name (Mostly Debugging)
				p.name = name

				--Velocity of the object
				p.velocity = {}
				p.velocity["x"] = 0
				p.velocity["y"] = 0

				--Components [Will make a seperate file and add make it able to pass them in(?)]
				input = PlayerInputComponent()
				physics = StandardPhysicsComponent()

				end)

--Updates all the components in GameObject class
function GameObject:update(WORLD_PARAMS)
	input:update(self)
	physics:update(self, WORLD_PARAMS)
end

--##############################
--#         COMPONENTS         #
--##############################
--Basically this allows you to plug in different ways of doing... stuff

--Input allows for either actual physical player input, or AI input
InputComponent = class()

--Inheriets basic InputComponent class
PlayerInputComponent = class(InputComponent)

--Changes the velocity of the object but does NOT actually move it
function PlayerInputComponent:update(object)
	--Move Speed [In pixels]
	MOVE_SPEED = 3
	
	if love.keyboard.isDown("right") then
		object.velocity["x"] = MOVE_SPEED
		object.direction = "right"
	elseif love.keyboard.isDown("left") then
		object.velocity["x"] = -MOVE_SPEED
		object.direction = "left"
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

--Physics just takes the input and applies it to the object, making it do stuff
PhysicsComponent = class()

--Inherits PhysicsComponent
StandardPhysicsComponent = class(PhysicsComponent)

function StandardPhysicsComponent:update(object, WORLD_PARAMS)
	--Apply velocity and update position
	object.x = object.x + object.velocity["x"]
	object.y = object.y + object.velocity["y"]

	--If object goes out of bounds, place it on the opposite side
	if object.x > WORLD_PARAMS["width"] then
		object.x = 0
	elseif object.x < 0 then
		object.x = WORLD_PARAMS["width"]
	end

	if object.y > WORLD_PARAMS["height"] then
		object.y = 0
	elseif object.y < 0 then
		object.y = WORLD_PARAMS["height"]
	end

end
