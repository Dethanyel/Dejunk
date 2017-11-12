-- Dejunk_ListButton: contains FrameFactory functions to create a button for a list frame.

local AddonName, DJ = ...

-- Libs
local L = LibStub('AceLocale-3.0'):GetLocale(AddonName)

-- Dejunk
local FrameFactory = DJ.FrameFactory

local Colors = DJ.Colors
local Consts = DJ.Consts
local ListManager = DJ.ListManager
local Tools = DJ.Tools
local FrameCreator = DJ.FrameCreator

--[[
//*******************************************************************
//  					    	     List Button Functions
//*******************************************************************
--]]

-- Creates and returns a button to be displayed in a list frame.
-- @param parent - the parent frame
-- @param listName - the name of a list defined in ListManager
-- @return - a Dejunk list button
function FrameFactory:CreateListButton(parent, listName)
  assert(ListManager[listName] ~= nil)

  local button = FrameCreator:CreateButton(parent)
  button:SetHeight(Consts.LIST_BUTTON_HEIGHT)
  button.FF_ObjectType = "ListButton"

  button.Texture = FrameCreator:CreateTexture(button)
  button.Texture:SetColorTexture(unpack(Colors:GetColor(Colors.ListButton)))

  button.Icon = FrameCreator:CreateTexture(button, "ARTWORK")
  button.Icon:ClearAllPoints()
  button.Icon:SetPoint("LEFT", Tools:Padding(0.5), 0)
  button.Icon:SetWidth(Consts.LIST_BUTTON_ICON_SIZE)
  button.Icon:SetHeight(Consts.LIST_BUTTON_ICON_SIZE)

  button.Text = FrameCreator:CreateFontString(button, "OVERLAY", "GameFontNormal")
  button.Text:SetPoint("LEFT", button.Icon, "RIGHT", Tools:Padding(0.5), 0)
  button.Text:SetPoint("RIGHT", -Tools:Padding(0.5), 0)
  button.Text:SetWordWrap(false)
  button.Text:SetJustifyH("LEFT")

  -- Sets the item data to be displayed.
  function button:SetItem(item)
    self.NewTooltip = (self.Item ~= item) and true or false
    self.Item = item
    self:Refresh()
  end

  -- Refreshes the frame.
  function button:Refresh()
    if not self.Item then self:Hide() return end

    -- Texture
    if ((self == GetMouseFocus()) and self.NewTooltip) then
      self:GetScript("OnEnter")(self)
    else
      -- OnLeave hides the current tooltip, so we don't call it
      self.Texture:SetColorTexture(unpack(Colors:GetColor(Colors.ListButton)))
    end

    -- Data
    self.Icon:SetTexture(self.Item.Texture)
    self.Text:SetText(format("[%s]", self.Item.Name))
    self.Text:SetTextColor(unpack(Colors:GetColorByQuality(self.Item.Quality)))
  end

  -- Scripts
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  button:SetScript("OnClick", function(self, button, down)
    if (button == "LeftButton") then
      if IsControlKeyDown() then
        DressUpVisual(self.Item.Link) -- FrameXML/DressUpFrames.lua
      else
        parent:DropItem()
      end
    elseif (button == "RightButton") then
      ListManager:RemoveFromList(listName, self.Item.ItemID)
    end
  end)

  button:SetScript("OnEnable", function(self) self:SetAlpha(1) end)
  button:SetScript("OnDisable", function(self) self:SetAlpha(0.3) end)

  button:SetScript("OnEnter", function(self)
    self.Texture:SetColorTexture(unpack(Colors:GetColor(Colors.ListButtonHi)))
    Tools:ShowItemTooltip(self, "ANCHOR_TOP", button.Item.Link) end)
  button:SetScript("OnLeave", function(self)
    self.Texture:SetColorTexture(unpack(Colors:GetColor(Colors.ListButton)))
    Tools:HideTooltip() end)

  button:Refresh()

  return button
end
