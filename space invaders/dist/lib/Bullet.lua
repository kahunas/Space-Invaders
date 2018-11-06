--- Bullet.lua
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
local Bullet = classes.class()


 
-- A 'private' static class variable.
local numBullets = 0


--- Constructor.
--
-- @param name The name of this animal.
function Bullet:init (locx,locy,width,height)
  print("player called init"..locx)
	self.x = locx;
  self.y = locy;
  self.width = width;
  self.height = height;
  self.speed = 20;
	-- There is only one variable 'numPlayers' (it's static), so incrementing it each time we create an Player gets as a unique id.
	numBullets = numBullets + 1
	self.id = numBullets
  print("player called number of bullets "..numBullets)
end

function Bullet:draw()
  love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end

function Bullet:update()
  self.y = self.y - self.speed;
  
  
end


-- @return Returns the total number of Bullets.
function Bullet.totalBullets ()
	return numBullets
end

-- This is important for module loading, the table returned by the 'require' method is the Player class we created.
return Bullet