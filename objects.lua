require("helper_classes/class")
require("collision")
require("sprites")

--Generic class that can be any object in the game (Player/Asteroid)
GameObject = class(function(p, x, y, orientation, input, texture, name)
				--Position Properties
				p.x = x
				p.y = y
				p.orientation = orientation


				--Velocity of the object
				p.velocity = {}
				p.velocity["x"] = 0
				p.velocity["y"] = 0

				

				--Centers the sprite
				p.centerOffsetX, p.centerOffsetY = texture:getDimensions()
				p.centerOffsetX = p.centerOffsetX/2
				p.centerOffsetY = p.centerOffsetY/2
				
				--Collision
				p.hitCircle = Circle(x, y, p.centerOffsetX)

				--Graphics Properties
				p.texture = texture
				p.name = name

				--Components
				p.input = input
				p.physics = StandardPhysicsComponent()

				end)

--Updates all the components in GameObject class
function GameObject:update(WORLD_PARAMS, object_list)
	self.input:update(self, object_list)
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
function PlayerInputComponent:update(object, object_list)
	--Move Speed [In pixels]
	local ACCELERATION = 1
	local BRAKE_FACTOR = 0.92
	local ROTATE_SPEED = .1
	
	if love.keyboard.isDown("w") then
		object.velocity["x"] = object.velocity["x"]+ACCELERATION*math.sin(object.orientation)
		object.velocity["y"] = object.velocity["y"]-ACCELERATION*math.cos(object.orientation)
	end

	if love.keyboard.isDown("s") then
		object.velocity["x"] = object.velocity["x"]*BRAKE_FACTOR
		object.velocity["y"] = object.velocity["y"]*BRAKE_FACTOR
	end   

	if love.keyboard.isDown("a") then
		object.orientation = object.orientation-ROTATE_SPEED
	elseif love.keyboard.isDown("d") then
		object.orientation = object.orientation+ROTATE_SPEED
	end


	if love.keyboard.isDown(" ") then
		bullet = GameObject(object.x, object.y, object.orientation, BulletInputComponent(), BULLET_TEXTURE, "BULLET")
		table.insert(object_list, bullet)
	end 
end

BulletInputComponent = class(InputComponent)
function BulletInputComponent:update(object)
	local BULLET_SPEED = 20
	
	object.velocity["x"] = BULLET_SPEED*math.sin(object.orientation)
	object.velocity["y"] = -BULLET_SPEED*math.cos(object.orientation)
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

	object.hitCircle.x = object.x
	object.hitCircle.y = object.y

end
