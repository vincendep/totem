-- Copyright (c) 2020 Vincenzo De Petris
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this 
-- software and associated documentation files (the "Software"), to deal in the Software 
-- without restriction, including without limitation the rights to use, copy, Totemify, merge,
-- publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
-- to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies
-- or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.

--- === Totem ===
local Totem = {}

Totem.name      =   "Totem"
Totem.version   =   "1.0"
Totem.author    =   "Vincenzo De Petris <vincenzodepetris@gmail.com>"
Totem.homepage  =   "https://github.com/vincendep/totem"
Totem.license   =   "MIT - https://opensource.org/licenses/MIT"

function Totem:init()
    self.windowPositions = {}
    self.positions = {
        center = hs.geometry.rect(0,0,1,1),
        left = hs.geometry.rect(0,0,0.5,1), 
        right = hs.geometry.rect(0.5,0,.5,1), 
        top = hs.geometry.rect(0,0,1,0.5), 
        bottom = hs.geometry.rect(0,0.5,1,0.5),
        top_left = hs.geometry.rect(0,0,0.5,0.5), 
        top_right = hs.geometry.rect(0.5,0,0.5,0.5), 
        bottom_right = hs.geometry.rect(0.5,0.5,0.5,0.5), 
        bottom_left = hs.geometry.rect(0,0.5,0.5,0.5),
        third_left = hs.geometry.rect(0,0,1/3,1), 
        third_center = hs.geometry.rect(1/3,0,1/3,1), 
        third_right = hs.geometry.rect(2/3,0,1/3,1),
        two_third_left = hs.geometry.rect(0,0,2/3,1),
        two_third_right = hs.geometry.rect(1/3,0,2/3,1),
    }
end

function Totem:bindHotKeys(mapping)
    local spec = {}
    for k,v in pairs(mapping) do
        local position = self.positions[k]
        if position ~= nil then
            spec[k] = hs.fnutils.partial(self.setWindowInPosition, self, position)
        end
    end
    hs.spoons.bindHotkeysToSpec(spec, mapping)
end

function Totem:setWindowInPosition(position)
    local window = hs.window.focusedWindow()
    local screen = window:screen()
    local windowFrame = window:frame()
    local screenFrame = screen:frame()
    if self:isWindowInPosition(window, position) then
        window:move(windowFrame:toUnitRect(screenFrame), screen:next(), true, 0)
    else
        windowFrame.x = screenFrame.w * position.x + screenFrame.x 
        windowFrame.y = screenFrame.h * position.y + screenFrame.y
        windowFrame.w = screenFrame.w * position.w
        windowFrame.h = screenFrame.h * position.h
        self.windowPositions[window:id()] = position
        window:setFrameInScreenBounds(windowFrame) 
    end
end

function Totem:isWindowInPosition(window, position)
    return  compareRect(self.windowPositions[window:id()], position)
end

function compareRect(rect1, rect2)
  if rect1 == nil and rect2 == nil then
      return true
  elseif rect1 == nil or rect2 == nil then
      return false
  else
      return rect1.x == rect2.x and rect1.y == rect2.y and 
             rect1.w == rect2.w and rect1.h == rect2.h
  end
end

function invertTable(t)
  local s={}
  for k,v in pairs(t) do
      s[v]=k
  end
  return s
end

return Totem
