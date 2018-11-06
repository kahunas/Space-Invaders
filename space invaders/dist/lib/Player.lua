--- Player.lua
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
local Player = classes.class()
local Bullet = require("/lib/Bullet")





local screenWidth , screenHeight = love.graphics.getDimensions();
local fps = 60
local ticker =0
-- Two 'public' static class variables.
Player.image = love.graphics.newImage("/assets/player.png") 
Player.bulletsallowed =4
Player.NOISE_1 = 0
Player.NOISE_2 = 1
Player.numberofPlayers = 0
Player.imageHeight = Player.image:getHeight();
Player.imageWidth = Player.image:getWidth();
Player.x = screenWidth/2;
Player.y = screenHeight - (Player.imageHeight *1.5);
Player.centerx = 0
Player.centery = 0
Player.cooldown = 0

Player.bullets ={}

-- A 'private' static class variable.
local numPlayers = 0
local sound0 = love.audio.newSource("/assets/gunfire.wav", "static")
local secondsElapsed =0
local minute = 60 
local timer = 10 -- ten seconds 
--- Constructor.
--
-- @param name The name of this animal.
function Player:init ()
	-- This instance of Animal now has its own name!
  self.score = 0
	self.name = "test"
	-- There is only one variable 'numPlayers' (it's static), so incrementing it each time we create an Player gets as a unique id.
	numPlayers = numPlayers + 1
  self.numberofPlayers = numPlayers
	self.id = numPlayers
 -- print("Player Called ")
end

--- Makes a noise, specific to whatever Player I am.
-- This is an example of an 'abstract' method.
-- We want each Player to be able to make a noise, but we want each subclass of Player to decide what that noise is.
--
-- @param noiseNum This is either 0 or 1, we will say that each Player should be able to produce 2 noises.
function Player:makeNoise (noiseNum)
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


function Player:getScore()
  return self.score
end


function Player:draw()
  love.graphics.draw(Player.image,Player.x,Player.y)
 -- love.graphics.print("timer "..ticker)
  self:drawBullets()
end

function Player:drawBullets()
  for k in pairs(Player.bullets) do 
    Player.bullets[k]:draw();
  end
  
end

function Player:update(dt)
  timersAndCoolDowns(dt)
  

  Player:MovePlayer(dt)
  Player:moveBullets(dt)
  
  Player.centery = Player.y + Player.imageHeight/2;
  Player.centerx = Player.x + Player.imageWidth/2-2.5;
  
end

function Player:MovePlayer()
  -- moving left 
  if love.keyboard.isDown("left") then 
    if Player.x > 0 then 
    Player.x = Player.x -10
  end
  if Player.x <=0 then 
    Player.x =0;
  end
  
end

-- moving right 
if love.keyboard.isDown("right") then 
    if Player.x < screenWidth-Player.imageWidth then 
    Player.x = Player.x +10
  end
  if Player.x >=screenWidth then 
    Player.x = screenWidth-Player.imageWidth;
  end
  
end

-- shooting guns 
if love.keyboard.isDown("space") then 
  
  if self.cooldown <=0 then
    self:fire()
    
  end
  
end

end

function Player:fire()
  bullet ={}
  if Player.cooldown <=0 then 
    bullet = Bullet.new(Player.centerx,Player.centery,5,10);
    table.insert(Player.bullets,bullet);
    self:makeNoise(0)
    Player.cooldown = Player.cooldown + 1 
  end
 -- print("Hit spacebar bullets "..#Player.bullets)
end

function Player:moveBullets(dt)
  if #Player.bullets > 0  then 
    for key,value in pairs(Player.bullets) do 
      -- move them by calling update 
      
       Player.bullets[key]:update(dt)
       if Player.bullets[key].y <-10 then 
         table.remove(Player.bullets,k);
       end
       
    end
    
    end
    
end




function timersAndCoolDowns(dt)
  if dt > 0.35 then 
  ticker = ticker + 1/fps
  end
   if Player.cooldown > 0 then 
      if ticker >=.5 then 
       ticker =0
        Player.cooldown = Player.cooldown -1;
      end
      
  end
end

--- This method is available to the Player class, and all Subclasses of Player as well.
--
-- @return Returns the id of this Player.
function Player:getPlayerId()
	return "Player<"..self.id..">"
end

--- This is an example of a Class method.  We can't access 'self', because it represents the whole Class, not an instance of this Class.
--
-- @return Returns the total number of Players.
function Player.totalPlayers ()
	return numPlayers
end
function Player:getName()
  return self.name
end

function Player:setName(name)
  
  local nick = self.name 
  if nick == nil then 
    nick=''
  end
  
  self.name = name
 
  if nick ~= self.name then 
    -- we changed the name 
    print("set player name to "..name)
    return true
  elseif nick == self.name then 
    -- we did not camge the name 
    return false
  end

end



-- This is important for module loading, the table returned by the 'require' method is the Player class we created.
return Player