-- Core: initializes Dejunk.

local AddonName, Addon = ...

-- Libs
local L = Addon.Libs.L
local DBL = Addon.Libs.DBL
local DCL = Addon.Libs.DCL

-- Modules
local Core = Addon.Core

local Colors = Addon.Colors
local DB = Addon.DB
local Confirmer = Addon.Confirmer
local Dejunker = Addon.Dejunker
local Destroyer = Addon.Destroyer
local Repairer = Addon.Repairer
local ListManager = Addon.ListManager
local Tools = Addon.Tools
local ParentFrame = Addon.Frames.ParentFrame
local DejunkChildFrame = Addon.Frames.DejunkChildFrame

-- ============================================================================
-- DethsAddonLib Functions
-- ============================================================================

-- Initializes modules.
function Core:OnInitialize()
  DB:Initialize()
  Colors:Initialize()
  ListManager:Initialize()
  Addon.Consts:Initialize()
  Addon.MerchantButton:Initialize()
  Addon.MinimapIcon:Initialize()

  -- Setup slash command
  LibStub:GetLibrary("DethsCmdLib-1.0"):Create(AddonName, self.ToggleGUI)
end

do -- OnUpdate()
  local GetNetStats = GetNetStats
  local DELAY = 10 -- seconds
  local interval = DELAY

  function Core:OnUpdate(elapsed)
    interval = interval + elapsed
    if (interval >= DELAY) then -- Update latency
      interval = 0
      local home, world = select(3, GetNetStats())
      self.Latency = max(home, world) * 0.001
      -- self:Debug("Core", "Latency: "..self.Latency)
    end

    if Dejunker.OnUpdate then Dejunker:OnUpdate(elapsed) end
    if Destroyer.OnUpdate then Destroyer:OnUpdate(elapsed) end
    if Repairer.OnUpdate then Repairer:OnUpdate(elapsed) end
    Confirmer:OnUpdate(elapsed)
  end
end

function Core:OnEvent(event, ...)
  -- self:Debug("Core", "OnEvent: "..event)
  Dejunker:OnEvent(event, ...)
  Repairer:OnEvent(event, ...)
end
Core:RegisterEvent("UI_ERROR_MESSAGE")

-- ============================================================================
-- General Functions
-- ============================================================================

-- Prints a formatted message ("[Dejunk] msg").
-- @param msg - the message to print
function Core:Print(msg)
  if DB.Profile.SilentMode then return end
  local title = DCL:ColorString("[Dejunk]", Colors.LabelText)
  print(format("%s %s", title, msg))
end

-- Attempts to print a message if verbose mode is enabled.
-- @param msg - the message to print
function Core:PrintVerbose(msg)
  if DB.Profile.VerboseMode then Core:Print(msg) end
end

-- Prints a debug message ("[Dejunk Debug] title: msg").
-- @param msg - the message to print
function Core:Debug(title, msg)
  -- local debug = DCL:ColorString("[Dejunk Debug]", Colors.Red)
  -- title = DCL:ColorString(title, Colors.Green)
  -- print(format("%s %s: %s", debug, title, msg))
end

-- Returns true if the dejunking process can be safely started,
-- and false plus a reason message otherwise.
-- @return bool, string or nil
function Core:CanDejunk()
  if Dejunker:IsDejunking() then
    return false, L.DEJUNKING_IN_PROGRESS
  end

  if Destroyer:IsDestroying() then
    return false, L.CANNOT_DEJUNK_WHILE_DESTROYING
  end

  if ListManager:IsParsing("Inclusions") or
     ListManager:IsParsing("Exclusions") then
    return false, format(L.CANNOT_DEJUNK_WHILE_LISTS_UPDATING,
      Tools:GetColoredListName("Inclusions"),
      Tools:GetColoredListName("Exclusions"))
  end

  return true
end

-- Returns true if the destroying process can be safely started,
-- and false plus a reason message otherwise.
-- @return bool, string or nil
function Core:CanDestroy()
  if Destroyer:IsDestroying() then
    return false, L.DESTROYING_IN_PROGRESS
  end

  if Dejunker:IsDejunking() then
    return false, L.CANNOT_DESTROY_WHILE_DEJUNKING
  end

  if ListManager:IsParsing("Destroyables") then
    return false, format(L.CANNOT_DESTROY_WHILE_LIST_UPDATING,
      Tools:GetColoredListName("Destroyables"))
  end

  return true
end

-- Returns true if Dejunk is busy performing a critical action.
-- @return - boolean
function Core:IsBusy()
  return Dejunker:IsDejunking() or Destroyer:IsDestroying() or
    ListManager:IsParsing() or Confirmer:IsConfirming()
end

-- ============================================================================
-- UI Functions
-- ============================================================================

-- Toggles Dejunk's GUI.
function Core:ToggleGUI()
  ParentFrame:Initialize()
  ParentFrame:Toggle()
end

-- Enables Dejunk's GUI.
function Core:EnableGUI()
  ParentFrame:Enable()
end

-- Disables Dejunk's GUI.
function Core:DisableGUI()
  ParentFrame:Disable()
end

-- Switches between global and character specific settings.
function Core:ToggleCharacterSpecificSettings()
  if (DB:GetProfileKey() == "Global") then
    DB:SetProfile()
  else
    DB:SetProfile("Global")
  end

  ListManager:Update()
  
  if (ParentFrame:GetContent() ~= DejunkChildFrame) then
    ParentFrame:SetContent(DejunkChildFrame)
  end
  ParentFrame:Refresh()
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

    local leftText = DCL:ColorString(format("%s:", AddonName), Colors.LabelText)
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
