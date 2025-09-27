-- Format for overwriting define values:
--
-- NDefines.NDiplomacy.DEMESNE_BASE_MAX_SIZE = 2.0
NDefines.NEconomy.DECADENCE_MODIFIER = 0.1								-- vanilla:	0.2		-- Maximum effect of decadence positive for low dec negative for high
NDefines.NEconomy.DECADENCE_PER_WEEK_OF_COMBAT = -0.01					-- vanilla:	-0.04	-- Decadence lost per 7 days of combat for each participant in the combat
NDefines.NEconomy.DECADENCE_PER_WEEK_OF_SIEGE = -0.0016					-- vanilla:	-0.008	-- Decadence lost per 7 days of siege for each participant in the siege
NDefines.NEconomy.MIN_TRADE_POSTS = 3									-- vanilla:	4		-- Minimum number of max trade posts per patrician
NDefines.NEconomy.PATRICIAN_CITY_TAX_MULT = 0.25						-- vanilla:	0.5		-- Patricians don't pay normal City Tax to their liege... (CFixedPoint64)
NDefines.NEconomy.OVER_MAX_DEMESNE_TAX_PENALTY = 0.33					-- vanilla:	0.20	-- Percent penalty per county over the limit
NDefines.NEconomy.TAX_TO_LOOT_MULTIPLIER = 0.5							-- vanilla:	1.0		-- Lootable gold per tax
NDefines.NEconomy.FORT_LOOT_DEFENCE_MULTIPLIER = 1.0					-- vanilla:	4.0		-- Loot protected gold per fortlevel
NDefines.NEconomy.LOOTABLE_GOLD_REGROWTH = 0.01							-- vanilla:	0.015	-- Percent of max lootable gold that regrows every month
NDefines.NEconomy.LOOT_PRESTIGE_MULT = 0.5								-- vanilla:	1.0		-- Whenever you gain loot you also get prestige related to the loot
NDefines.NEconomy.LOOT_EVERY_X_DAYS = 8									-- vanilla:	4		-- Loot every this many days
NDefines.NEconomy.BUILDING_COST_MULT = 0.5								-- vanilla:	0.5		-- Increases build cost of all buildings
NDefines.NEconomy.FORT_CONSUMED_IN_SETTLEMENT_CONTRUCTION = 0			-- vanilla:	1		-- If set to 1 then fort holdings are consumed by the construction of another holding in the province while giving a discount to the construction cost in return.