require("objects")
require("iterator")

--Init World Paramaters
WORLD_PARAMS = {}
WORLD_PARAMS["width"] = 400
WORLD_PARAMS["height"] = 400

--Holds all of the objects in the game
object_list = {}

function love.load()
	--Set game window properties
	love.window.setMode(WORLD_PARAMS["width"], WORLD_PARAMS["height"])

	player = GameObject(100, 100, "PLAYER")

	--Insert the player into the object list
	table.insert(object_list, player)
end

function love.update(dt)

	--Update every object in the world
	for object in list_iter(object_list) do
		object:update(WORLD_PARAMS)
	end

end

function love.draw()
	love.graphics.rectangle("fill", player.x, player.y, 10, 10)
end