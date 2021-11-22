Bird=Class{}


local GRAVITY=20


function Bird:init()
  self.image=love.graphics.newImage('pics/bird.png')
  self.width=self.image:getWidth()
  self.height=self.image:getHeight()
  self.dy=0



  self.x=512/2-(self.width)
  self.y=288/2-(self.height)


end


function Bird:update(dt)

self.dy=self.dy+GRAVITY*dt
self.y=self.y+self.dy

if love.keyboard.wasPressed('space') then
  sounds['jump']:play()
  self.dy= -5
end


end


function Bird:collides(pipe)
  if (self.x+2)+(self.width-4)>=pipe.x and self.x+2<=pipe.x +PIPE_WIDTH then
    if(self.y+3)+(self.height-3)>=pipe.y and self.y+3<=pipe.y+PIPE_HEIGHT then
      return true
    end
  end
  return false
end

function Bird:render()
  love.graphics.draw(self.image,self.x,self.y)
end
