ScoreState=Class{__includes=BaseState}


function ScoreState:enter(params)
    self.score = params.score
end



function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end


function ScoreState:render()
  love.graphics.setFont(flappyFont)
  love.graphics.printf('You Lost!',0,64,VIRTUAL_WIDTH,'center')

  love.graphics.setFont(mediumFont)
  love.graphics.printf('Score: '..tostring(self.score),0,160,VIRTUAL_WIDTH,'center')

  love.graphics.printf('Press Enter to try again!',0,180,VIRTUAL_WIDTH,'center')
end
