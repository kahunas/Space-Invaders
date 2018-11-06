local GamePlayer = require("/lib/Player")

local GameState = {}
 STATE = nil
 PLAYER = GamePlayer:new() 
 FPS = 60 

function GameState:setPlayer(playerObject)
  PLAYER = playerObject;
end

function GameState:getPlayerObject()
  return PLAYER;
end
function GameState:getFPS()
  return FPS;
end

function GameState:setGameState(state)
    -- here: access global state variable vs. access module specific reference to global state variable
    STATE = state
end

function GameState:getGameState()
  return STATE
end


return GameState