Class=require'libs/class'
push = require 'libs/push'

require 'Bird'
require 'Pipe'
require 'PipePair'
require'StateMachine'
require'states/BaseState'
require'states/PlayState'
require'states/TitleScreenState'
require'states/ScoreState'
require'states/CountdownState'




WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


local background = love.graphics.newImage('pics/background.png')
local backgroundScroll=0
local backgroundScrollSpeed=30
local backgroundLoopingPoint=413

local ground = love.graphics.newImage('pics/ground.png')
local groundScroll=0
local groundScrollSpeed=60

---------------------------------------------------------------------------------------
--                                                                                   --
--                                 LOAD                                              --
--                                                                                   --
----------------------------------------------------------------------------------------
function love.load()


    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')
-- Loading Fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
	  mediumFont = love.graphics.newFont('font.ttf', 14)
    flappyFont = love.graphics.newFont('font.ttf', 28)
    hugeFont = love.graphics.newFont('font.ttf', 56)
    love.graphics.setFont(flappyFont)
-- Loading Audio
  sounds={
    ['jump']=love.audio.newSource('audio/jump.wav', 'static'),
    ['explosion']=love.audio.newSource('audio/explosion.wav', 'static'),
    ['hurt']=love.audio.newSource('audio/hurt.wav', 'static'),
    ['score']=love.audio.newSource('audio/score.wav', 'static'),


    ['music']=love.audio.newSource('audio/marios_way.mp3', 'static')
  }

  sounds['music']:setLooping(true)
  sounds['music']:play()

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable=true,
        fullscreen = false,
        vsync=true,
        })

    gStateMachine=StateMachine{
      ['title'] = function()return TitleScreenState()end,
      ['countdown']=function()return CountdownState()end,
      ['play'] = function()return PlayState() end,
      ['score']= function()return ScoreState()end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed={}

    math.randomseed(os.time())


end

---------------------------------------------------------------------------------------
--                                                                                   --
--                               UPDATE                                              --
--                                                                                   --
----------------------------------------------------------------------------------------


function love.update(dt)

  --Scrolling background
  backgroundScroll=(backgroundScroll+backgroundScrollSpeed*dt)%backgroundLoopingPoint
  --Scrolling ground
  groundScroll=(groundScroll+groundScrollSpeed*dt)%backgroundLoopingPoint


  gStateMachine:update(dt)


  --Reseting timer and adding a new Pipe





end--end of update function
  ---------------------------------------------------------------------------------------
  --                                                                                   --
  --                                KEY PROMPS                                         --
  --                                                                                   --
  ----------------------------------------------------------------------------------------


    function love.keypressed(key)
      love.keyboard.keysPressed[key]=true


      if key=='escape'then
        love.event.quit()
      end



  end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end

end



  ---------------------------------------------------------------------------------------
  --                                                                                   --
  --                                 DRAW                                              --
  --                                                                                   --
  ----------------------------------------------------------------------------------------
  function love.draw()
    push:apply('start')

      love.graphics.draw(background,-backgroundScroll,0)

      gStateMachine:render()

      love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-10)


    push:apply('end')
  end
