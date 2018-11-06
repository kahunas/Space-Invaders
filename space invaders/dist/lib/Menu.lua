--- Menu.lua
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
 
local classes = require ("/lib/classes")
 suit = require '..suit'

 
-- Create the class, with the default superclass.
local Menu = classes.class()
local GameState = require("/lib/GameState")
--local Player = require("/lib/Player")
-- Two 'public' static class variables.
Menu.player = nil

Menu.NOISE_1 = 0
Menu.NOISE_2 = 1
Menu.GAMESTATE = GameState:getGameState();
 
-- A 'private' static class variable.
local numMenus = 0
local sound0 = love.audio.newSource("/assets/gunfire.wav", "static")
local show_message = false
local width = love.graphics.getWidth( )
local height = love.graphics.getHeight()
local input = {text = ""}
local msg = "Please enter a Name ?"
--- Constructor.
--
-- @param name The name of this animal.
local time =0
function Menu:init ()
  print("menu init init Called  ")
	-- This instance of Animal now has its own name!
   
   self.gameState = self.STATE 
   self.player = player
	-- There is only one variable 'numPlayers' (it's static), so incrementing it each time we create an Player gets as a unique id.
	numMenus = numMenus + 1
	self.id = numMenus
end



function Menu:draw()
    suit.draw()
end

function Menu:update()
    getPlayersName()
 end
 
function love.update(dt)
    -- Put a button on the screen. If hit, show a message.
    
  
  
  
 
 -- GameState.setGameState(1)
 self.GAMESTATE = GameState:getGameState();
end





--- Makes a noise, specific to whatever Player I am.
-- This is an example of an 'abstract' method.
-- We want each Player to be able to make a noise, but we want each subclass of Player to decide what that noise is.
--
-- @param noiseNum This is either 0 or 1, we will say that each Player should be able to produce 2 noises.
function Menu:makeNoise (noiseNum)
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
function Menu:getMenuId ()
	return "Player<"..self.id..">"
end

--- This is an example of a Class method.  We can't access 'self', because it represents the whole Class, not an instance of this Class.
--
-- @return Returns the total number of Players.
function Menu.totalMenus ()
	return numMenus
end


-- forward keyboard events
function love.textinput(t)
    suit.textinput(t)
end

function love.keypressed(key)
    suit.keypressed(key)
end

function getPlayersName()
  suit.Label("Enter your name Here?", (width/2)-(300/2),20, 300,30)
 suit.Input(input, (width/2)-(200/2),50,200,30)
 -- print("Hello from MEnu CLass  "..self.id.." player is "..self.player)
 if suit.Button("Start Game ",(width/2)-(300/2),100, 300,30).hit then
   if input.text == '' then
      msg = "Please enter a Name ?"
      show_message = true
       
      else 
        msg = input.text.." Lets Play!!!!"
        show_message = true
        -- add a timer for like 1 to 2 seconds then we will change the state 
        local object = GameState:getPlayerObject();
        local p = object:setName(input.text)
      if p then 
        GameState:setGameState('play');
      else
         msg = input.text.." something went wrong !!"
         show_message = true
       end
       
      
        
        
      end
      
    end

    -- if the button was pressed at least one time, but a label below
    if show_message then
        suit.Label(msg, (width/2)-(300/2),150, 300,30)
    end
  
end




-- This is important for module loading, the table returned by the 'require' method is the Player class we created.
return Menu