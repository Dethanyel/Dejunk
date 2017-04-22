--[[
Copyright 2017 Justin Moody

Dejunk is distributed under the terms of the GNU General Public License.
You can redistribute it and/or modify it under the terms of the license as
published by the Free Software Foundation.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this addon. If not, see <http://www.gnu.org/licenses/>.

This file is part of Dejunk.
--]]

-- Dejunk_TransportChildFrame: displays an edit box for importing or exporting list data.

local AddonName, DJ = ...

-- Libs
local L = LibStub('AceLocale-3.0'):GetLocale(AddonName)

-- Dejunk
local TransportChildFrame = DJ.TransportChildFrame

local Core = DJ.Core
local Colors = DJ.Colors
local Tools = DJ.Tools
local ListManager = DJ.ListManager
local FrameFactory = DJ.FrameFactory

-- Variables
TransportChildFrame.Initialized = false
TransportChildFrame.UI = {}

TransportChildFrame.Types =
{
  ["Import"] = true,
  ["Export"] = true,
}

-- Add type keys
for k in pairs(TransportChildFrame.Types) do
  TransportChildFrame[k] = k end

local currentList = nil
local currentType = nil

--[[
//*******************************************************************
//                       Init/Deinit Functions
//*******************************************************************
--]]

-- Initializes the frame.
function TransportChildFrame:Initialize()
  if self.Initialized then return end

  local ui = self.UI

  ui.Frame = FrameFactory:CreateFrame()

  self:CreateTransportFrame()

  self.Initialized = true
end

-- Deinitializes the frame.
function TransportChildFrame:Deinitialize()
  if not self.Initialized then return end

  FrameFactory:ReleaseUI(self.UI)

  self.Initialized = false
end

--[[
//*******************************************************************
//                       General Frame Functions
//*******************************************************************
--]]

-- Displays the frame.
function TransportChildFrame:Show()
  if not self.UI.Frame:IsVisible() then
    self.UI.Frame:Show() end
end

-- Hides the frame.
function TransportChildFrame:Hide()
  self.UI.Frame:Hide()
end

-- Enables the frame.
function TransportChildFrame:Enable()
  for k, v in pairs(self.UI) do
    if v.SetEnabled then
      v:SetEnabled(true) end
  end
end

-- Disables the frame.
function TransportChildFrame:Disable()
  for k, v in pairs(self.UI) do
    if v.SetEnabled then
      v:SetEnabled(false) end
  end
end

-- Refreshes the frame.
function TransportChildFrame:Refresh()
  -- This is to recolor the title text
  local listName = nil
  if (currentList == ListManager.Inclusions) then
    listName = Tools:GetInclusionsString()
  else -- Exclusions
    listName = Tools:GetExclusionsString()
  end

  if (currentType == self.Import) then
    self.UI.TitleFontString:SetText(format(L.IMPORT_TITLE_TEXT, listName))
  else -- Export
    self.UI.TitleFontString:SetText(format(L.IMPORT_TITLE_TEXT, listName))
  end

  FrameFactory:RefreshUI(self.UI)
end

-- Resizes the frame.
function TransportChildFrame:Resize()
  local ui = self.UI

  ui.TextField:Resize()
  ui.LeftButton:Resize()
  ui.BackButton:Resize()

  local newWidth = max(ui.LeftButton:GetMinWidth(), ui.BackButton:GetMinWidth())
  newWidth = ((newWidth * 2) + Tools:Padding(0.5))
  newWidth = max(newWidth, ui.TextField:GetWidth())
  newWidth = max(newWidth, ui.TitleFontString:GetWidth())

  local titleHeight = (ui.TitleFontString:GetHeight() + Tools:Padding())
  local textFieldHeight = (ui.TextField:GetHeight() + Tools:Padding(0.5))
  local buttonHeight = ui.LeftButton:GetMinHeight()

  local newHeight = (titleHeight + textFieldHeight + buttonHeight)

  self:SetWidth(1)
  self:SetHeight(newHeight)
end

--[[
//*******************************************************************
//                         Get & Set Functions
//*******************************************************************
--]]

-- Gets the width of the frame.
-- @return - the width of the frame
function TransportChildFrame:GetWidth()
  return self.UI.Frame:GetWidth()
end

-- Sets the width of the frame.
-- @param width - the new width
function TransportChildFrame:SetWidth(width)
  self.UI.Frame:SetWidth(width)
end

-- Gets the height of the frame.
-- @return - the height of the frame
function TransportChildFrame:GetHeight()
  return self.UI.Frame:GetHeight()
end

-- Sets the height of the frame.
-- @param height - the new height
function TransportChildFrame:SetHeight(height)
  self.UI.Frame:SetHeight(height)
end

-- Sets the parent of the frame.
-- @param parent - the new parent
function TransportChildFrame:SetParent(parent)
  self.UI.Frame:SetParent(parent)
end

-- Sets the point of the frame.
-- @param point - the new point
function TransportChildFrame:SetPoint(point)
  self.UI.Frame:ClearAllPoints()
  self.UI.Frame:SetPoint(unpack(point))
end

-- Sets the list and transport type for the frame.
-- @param listName - the name of the list used for transport operations
-- @param transportType - the type of transport operations to perform
function TransportChildFrame:SetData(listName, transportType)
  assert(self.Initialized)
  assert(self[transportType])
  assert(ListManager[listName] ~= nil)

  local ui = self.UI
  local editBox = ui.TextField.EditBoxFrame.EditBox

  currentList = listName
  currentType = transportType

  if (listName == ListManager.Inclusions) then
    listName = Tools:GetInclusionsString()
  else -- Exclusions
    listName = Tools:GetExclusionsString()
  end

  if (transportType == self.Import) then
    ui.TitleFontString:SetText(format(L.IMPORT_TITLE_TEXT, listName))
    ui.TextField:SetLabelText(L.IMPORT_LABEL_TEXT)
    ui.TextField:SetHelperText(L.IMPORT_HELPER_TEXT)

    editBox:SetFocus()

    ui.LeftButton.Text:SetText(L.IMPORT_TEXT)
    ui.LeftButton:SetScript("OnClick", function(self, button, down)
      ListManager:ImportToList(currentList, editBox:GetText())
      editBox:ClearFocus() end)
  else -- Export
    local exportFunc = function()
      editBox:SetText(ListManager:ExportFromList(currentList))
      editBox:SetFocus()
      editBox:SetCursorPosition(0)
      editBox:HighlightText()
    end

    exportFunc()

    ui.TitleFontString:SetText(format(L.EXPORT_TITLE_TEXT, listName))
    ui.TextField:SetLabelText(L.EXPORT_LABEL_TEXT)
    ui.TextField:SetHelperText(L.EXPORT_HELPER_TEXT)

    ui.LeftButton.Text:SetText(L.EXPORT_TEXT)
    ui.LeftButton:SetScript("OnClick", function(self, button, down) exportFunc() end)
  end
end

--[[
//*******************************************************************
//                      Frame Creation Functions
//*******************************************************************
--]]

-- Creates the components that make up the transport frame.
function TransportChildFrame:CreateTransportFrame()
  local ui = self.UI

  -- Title
  ui.TitleFontString = FrameFactory:CreateFontString(ui.Frame, nil, "GameFontNormalHuge", Colors.LabelText)
  ui.TitleFontString:SetPoint("TOP")

  -- Left button
  ui.LeftButton = FrameFactory:CreateButton(ui.Frame, "GameFontNormalSmall")
  ui.LeftButton:SetPoint("BOTTOMLEFT", Tools:Padding(), 0)
  ui.LeftButton:SetPoint("BOTTOMRIGHT", ui.Frame, "BOTTOM", -Tools:Padding(0.25), 0)

  -- Back button
  ui.BackButton = FrameFactory:CreateButton(ui.Frame, "GameFontNormalSmall", L.BACK_TEXT)
  ui.BackButton:SetPoint("BOTTOMRIGHT", -Tools:Padding(), 0)
  ui.BackButton:SetPoint("BOTTOMLEFT", ui.Frame, "BOTTOM", Tools:Padding(0.25), 0)
  ui.BackButton:SetScript("OnClick", function(self, button, down)
    Core:ShowPreviousChild()
  end)

  -- Text frame
  ui.TextField = FrameFactory:CreateTextField(ui.Frame, "GameFontNormal")
  ui.TextField:SetPoint("BOTTOMLEFT", ui.LeftButton, "TOPLEFT", 0, Tools:Padding())
  ui.TextField:SetPoint("BOTTOMRIGHT", ui.BackButton, "TOPRIGHT", 0, Tools:Padding())
end
