local _, Addon = ...
local DB = Addon.DB
local L = Addon.Libs.L
local Tools = Addon.Tools
local GetCoinTextureString = _G.GetCoinTextureString

local function isBelowPrice(item, price)
  if (item.Price * item.Quantity) >= price then
    return "NOT_JUNK", L.REASON_ITEM_PRICE_IS_NOT_BELOW_TEXT:format(
      GetCoinTextureString(price)
    )
  end

  return "PASS"
end

-- Dejunker
Addon.Filters:Add(Addon.Dejunker, {
  Run = function(_, item)
    if DB.Profile.SellBelowPrice.Enabled and Tools:ItemCanBeSold(item) then
      return isBelowPrice(item, DB.Profile.SellBelowPrice.Value)
    end

    return "PASS"
  end
})

-- Destroyer
Addon.Filters:Add(Addon.Destroyer, {
  Run = function(_, item)
    if DB.Profile.DestroyBelowPrice.Enabled and Tools:ItemCanBeSold(item) then
      return isBelowPrice(item, DB.Profile.DestroyBelowPrice.Value)
    end

    return "PASS"
  end
})
