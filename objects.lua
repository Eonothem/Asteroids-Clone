require("class")

--Generic class that can be any object in the game (Player/Asteroid)
GameObject = class(function(p, x, y, input, physics, texture, name)
				--Position Properties
				p.x = x
				p.y = y
				p.orientation = 0

				--Velocity of the object
				p.velocity = {}
				p.velocity["x"] = 0
				p.velocity["y"] = 0

				--Graphics Properties
				p.texture = texture

				p.centerOffsetX, p.centerOffsetY = texture:getDimensions()
				p.centerOffsetX = p.centerOffsetX/2
				p.centerOffsetY = p.centerOffsetY/2
				
				p.name = name

				--Components
				p.input = input
				p.physics = physics

				end)

--Updates all the components in GameObject class
function GameObject:update(WORLD_PARAMS)

	self.input:update(self)
	self.physics:update(self, WORLD_PARAMS)
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
	ROTATE_SPEED = 5
	
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

	if love.keyboard.isDown("a") then
		object.orientation = object.orientation-ROTATE_SPEED
	elseif love.keyboard.isDown("d") then
		object.orientation = object.orientation+ROTATE_SPEED
	end

	if love.keyboard.isDown(" ") then
		--Add observer and pass in x,y,and orientation
		--That thing creates the bullet and adds it to the world
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
