

Ball = {}


function Ball:load()
   self.x = love.graphics.getWidth() / 2
   self.y = love.graphics.getHeight() / 2
   self.img = love.graphics.newImage("image/ball.png")
   self.width = self.img:getWidth()
   self.height = self.img:getHeight()

   self.speed = 400
   self.xVel = -self.speed
   self.yVel = 0
end









function Ball:update(dt)
   self:move(dt)
   self:collide()
end









function Ball:collide()
  self:collidewall()
  self:collideplayer()
  self:collideai()
  self:score()


end



function Ball:collidewall()
  if self.y < 0 then
     self.y = 0
     self.yVel = -self.yVel
  elseif self.y + self.height > love.graphics.getHeight() then
     self.y = love.graphics.getHeight() - self.height
     self.yVel = -self.yVel
   end
end



function Ball:collideplayer()
  if checkCollision(self, Player) then
     self.xVel = self.speed
     local middleBall = self.y + self.height / 2
     local middlePlayer = Player.y + Player.height / 2
     local collisionPosition = middleBall - middlePlayer
     self.yVel = collisionPosition * 5
   end
end





function Ball:collideai()
     if checkCollision(self, AI) then
        self.xVel = -self.speed
        local middleBall = self.y + self.height / 2
        local middleAI = AI.y + AI.height / 2
        local collisionPosition = middleBall - middleAI
        self.yVel = collisionPosition * 5
   end
end





function Ball:score()
  if self.x < 0 then
    self:resetposition(-1)
    score.ai = score.ai + 1
  end
  if self.x + self.width > love.graphics.getWidth() then
     self:resetposition(1)
     score.player = score.player + 1
  end
end




function Ball:resetposition(modifier)
     self.x = love.graphics.getWidth() / 2 - self.width / 2
     self.y = love.graphics.getHeight() / 2 - self.height / 2
     self.yVel = 0
     self.xVel = self.speed * modifier
end






function Ball:move(dt)
   self.x = self.x + self.xVel * dt
   self.y = self.y + self.yVel * dt
end


function Ball:draw()
  love.graphics.draw(self.img, self.x, self.y)

end

--BY: saleh_55s
