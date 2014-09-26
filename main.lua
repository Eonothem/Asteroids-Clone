require("objects")
require("iterator")

--Init World Paramaters
WORLD_PARAMS = {}
WORLD_PARAMS["width"] = 550
WORLD_PARAMS["height"] = 550

--Holds all of the objects in the game
object_list = {}

function love.load()
	--Set game window properties
	image = love.graphics.newImage("triangle.png")

	love.window.setMode(WORLD_PARAMS["width"], WORLD_PARAMS["height"])

	player = GameObject(100, 100, 0, PlayerInputComponent(), StandardPhysicsComponent(), image, "PLAYER")

	--Insert the player into the object list
	table.insert(object_list, player)
end

function love.update(dt)

	--Update every object in the world
	for object in list_iter(object_list) do
		--print(object.name)
		object:update(WORLD_PARAMS, object_list)
	end

end

function love.draw()
	--love.graphics.rectangle("fill", player.x, player.y, 10, 10)
	for object in list_iter(object_list) do
		love.graphics.setColor(255,255,255,255)

		--Last two params are the offset in order to make the object rotate around the center
		love.graphics.draw(object.texture, object.x, object.y, object.orientation, 1, 1, object.centerOffsetX, object.centerOffsetY)

		--Draws the orgin of the object
		love.graphics.setColor(255,0,0,255)
		love.graphics.circle("fill", object.x, object.y, 5, 100)
	end
end