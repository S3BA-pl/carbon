require("carbon-recipe-final-stacking")
require("carbon-recipe-final-k2")
require("carbon-recipe-final-se")
require("carbon-recipe-final-rrr")
require("carbon-recipe-modules") -- Should be last import

local util = require("data-util");


-- Green circuits in final fixes due to K2 shenanigans 
util.replace_some_ingredient("electronic-circuit", "copper-cable", 1, "graphite", 1)
-- AAI alternate green circuit
util.replace_some_ingredient("electronic-circuit-stone", "copper-cable", 1, "graphite", 1)


-- Only electric smelters can make Diamonds
function diamondsInElectricSmelter(entity)
  if entity.energy_source.type == "electric" then
    local isSmelter = false
    for j, category in pairs(entity.crafting_categories) do
      if category == "smelting" then
        isSmelter = true
      end
    end
    if isSmelter then
     table.insert(entity.crafting_categories,"diamond-synthesis")
    end
  end
end
for i, entity in pairs(data.raw.furnace) do
  diamondsInElectricSmelter(entity)
end
for i, entity in pairs(data.raw["assembling-machine"]) do
  diamondsInElectricSmelter(entity)
end 

-- furnace recipe rework, remove crucible ingredients
for i, furnace in pairs(util.me.furnaces) do
  for j, ingredient in pairs(util.me.crucible_ingredients)  do
    util.remove_ingredient(furnace, ingredient)
  end
end


-- Must be last
util.create_list()
