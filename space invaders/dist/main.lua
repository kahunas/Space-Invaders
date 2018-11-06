local pathOfThisFile = ...
local folderOfThisFile = (...):match("(.-)[^%.]+$") -- returns 'lib.foo.'

--print("path is "..pathOfThisFile)
--print()
--print("folder is "..folderOfThisFile)
local classes = require ("/lib/classes")
-- Import the Player class.
local Menu = require "/lib/Menu"
local GameState = require('/lib/GameState')
local GamePlay = require('/lib/GamePlay')

-- Create an instance of the Player class.



local GAMESTATE = GameState
local gameplay = GamePlay:new();
local menu = Menu:new();
local ticker =0
function love:load()
   GAMESTATE:setGameState('menu');
    
    
   
   
end

function love:draw()
 if state =='menu' then 
    
    menu:draw()
elseif state =='play' then 
    
    gameplay:draw()
elseif state =='endplay' then 
    
    endplay:draw()
end
  
 
 
  
end

function love:update(dt)
  state = GAMESTATE:getGameState();
ticker = ticker + .01
if state =='menu' then 
    
    menu:update(dt)
elseif state =='play' then 
    
    gameplay:update(ticker)
elseif state =='endplay' then 
    
    endplay:update(dt)
end

 --print("state is "..gamestate:getGameState())
 
end
