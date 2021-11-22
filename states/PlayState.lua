PlayState=Class{__includes=BaseState}

PIPE_SPEED=60
PIPE_WIDTH=70
PIPE_HEIGHT=288

BIRD_WIDTH=38
BIRD_HEIGTH=24

timer=0

bird=Bird{}

function PlayState:init()
  self.bird=Bird()
  self.pipePairs={}
  self.timer=0
  self.score=0

  self.lastY=-PIPE_HEIGHT+math.random(80)+20
end


function PlayState:update(dt)
  --Setting timer increment
  timer=timer+dt

  if timer>2 then
    local y=math.max(-PIPE_HEIGHT+10,
    math.min(self.lastY+math.random(-20,20),VIRTUAL_HEIGHT-90-PIPE_HEIGHT))
    self.lastY=y


    table.insert(self.pipePairs,PipePair(y))
    timer=0
  end


  -- for every pair of pipes..
  for k, pair in pairs(self.pipePairs) do
    if not pair.scored then
      if pair.x+PIPE_WIDTH<self.bird.x then
        self.score=self.score+1
        pair.scored=true
        sounds['score']:play()
      end
    end
      -- update position of pair
      pair:update(dt)
  end

  self.bird:update(dt)

  for k, pair in pairs(self.pipePairs) do
    for l,pipe in pairs(pair.pipes) do
      if self.bird:collides(pipe) then
        sounds['explosion']:play()
        sounds['hurt']:play()
        gStateMachine:change('score',{score=self.score})
      end
    end
  end

  for k, pair in pairs(self.pipePairs) do
    if pair.remove then
      table.remove(self.pipePairs,k)
    end--end of if par.remove
  end




    -- reset if we get to the ground
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
      gStateMachine:change('score',{score=self.score})
    end
    --Resets keyPressed table
    love.keyboard.keysPressed={}
  end--end of for k, pair in pairs



  function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
      pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: '..tostring(self.score),8,8)
    self.bird:render()
  end
