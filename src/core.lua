-- Core: initializes Dejunk.

local AddonName, Addon = ...
local Colors = Addon.Colors
local Confirmer = Addon.Confirmer
local Consts = Addon.Consts
local Core = Addon.Core
local DB = Addon.DB
local DBL = Addon.Libs.DBL
local DCL = Addon.Libs.DCL
local Dejunker = Addon.Dejunker
local Destroyer = Addon.Destroyer
local L = Addon.Libs.L
local ListManager = Addon.ListManager
local MerchantButton = Addon.MerchantButton
local MinimapIcon = Addon.MinimapIcon
local Repairer = Addon.Repairer
local Tools = Addon.Tools
local UI = Addon.UI

-- Upvalues
local format, max, print, select = string.format, math.max, print, select
local IsShiftKeyDown, IsAltKeyDown = _G.IsShiftKeyDown, _G.IsAltKeyDown
local GetNetStats = _G.GetNetStats

-- ============================================================================
-- DethsAddonLib Functions
-- ============================================================================

-- Initializes modules.
function Core:OnInitialize()
  DB:Initialize()
  ListManager:Initialize()
  Consts:Initialize()
  MerchantButton:Initialize()
  MinimapIcon:Initialize()

  -- Setup slash command
  _G.DethsLibLoader("DethsCmdLib", "1.0"):Create(
    AddonName,
    function() UI:Toggle() end,
    "dj"
  )
end

do -- OnUpdate()
  local DELAY = 10 -- seconds
  local interval = DELAY
  local home, world, latency

  function Core:OnUpdate(elapsed)
    UI:OnUpdate(elapsed)

    interval = interval + elapsed
    if (interval >= DELAY) then -- Update latency
      interval = 0
      home, world = select(3, GetNetStats())
      latency = max(home, world) * 0.001 -- convert to seconds
      self.MinDelay = max(latency, 0.1) -- 0.1 seconds min
    end

    ListManager:OnUpdate(elapsed)
    if Dejunker.OnUpdate then Dejunker:OnUpdate(elapsed) end
    if Destroyer.OnUpdate then Destroyer:OnUpdate(elapsed) end
    if Repairer.OnUpdate then Repairer:OnUpdate(elapsed) end
    Confirmer:OnUpdate(elapsed)
  end
end

function Core:OnEvent(event, ...)
  Dejunker:OnEvent(event, ...)
  Repairer:OnEvent(event, ...)
end
Core:RegisterEvent("MERCHANT_SHOW")
Core:RegisterEvent("MERCHANT_CLOSED")
Core:RegisterEvent("UI_ERROR_MESSAGE")

-- ============================================================================
-- General Functions
-- ============================================================================

-- Prints a formatted message ("[Dejunk] msg").
-- @param ... - the messages to print
function Core:Print(...)
  if DB.Profile.SilentMode then return end
  print(DCL:ColorString(("[%s]"):format(AddonName), Colors.Primary), ...)
end

-- Attempts to print a message if verbose mode is enabled.
-- @param ... - the messages to print
function Core:PrintVerbose(...)
  if DB.Profile.VerboseMode then self:Print(...) end
end

--[[
-- Prints a debug message ("[Dejunk Debug] title: ...").
-- @param title - the title of the debug message
-- @param ... - the messages to print
function Core:Debug(title, ...)
  print(
    DCL:ColorString(("[%s Debug]"):format(AddonName), Colors.Red),
    (select("#", ...) > 0) and
    DCL:ColorString(title, Colors.Green)..":" or
    title,
    ...
  )
end
--]] Core.Debug = nop

-- Returns true if the dejunking process can be safely started,
-- and false plus a reason message otherwise.
-- @return bool, string or nil
function Core:CanDejunk()
  if Dejunker:IsBusy() then
    return false, L.DEJUNKING_IN_PROGRESS
  end

  if Destroyer:IsBusy() then
    return false, L.CANNOT_DEJUNK_WHILE_DESTROYING
  end

  if ListManager:IsParsing("Inclusions") or ListManager:IsParsing("Exclusions") then
    return
      false,
      L.CANNOT_DEJUNK_WHILE_LISTS_UPDATING:format(
        Tools:GetColoredListName("Inclusions"),
        Tools:GetColoredListName("Exclusions")
      )
  end

  return true
end

-- Returns true if the destroying process can be safely started,
-- and false plus a reason message otherwise.
-- @return bool, string or nil
function Core:CanDestroy()
  if Destroyer:IsBusy() then
    return false, L.DESTROYING_IN_PROGRESS
  end

  if Dejunker:IsBusy() then
    return false, L.CANNOT_DESTROY_WHILE_DEJUNKING
  end

  if ListManager:IsParsing("Destroyables") then
    return
      false,
      L.CANNOT_DESTROY_WHILE_LIST_UPDATING:format(
        Tools:GetColoredListName("Destroyables")
      )
  end

  return true
end

-- Returns true if Dejunk is busy performing a critical action.
-- @return - boolean
function Core:IsBusy()
  return
    Dejunker:IsDejunking() or
    Destroyer:IsDestroying() or
    ListManager:IsParsing() or
    Confirmer:IsConfirming()
end

-- ============================================================================
-- Tooltip Hook
-- ============================================================================

do
  local item = {}

  local function setBagItem(self, bag, slot)
    if not DB.Global.ItemTooltip or DBL:IsEmpty(bag, slot) then return end

    -- Only update the item if it has changed
    if not ((bag == item.Bag) and (slot == item.Slot) and DBL:StillInBags(item)) then
      -- Return if updating the item fails or if the updated item is not in the bag slot.
      if not DBL:GetItem(bag, slot, item) then return end
    end
    if Tools:ItemCanBeRefunded(item) then return end

    local leftText = DCL:ColorString(format("%s:", AddonName), Colors.Primary)
    local rightText

    if not IsShiftKeyDown() then -- Dejunk tooltip
      -- Return if item cannot be sold
      if item.NoValue or not Tools:ItemCanBeSold(item) then return end
      local isJunkItem, reasonText = Dejunker:IsJunkItem(item)

      rightText = isJunkItem and
        DCL:ColorString((IsAltKeyDown() and reasonText or L.ITEM_WILL_BE_SOLD), Colors.Red) or
        DCL:ColorString((IsAltKeyDown() and reasonText or L.ITEM_WILL_NOT_BE_SOLD), Colors.Green)
    else -- Destroy tooltip
      -- Return if item cannot be destroyed
      if not Tools:ItemCanBeDestroyed(item) then return end
      local isJunkItem, reasonText = Destroyer:IsDestroyableItem(item)

      rightText = isJunkItem and
        DCL:ColorString((IsAltKeyDown() and reasonText or L.ITEM_WILL_BE_DESTROYED), Colors.Red) or
        DCL:ColorString((IsAltKeyDown() and reasonText or L.ITEM_WILL_NOT_BE_DESTROYED), Colors.Green)
    end

    self:AddLine(" ") -- blank line
    self:AddDoubleLine(leftText, rightText)
    self:Show()
  end

  hooksecurefunc(GameTooltip, "SetBagItem", setBagItem)
end