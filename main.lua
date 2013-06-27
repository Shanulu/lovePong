function love.load()
love.graphics.setBackgroundColor(0, 0, 0)
 
padWidth = 50
padHeight = 10

topX = love.graphics:getWidth()/2 - padWidth/2
topY = 10

botX = love.graphics:getWidth()/2 - padWidth/2
botY = love.graphics:getHeight()-20

ballRad = 10
ballX = love.graphics:getWidth()/2
ballY = love.graphics:getHeight()/2
ballVertical = -4
ballHorizontal = -4
end


function love.draw()
	love.graphics.setColor( 255, 255, 255)
	--paddleTop
	love.graphics.rectangle("fill", topX, topY, padWidth, padHeight)
	--paddleBot
	love.graphics.rectangle("fill", botX, botY, padWidth, padHeight)
	--ball
	love.graphics.circle("fill", ballX, ballY, ballRad, 100)
	
end

function love.update(dt)

	--update ball
	ballX = ballX + ballHorizontal
	ballY = ballY + ballVertical
	
	--check the left/right edges
	if ballX < 0 + ballRad then
		ballHorizontal = ballHorizontal * -1
		ballX = ballX + ballHorizontal
	end
	
	if ballX > love.graphics:getWidth()-ballRad then
		ballHorizontal = ballHorizontal * -1
		ballX = ballX + ballHorizontal
	end	
	
	--TEMPORARY check top/bottom
	if ballY < 0 + ballRad then
		ballVertical = ballVertical * -1
		ballY = ballY + ballVertical
	end
	
	if ballY > love.graphics:getHeight() - ballRad then
		ballVertical = ballVertical * -1
		ballY = ballY + ballVertical
	end
		
	love.graphics.circle("fill", ballX + ballHorizontal, ballY + ballVertical, ballRad, 100)
	
	if love.keyboard.isDown("left") then
		topX = topX - 4
		if topX < 0 then
			topX = 0
		end
	end
		
	if love.keyboard.isDown("right") then
		topX = topX + 4
		if topX > love.graphics:getWidth() - padWidth then
			topX = love.graphics:getWidth() - padWidth
		end
	end
	
	if love.keyboard.isDown("a") then
		botX = botX - 4
		if botX < 0 then
			botX = 0
		end
	end
	
	if love.keyboard.isDown("d") then
		botX = botX + 4
		if botX > love.graphics:getWidth() - padWidth then
			botX = love.graphics:getWidth() - padWidth
		end
	end
end

function love.quit()
end

function love.keypressed()
end

function love.keyreleased()
end

