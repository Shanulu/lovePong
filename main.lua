function love.load()
	love.graphics.setBackgroundColor (0, 0, 0)
	
	--enable physics and create a world for them to live in	
	world = love.physics.newWorld(0, 0, true)
	--physics call backs
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	
	text = ""
	persisting = 0
	
	--create my blank objects
	objects = {}
	
	-- create my top paddle
	objects.paddleTop = {}

	objects.paddleTop.body = love.physics.newBody(world, love.graphics.getWidth()/2, 25, "dynamic")
	objects.paddleTop.shape = love.physics.newRectangleShape(55, 10)
	objects.paddleTop.fixture = love.physics.newFixture(objects.paddleTop.body, objects.paddleTop.shape)
	
	--create bottom paddle
	objects.paddleBot = {}
	
	objects.paddleBot.body = love.physics.newBody(world, love.graphics.getWidth()/2, love.graphics.getHeight()-25, "dynamic")
	objects.paddleBot.shape = love.physics.newRectangleShape(55, 10)
	objects.paddleBot.fixture = love.physics.newFixture(objects.paddleBot.body, objects.paddleBot.shape)
	
	--create a ball
	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2, "dynamic")
	objects.ball.shape = love.physics.newCircleShape(10)
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape)
	objects.ball.body:setMass(10)
	--objects.ball.shape:setRestitution(0.4) 				--bouncy ness
	
	--set ball movement
	objects.ball.body:setLinearVelocity(0, -200)
	
end

function love.draw()
	-- draw my objects here
	love.graphics.setColor(255, 255, 255)
	love.graphics.polygon("fill", objects.paddleTop.body:getWorldPoints(objects.paddleTop.shape:getPoints()))
	love.graphics.polygon("fill", objects.paddleBot.body:getWorldPoints(objects.paddleTop.shape:getPoints()))
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
	
end

function checkCircularCollision(ax, ay, bx, by, ar, br)
    local dx = bx - ax
    local dy = by - ay
    local dist = math.sqrt(dx * dx + dy * dy)
    return dist < ar + br
end

function love.update(dt)
	world:update(dt)

	if love.keyboard.isDown("left") then
		objects.paddleBot.body:setLinearVelocity(-200, 0)
	end
	
	if love.keyboard.isDown("right") then
		objects.paddleBot.body:setLinearVelocity(200, 0)
	end
	if love.keyboard.isDown("a") then
		objects.paddleTop.body:setLinearVelocity(-200, 0)
	end
	
	if love.keyboard.isDown("d") then
		objects.paddleTop.body:setLinearVelocity(200, 0)
	end
		

end

function love.focus(bool)

end

function love.keypressed(key)	
end

function love.keyreleased(key)
	if key == "left" or key == "right" then
		objects.paddleBot.body:setLinearVelocity(0, 0)
	end
	
	if key == "a" or key == "d" then
		objects.paddleTop.body:setLinearVelocity(0, 0)
	end
	
end
-- a is the first Fixture objects, b is the second fixture object, coll is the contact object created
function beginContact(a, b,  coll)
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.quit()
end