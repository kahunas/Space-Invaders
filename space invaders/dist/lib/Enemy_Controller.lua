--- Enemy_Controller.lua
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
local Enemy = require("/lib/Enemy")
-- Create the class, with the default superclass.
local Enemy_Controller = classes.class()

-- Two 'public' static class variables.
Enemy_Controller.ENEMYS ={}
 
-- A 'private' static class variable.
local numEnemy_Controllers = 0
 
--- Constructor.
--
-- @param name The name of this animal.
function Enemy_Controller:init ()
	-- This instance of Animal now has its own name!
  self.Enemys = {}
  print("Hello from Enemy Controller init ")
	self.numEnemys = 0
  
  self.EnemyBullets={}
	-- There is only one variable 'numPlayers' (it's static), so incrementing it each time we create an Player gets as a unique id.
	numEnemy_Controllers = numEnemy_Controllers + 1
	self.id = numEnemy_Controllers
end


function Enemy_Controller:draw()
  self:drawEnemys()
end

function Enemy_Controller:update()
  self:updateEnemys()
end

function Enemy_Controller:setLevel()
  
end

function Enemy_Controller:setNumOfEnemys(number)
  self.numEnemys = number
  
end

function Enemy_Controller:createEnemys()
   
       for r = 1 , 2  do
    
        for colum =1 , 10 do 
          
          x = 20*colum
          y =60*r
          local  enemy = Enemy:init(x,y);
          print("x "..20*colum.." y "..60*r)
          table.insert(Enemy_Controller.ENEMYS,enemy);
        end
        
        end
        
      
  
   
end

function Enemy_Controller:updateEnemys()
   for k,v in pairs(self.Enemys) do 
       ENEMYS[k]:update()
      end
end

function Enemy_Controller:drawEnemys()
  print("num of enemys to draw "..#Enemy_Controller.ENEMYS)
      for k,v in pairs(Enemy_Controller) do 
      -- print("ec "..k)
      end
      
  
end







--- Makes a noise, specific to whatever Player I am.
-- This is an example of an 'abstract' method.
-- We want each Player to be able to make a noise, but we want each subclass of Player to decide what that noise is.
--
-- @param noiseNum This is either 0 or 1, we will say that each Player should be able to produce 2 noises.

--- This method is available to the Player class, and all Subclasses of Player as well.
--
-- @return Returns the id of this Player.
function Enemy_Controller:getEnemy_ControllerId ()
	return "Enemy_Controller<"..self.id..">"
end

--- This is an example of a Class method.  We can't access 'self', because it represents the whole Class, not an instance of this Class.
--
-- @return Returns the total number of Players.
function Enemy_Controller.totalEnemy_Controllers ()
	return numEnemy_Controllers
end

-- This is important for module loading, the table returned by the 'require' method is the Player class we created.
return Enemy_Controller