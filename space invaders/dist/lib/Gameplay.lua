--- Gameplay.lua
--
-- A simple example of a base class usng the classes library.
--
-- @author PaulMoore
--
-- Copyright (C) 2011 by Strange Ideas Software
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-- Import the classes library.
local classes = require "/lib/classes"

-- Create the class, with the default superclass.
local Gameplay = classes.class()
local GAMESTATE = require("/lib/GameState")
local suit = require"..suit"
local EnemyController = require("/lib/Enemy_Controller")
--local Player = require("/lib/Player")

-- Two 'public' static class variables.

Gameplay.NOISE_1 = 0
Gameplay.NOISE_2 = 1
Gameplay.player = nil
-- A 'private' static class variable.
local numGameplays = 0
local player = nil
local width, height = love.graphics.getDimensions()
local score = {text = ""}
local scoreLength =0;
--- Constructor.
--
-- @param name The name of this animal.
function Gameplay:init ()
	-- This instance of Animal now has its own name!
	print("GamePlay init Called ")
  player = GAMESTATE:getPlayerObject();
  enemyController =  EnemyController:new();
  enemyController:setNumOfEnemys(20);
  enemyController:createEnemys();
	-- There is only one variable 'numPlayers' (it's static), so incrementing it each time we create an Player gets as a unique id.
	numGameplays = numGameplays + 1
	self.id = numGameplays
  
 
  
  
  

end



function Gameplay:update(dt)
 -- print("GamePlay id is "..self.id.." and i know the state is "..GAMESTATE:getGameState().."\n and player is "..player:getName())
enemyController:update()
player:update(dt);
score.text = "Score "..tostring(player:getScore());
scoreLength = #score;
--suit.Label(score.text, 100,20, 300,30)
if suit.Button(score.text,width-150,10, 150,15).hit then
  end

end

function Gameplay:draw()
  
 suit.draw()
 -- love.graphics.print(score.text,width-#score.text*10,20)
  player:draw();
  enemyController:draw()
  
end














--- Makes a noise, specific to whatever Player I am.
-- This is an example of an 'abstract' method.
-- We want each Player to be able to make a noise, but we want each subclass of Player to decide what that noise is.
--
-- @param noiseNum This is either 0 or 1, we will say that each Player should be able to produce 2 noises.
function Gameplay:makeNoise (noiseNum)
  if noiseNum == 0 then
    -- play sound 0 
    sound0:play()
  elseif noiseNum == 1 then
    --play sound 1 
    sound1:play()
  else
   -- we dont have that noise  
	error("I don't know what to do, I'm a generic Player.  This should be implemented by a subclass of Player!")
  end

end

--- This method is available to the Player class, and all Subclasses of Player as well.
--
-- @return Returns the id of this Player.
function Gameplay:getGameplayId ()
	return "Gameplay<"..self.id..">"
end

--- This is an example of a Class method.  We can't access 'self', because it represents the whole Class, not an instance of this Class.
--
-- @return Returns the total number of Players.
function Gameplay.totalGameplays ()
	return numGameplays
end

-- This is important for module loading, the table returned by the 'require' method is the Player class we created.
return Gameplay