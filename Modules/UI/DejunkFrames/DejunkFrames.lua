-- DejunkFrames: provides Dejunk frames with default functionality.

local AddonName, DJ = ...

local DejunkFrames = DJ.DejunkFrames -- See Modules.lua
local FrameFactory = DJ.FrameFactory

local DejunkFrameMixin = {
  Initialized = false
}

--[[
//*******************************************************************
//                       Init/Deinit Functions
//*******************************************************************
--]]

-- Initializes the frame.
function DejunkFrameMixin:Initialize()
  if self.Initialized then return end
  self.Initialized = true

  if not self.UI then
    self.UI = {}
  end

  self.Frame = FrameFactory:CreateFrame()

  self:OnInitialize()
end

-- Additional initialize logic. Override when necessary.
function DejunkFrameMixin:OnInitialize() end

--[[
//*******************************************************************
//                       General Frame Functions
//*******************************************************************
--]]

-- Displays the frame.
function DejunkFrameMixin:Show()
  self:Refresh()
  self.Frame:Show()
end

-- Hides the frame.
function DejunkFrameMixin:Hide()
  self.Frame:Hide()
end

-- Toggles the frame.
function DejunkFrameMixin:Toggle()
  if not self.Frame:IsVisible() then
    self:Show()
  else
    self:Hide()
  end
end

-- Enables the frame.
function DejunkFrameMixin:Enable()
  FrameFactory:EnableUI(self.UI)
end

-- Disables the frame.
function DejunkFrameMixin:Disable()
  FrameFactory:DisableUI(self.UI)
end

-- Refreshes the frame.
function DejunkFrameMixin:Refresh()
  self.Frame:Refresh()
  FrameFactory:RefreshUI(self.UI)
end

-- Resizes the frame. Override when necessary.
function DejunkFrameMixin:Resize() end

--[[
//*******************************************************************
//                         Get & Set Functions
//*******************************************************************
--]]

-- Gets the width of the frame.
-- @return - the width of the frame
function DejunkFrameMixin:GetWidth()
  return self.Frame:GetWidth()
end

-- Sets the width of the frame.
-- @param width - the new width
function DejunkFrameMixin:SetWidth(width)
  self.Frame:SetWidth(width)
end

-- Gets the height of the frame.
-- @return - the height of the frame
function DejunkFrameMixin:GetHeight()
  return self.Frame:GetHeight()
end

-- Sets the height of the frame.
-- @param height - the new height
function DejunkFrameMixin:SetHeight(height)
  self.Frame:SetHeight(height)
end

-- Sets the parent of the frame.
-- @param parent - the new parent
function DejunkFrameMixin:SetParent(parent)
  self.Frame:SetParent(parent)
end

-- Sets the point of the frame.
-- @param point - the new point
function DejunkFrameMixin:SetPoint(...)
  self.Frame:ClearAllPoints()
  self.Frame:SetPoint(unpack(...))
end

-- Perform mixins
for i, frame in pairs(DejunkFrames) do
  for k, v in pairs(DejunkFrameMixin) do
    frame[k] = v
  end
end