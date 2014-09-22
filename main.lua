require("objects")

function love.load()
	guy = Player(100, 100)
end

function love.update(dt)
	guy:update()
end

function love.draw()
	love.graphics.rectangle("fill", guy.x, guy.y, 10, 10)
end