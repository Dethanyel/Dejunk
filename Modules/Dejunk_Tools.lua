-- Dejunk_Tools: contains helpful functions such as coloring a string, displaying a tooltip, etc.

local AddonName, DJ = ...

-- Libs
local L = LibStub('AceLocale-3.0'):GetLocale(AddonName)

-- Upvalues
local Clamp = Clamp
local GameTooltip = GameTooltip

local sort = table.sort
local pairs, ipairs = pairs, ipairs

-- Dejunk
local Tools = DJ.Tools

local Colors = DJ.Colors
local Consts = DJ.Consts

--[[
//*******************************************************************
//  					    			   Color Functions
//*******************************************************************
--]]

-- Formats and returns a string with the specified color.
-- @oaram string - the string to color
-- @param color  - Colors string or table: {r, g, b[, a]}
-- @return - a string formatted with color
function Tools:GetColorString(string, color)
  local r, g, b = 0, 0, 0

  if type(color) == "string" then
    r, g, b = unpack(Colors:GetColor(color))
  else
    r, g, b = unpack(color)
  end

  -- Convert to value between 0-255
  r = (Clamp(r, 0, 1) * 255)
  g = (Clamp(g, 0, 1) * 255)
  b = (Clamp(b, 0, 1) * 255)

  -- Color format (hex): AARRGGBB
  -- %2x = two-digit hex value
  return format("|cFF%2x%2x%2x%s|r", r, g, b, string)
end

-- Returns a random color.
-- @return color table: {r, g, b}
function Tools:GetRandomColor()
  return {math.random(), math.random(), math.random()}
end

-- Returns the localized Inclusions string in color.
function Tools:GetInclusionsString()
  return self:GetColorString(L.INCLUSIONS_TEXT, Colors.Inclusions)
end

-- Returns the localized Exclusions string in color.
function Tools:GetExclusionsString()
  return self:GetColorString(L.EXCLUSIONS_TEXT, Colors.Exclusions)
end

--[[
//*******************************************************************
//  					    			  Tooltip Functions
//*******************************************************************
--]]

-- Displays a generic game tooltip.
-- @param owner - the frame the tooltip belongs to
-- @param anchorType - the anchor type ("ANCHOR_LEFT", "ANCHOR_CURSOR", etc.)
-- @param title - the title of the tooltip
-- @param ... - the body lines of the tooltip
function Tools:ShowTooltip(owner, anchorType, title, ...)
	GameTooltip:SetOwner(owner, anchorType)
	GameTooltip:SetText(title, 1.0, 0.82, 0)

	for k, v in ipairs({...}) do
    --if (type(v) == "function") then v = v() end
		GameTooltip:AddLine(v, 1, 1, 1, true)
	end

	GameTooltip:Show()
end

-- Displays a tooltip for an item.
-- @param owner - the frame the tooltip belongs to
-- @param anchorType - the anchor type ("ANCHOR_LEFT", "ANCHOR_CURSOR", etc.)
-- @param link - the link of the item to display
function Tools:ShowItemTooltip(owner, anchorType, link)
	GameTooltip:SetOwner(owner, anchorType)
	GameTooltip:SetHyperlink(link)
	GameTooltip:Show()
end

-- Hides the game tooltip.
function Tools:HideTooltip()
  GameTooltip:Hide()
end

--[[
//*******************************************************************
//  					    			      UI Functions
//*******************************************************************
--]]

local sizer = UIParent:CreateTexture("DejunkSizer", "BACKGROUND")
sizer:SetColorTexture(0, 0, 0, 0)

-- Measures the width and height between the top-left point of the startRegion
-- and the bottom-right point of the endRegion.
-- @param parent - the parent frame used to create a temporary texture
-- @param startRegion - the left-most region
-- @param endRegion - the right-most region
-- @param startPoint - the point on the startRegion to measure from [optional]
-- @param endPoint - the point on the endRegion to measure to [optional]
-- @return width - the width between the two regions
-- @return height - the height
function Tools:Measure(parent, startRegion, endRegion, startPoint, endPoint)
  sizer:ClearAllPoints()
  sizer:SetParent(parent)
  sizer:SetPoint(startPoint or "TOPLEFT", startRegion)
  sizer:SetPoint(endPoint or "BOTTOMRIGHT", endRegion)

  local width, height = sizer:GetWidth(), sizer:GetHeight()

  return width, height
end

-- Returns the default padding with an optional multiplier.
-- @param multiplier - a number to multiply padding by [optional]
-- @return - the absolute value of default padding times the multipler or 1.
function Tools:Padding(multiplier)
  return abs(Consts.PADDING * (multiplier or 1))
end

--[[
//*******************************************************************
//  					    			      Item Functions
//*******************************************************************
--]]

-- Gets the item id from a specified item link.
-- @return - the item id, or nil
function Tools:GetItemIDFromLink(itemLink)
  return (itemLink and itemLink:match("item:(%d+)")) or nil
end

-- Searches the player's bags for the location of an item with a specified link.
-- @return bag and slot index pair, or nil if the item was not found
function Tools:FindItemInBags(itemLink)
  local itemID = self:GetItemIDFromLink(itemLink)

  if itemID then -- search bags for item
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
      for slot = 1, GetContainerNumSlots(bag) do
        local link = GetContainerItemLink(bag, slot)

        if link and link:find(itemID) then
          return bag, slot end
      end
    end
  end

  return nil
end

-- Gets the information of an item within a specified bag and slot.
-- @return a table of item information, or nil if the info could not be retrieved
function Tools:GetItemFromBag(bag, slot)
  -- Get item info
  local _, quantity, locked, _, _, _, itemLink, _, noValue, itemID = GetContainerItemInfo(bag, slot)
  if not (quantity and not locked and itemLink and not noValue and itemID) then return nil end

  -- Get additional item info
  local _, _, quality, _, reqLevel, class, subClass, _, equipSlot, _, price = GetItemInfo(itemLink)
  local itemLevel = GetDetailedItemLevelInfo(itemLink)
  if not (quality and reqLevel and class and subClass and equipSlot and price and itemLevel) then return nil end

  return {
    Bag = bag,
    Slot = slot,
    Quantity = quantity,
    Locked = locked,
    ItemLink = itemLink,
    NoValue = noValue,
    ItemID = itemID,
    Quality = quality,
    ReqLevel = reqLevel,
    Class = class,
    SubClass = subClass,
    EquipSlot = equipSlot,
    Price = price,
    ItemLevel = itemLevel
  }
end

-- Checks whether or not an item can be sold based on price and quality.
-- @param price - the price of an item
-- @param quality - the quality of an item
-- @return - boolean
function Tools:ItemCanBeSold(price, quality)
  return (price > 0 and (quality >= LE_ITEM_QUALITY_POOR and quality <= LE_ITEM_QUALITY_EPIC))
end

-- Creates and returns an item by item id.
-- @param itemID - the item id of the item to create
-- @return - a table with item data
function Tools:GetItemByID(itemID)
  local item = nil
  local name, link, quality, _, _, _, _, _, _, texture, vendorPrice = GetItemInfo(itemID)

  if name and link and quality and texture and vendorPrice then
    item = {}
    item.ItemID = itemID
    item.Name = name
    item.Link = link
    item.Quality = quality
    item.Texture = texture
    item.Price = vendorPrice
  end

  return item
end