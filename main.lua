push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
	love.graphics.setDefaultFilter('nearest','nearest')

	love.window.setTitle('Pong')
	math.randomseed(os.time())

	smallFont = love.graphics.newFont('font.ttf',8)
	scoreFont = love.graphics.newFont('font.ttf',32)
	love.graphics.setFont(smallFont)

	push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
		fullscreen = true,
		resizable = false,
		vsync = true
	})

	ball = Ball(VIRTUAL_WIDTH/2-2,VIRTUAL_HEIGHT/2-2,4,4)
	player1 = Paddle(10,30,5,20)
	player2 = Paddle(VIRTUAL_WIDTH-15,VIRTUAL_HEIGHT-50,5,20)

	player1Score = 0
	player2Score = 0

	gameState = 'start'

	-- body
end

function love.update(dt)
	--player1 movement
	if love.keyboard.isDown('w') then
		player1.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown('s') then
		player1.dy = PADDLE_SPEED
	else
		player1.dy = 0
	end
	--player2 movement
	if love.keyboard.isDown('up') then
		player2.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown('down') then
		player2.dy = PADDLE_SPEED
	else
		player2.dy = 0
	end
	--ball movement
	if gameState == 'play' then
		ball:update(dt)
	end

	if ball.x<0 then
		player2Score = player2Score + 1
		ball:reset()
		gameState = 'start'
	elseif ball.x>VIRTUAL_WIDTH-4 then
		player1Score = player1Score + 1
		ball:reset()
		gameState = 'start'
	end

	player1:update(dt)
	player2:update(dt)

	-- body
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'enter' or key == 'return' then
		if gameState == 'start' then
			gameState = 'play'
		else
			gameState = 'start'
			ball:reset()
		end
	end
	-- body
end

function love.draw()
	push:apply('start')

	love.graphics.clear(40/255, 45/255, 52/255, 1)

	love.graphics.setFont(scoreFont)

	love.graphics.print(tostring(player1Score),VIRTUAL_WIDTH/2-50,VIRTUAL_HEIGHT/3)
	love.graphics.print(tostring(player2Score),VIRTUAL_WIDTH/2+30,VIRTUAL_HEIGHT/3)


    ball:render()
    player1:render()
    player2:render()

    displayFPS()

    push:apply('end')
	-- body
end

function displayFPS( ... )
	-- body
	love.graphics.setFont(smallFont)
	love.graphics.setColor(0,1,0,1)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()),10,10)
end