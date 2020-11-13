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
        center          =       {xu = 0,   yu = 0,   wu = 1,   hu = 1},
        left            =       {xu = 0,   yu = 0,   wu = 0.5, hu = 1}, 
        right           =       {xu = 0.5, yu = 0,   wu = 0.5, hu = 1}, 
        top             =       {xu = 0,   yu = 0,   wu = 1,   hu = 0.5}, 
        bottom          =       {xu = 0,   yu = 0.5, wu = 1,   hu = 0.5},
        top_left        =       {xu = 0,   yu = 0,   wu = 0.5, hu = 0.5}, 
        top_right       =       {xu = 0.5, yu = 0,   wu = 0.5, hu = 0.5}, 
        bottom_right    =       {xu = 0.5, yu = 0.5, wu = 0.5, hu = 0.5}, 
        bottom_left     =       {xu = 0,   yu = 0.5, wu = 0.5, hu = 0.5},
        third_left      =       {xu = 0,   yu = 0,   wu = 1/3, hu = 1}, 
        third_center    =       {xu = 1/3, yu = 0,   wu = 1/3, hu = 1}, 
        third_right     =       {xu = 2/3, yu = 0,   wu = 1/3, hu = 1},
        two_third_left  =       {xu = 0,   yu = 0,   wu = 2/3, hu = 1},
        two_third_right =       {xu = 1/3, yu = 0,   wu = 2/3, hu = 1},
    }
end

function Totem:bindHotKeys(mapping)
    local spec = {}
    for k,v in pairs(mapping) do
        local position = self.positions[k]
        if position ~= nil then
            spec[k] = hs.fnutils.partial(self.positionWindow, self, position)
        end
    end
    if mapping.fullscreen ~= nill then
        spec.fullscreen = hs.fnutils.partial(self.toggleFullscreen, self)
    end
    hs.spoons.bindHotkeysToSpec(spec, mapping)
end

function Totem:positionWindow(position)
    local window = hs.window.focusedWindow()
    local screen = window:screen()
    local windowFrame = window:frame()
    local screenFrame = screen:frame()
    if not self:isInPosition(window, position) then
        windowFrame.x = screenFrame.w * position.xu + screenFrame.x 
        windowFrame.y = screenFrame.h * position.yu + screenFrame.y
        windowFrame.w = screenFrame.w * position.wu
        windowFrame.h = screenFrame.h * position.hu
        self.windowPositions[window:id()] = position
        window:setFrame(windowFrame) 
        self:placeInScreenBounds(window)       
    end
end

function Totem:toggleFullscreen()
    local window = hs.window.focusedWindow()
    window:toggleFullscreen()
end

function Totem:placeInScreenBounds(window)
    windowFrame = window:frame()
    screenFrame = window:screen():frame()
    x, y = windowFrame.x, windowFrame.y
    w, h = windowFrame.w, windowFrame.h
    if windowFrame.x < screenFrame.x then
        x = screenFrame.x
    elseif windowFrame.x + windowFrame.w > screenFrame.w then
        x = screenFrame.w - windowFrame.w
    end
    if windowFrame.y < screenFrame.y then
        y = screenFrame.y
    elseif windowFrame.y + windowFrame.h > screenFrame.h then
        y = screenFrame.h - windowFrame.h
    end
    if x ~= windowFrame.x or y ~= windowFrame.y then
        window:setTopLeft(hs.geometry.point(x, y))
    end
end

function Totem:isInPosition(window, position)
    return  equivalent(self.windowPositions[window:id()], position)
end

function equivalent(pos1, pos2)
    if pos1 == nil and pos2 == nil then
        return true
    elseif pos1 == nil or pos2 == nil then
        return false
    else
        return pos1.xu == pos2.xu and pos1.yu == pos2.yu and 
               pos1.wu == pos2.wu and pos1.hu == pos2.hu
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
