function resetBall()
	print("resetting")
	if math.random(1,2) == 2 then
		ballVertical = math.random(1,5) * -1
	else
		ballVertical = math.random(1,5)
	end
	if math.random(1,2) == 2 then
		ballHorizontal = math.random(1,3)
	else
		ballHorizontal = math.random(1,3) * -1
	end
	ballX = love.graphics:getWidth()/2
	ballY = love.graphics:getHeight()/2
	bounced = true
end

function bounceBall()
	--bounce the ball
	if math.abs(ballVertical) == ballVertical then
	--its going down, positive so ADD
		if math.abs(ballVertical) < 6 then      --need to limit ball speed else it just blows by the checks
			ballVertical = (ballVertical + 1)
		end
	else --its going UP, negative
		if math.abs(ballVertical) < 6 then
			ballVertical = (ballVertical - 1)
		end
	end
	--reverse direction	
	ballVertical = ballVertical * -1
	ballY = ballY + ballVertical
	bounced = true
end


--these checks are piss poor especially at high rates of ball speed
function checkTop()
	--check top paddle for bounce
	if ballX >= topX 
	and ballX <= topX + padWidth 
	and ballY <= topY + padHeight 
	and ballY >= topY then
		bounceBall()
	end

end

function checkBot()
	if ballX >= botX
	and ballX <= botX + padWidth
	and ballY >= botY
	and ballY <= botY + padHeight then
		--bounce
		bounceBall()
	end
end
	
function love.load()
	love.graphics.setBackgroundColor(0, 0, 0)
 
	padWidth = 50
	padHeight = 10

	topX = love.graphics:getWidth()/2 - padWidth/2
	topY = 10

	botX = love.graphics:getWidth()/2 - padWidth/2
	botY = love.graphics:getHeight()-20

	ballRad = 10
	
	resetBall()
	botScore = 0
	topScore = 0
end

function love.draw()
	love.graphics.setColor( 255, 255, 255)
	--paddleTop
	love.graphics.rectangle("fill", topX, topY, padWidth, padHeight)
	--paddleBot
	love.graphics.rectangle("fill", botX, botY, padWidth, padHeight)
	--ball
	love.graphics.circle("fill", ballX, ballY, ballRad, 100)
	love.graphics.print("Top Score: ", 25, 50)
	love.graphics.print(topScore , 100, 50)
	love.graphics.print("Bot Score: ", love.graphics:getWidth() - 100, love.graphics:getHeight() - 50)
	love.graphics.print(botScore , love.graphics:getWidth() - 25, love.graphics:getHeight() - 50)
end

function love.update(dt)
	---testing speeds, prevents spam in console
	if bounced == true then
		print(ballVertical)
		bounced = false
	end 
	
	--update ball
	ballX = ballX + ballHorizontal
	ballY = ballY + ballVertical
	love.graphics.circle("fill", ballX + ballHorizontal, ballY + ballVertical, ballRad, 100)
	
	--check the left/right edges
	if ballX < 0 + ballRad then
		ballHorizontal = ballHorizontal * -1
		ballX = ballX + ballHorizontal
	end
	
	if ballX > love.graphics:getWidth()-ballRad then
		ballHorizontal = ballHorizontal * -1
		ballX = ballX + ballHorizontal
	end		
	
	checkTop()
	checkBot()
	--check for scoring
	if ballY >= love.graphics:getHeight() then
		--award top score
		topScore = topScore + 1
		resetBall()
	end
	
	if ballY <= 0 then
		--award bottom score
		botScore = botScore + 1
		resetBall()
		ballX = love.graphics:getWidth()/2
		ballY = love.graphics:getHeight()/2 
	end
		
	if love.keyboard.isDown("left") then
		topX = topX - 5
		if topX < 0 then
			topX = 0
		end
	end
		
	if love.keyboard.isDown("right") then
		topX = topX + 5
		if topX > love.graphics:getWidth() - padWidth then
			topX = love.graphics:getWidth() - padWidth
		end
	end
	
	if love.keyboard.isDown("a") then
		botX = botX - 5
		if botX < 0 then
			botX = 0
		end
	end
	
	if love.keyboard.isDown("d") then
		botX = botX + 5
		if botX > love.graphics:getWidth() - padWidth then
			botX = love.graphics:getWidth() - padWidth
		end
	end
end

function love.quit()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
	
end
