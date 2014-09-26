require("class")
require("iterator")

SHOOT_BULLET = 0

BulletObserver = class()

function BulletObserver:onNotify(entity, event)
	if event == SHOOT_BULLET then

	end
end

Subject = class(function(s)
				s.observers = {}
				end)

function Subject:addObserver(observer)
	table.insert(self.observers, observer)
end

function Subject:removeObserver(observer)
	
end

function Subject:notify(entity, event)
	for observer in list_iter(self.observers) do
		observer:onNotify(entity, event)
	end
end