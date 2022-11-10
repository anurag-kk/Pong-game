Ball = Class{}

function Ball:init(x,y,width,height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	self.dx = math.random(2) == 1 and -200 or 200
	self.dy = math.random(-50,50)
	-- body
end

function Ball:reset()
	self.x = VIRTUAL_WIDTH/2-2
	self.y = VIRTUAL_HEIGHT/2-2
	self.dx = math.random(2) == 1 and -200 or 200
	self.dy = math.random(-50,50)
	-- body
end

function Ball:update(dt)
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt

	if self:collides(player1) or self:collides(player2) then
		self.dx = -self.dx*1.05
		if self.dy < 0 then
			ball.dy = -math.random(10,150)
		else
			ball.dy = math.random(10,150)
		end
	end

	if self.y <= 0 then
		self.y = 0
		self.dy = -self.dy
	end

	if self.y >= VIRTUAL_HEIGHT - 4 then
		self.y = VIRTUAL_HEIGHT - 4
		self.dy = -self.dy
	end
	-- body
end

function Ball:render()
	love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
	-- body
end

function Ball:collides(paddle)
	if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
		return false
	end
	
	if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end 

    return true
    -- body
end