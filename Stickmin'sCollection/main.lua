SMODS.Atlas {
	key = "atlaskib",
	path = "spritesheet.png",
	px = 71,
	py = 95
}
SMODS.Atlas{
	key = 'modicon',
	path = 'modicon.png',
	px = 32,
	py = 32,
}
SMODS.Atlas {
	key = "blimbus",
	path = "blind.png",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 7
}
to_big = to_big or function(x) return x end
SMODS.Atlas {
	key = "KRONOS",
	path = "KRONOS.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "ores",
	path = "ores.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "dextures",
	path = "dextures.png",
	px = 71,
	py = 95
}

SMODS.Rarity {
	key = 'soleiescent',
	loc_txt = {
		name = 'Soleiescent'
	},
	badge_colour = G.C.GOLD,
	default_weight = 0
}
SMODS.Rarity {
	key = 'eplode',
	loc_txt = {
		name = 'Risky'
	},
	badge_colour = G.C.TEXT_INACTIVE,
	default_weight = 0
}
SMODS.ConsumableType{
    key = 'Helios', --consumable type key

    collection_rows = {4,5}, --amount of cards in one page
    primary_colour = G.C.GOLD, --first color
    secondary_colour = G.C.FILTER, --second color
    loc_txt = {
        collection = 'Helios Cards', --name displayed in collection
        name = 'Helios', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {"Discover it first, you absolute buffoon."} --undiscovered text
        }
    },
	default = 'c_stickmin_kronos',
	shop_rate = 0
}
SMODS.Blind {
    key = "skib",
	loc_txt = {
		name = 'The Totally Balanced Boss Blind',
		text = {'All face cards + ', 'jokers are debuffed,', 'including Luchador and Chicot' }
	},
	atlas = 'blimbus',
	boss = { showdown = true },
    dollars = 10,
    mult = 1,
    pos = { x = 0, y = 0 },
    boss_colour = HEX("ff0000"),
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                return {
                    debuff = true
                }
            end
			if context.debuff_card and context.debuff_card:is_face(true) then
				return {
					debuff = true
				}
			end
            if context.press_play and G.jokers.cards[1] then
                blind.triggered = true
                blind.prepped = true
            end
        end
        if context.hand_drawn then
            blind.prepped = nil
        end
    end
}
SMODS.Blind {
    key = "skibid",
	loc_txt = {
		name = 'The, like, Really Balanced Boss Blind',
		text = {'Same as TBBB, but', 'start with no discards,', '1 hand, and', 'a hand size of 5 cards'}
	},
	atlas = 'blimbus',
	boss = { showdown = true, min = 16 },
    dollars = 10,
    mult = 0.5,
    pos = { x = 0, y = 0 },
    boss_colour = HEX("990000"),
	calculate = function(self, blind, context)
        if not blind.disabled then
			if context.setting_blind then
				blind.discards_sub = G.GAME.current_round.discards_left
                ease_discard(-blind.discards_sub)
				G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
                ease_hands_played(-G.GAME.blind.hands_sub)
				G.hand:change_size(-G.hand.config.card_limit + 5)
			end
            if context.debuff_card and context.debuff_card.area == G.jokers then
                return {
                    debuff = true
                }
            end
			if context.debuff_card and context.debuff_card:is_face(true) then
				return {
					debuff = true
				}
			end
            if context.press_play and G.jokers.cards[1] then
                blind.triggered = true
                blind.prepped = true
            end
        end
        if context.hand_drawn then
            blind.prepped = nil
        end
    end
}
SMODS.Blind {
    key = "skibidot",
	loc_txt = {
		name = 'The Complete and Total Annihilation of All That Makes Cryptid Unbalanced',
		text = {'Same as TLRBBB, but', 'REALLY BIG BOSS BLIND,', '-1 level for played hands,', 'and a hand size of 1 card'}
	},
	atlas = 'blimbus',
	boss = { showdown = true, min = 24 },
    dollars = -10,
    mult = 100,
    pos = { x = 0, y = 0 },
    boss_colour = HEX("000000"),
	calculate = function(self, blind, context)
		if context.setting_blind then
			blind.discards_sub = G.GAME.current_round.discards_left
            ease_discard(-blind.discards_sub)
			G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
            ease_hands_played(-G.GAME.blind.hands_sub)
			G.hand:change_size(-G.hand.config.card_limit + 1)
		end
        if context.debuff_card and context.debuff_card.area == G.jokers then
            return {
                debuff = true
            }
        end
		if context.debuff_card and context.debuff_card:is_face(true) then
			return {
				debuff = true
			}
		end
        if context.press_play and G.jokers.cards[1] then
            blind.triggered = true
            blind.prepped = true
        end
        if context.hand_drawn then
            blind.prepped = nil
        end
		if context.debuff_hand then
            blind.triggered = false
            if G.GAME.hands[context.scoring_name].level > 1 then
                blind.triggered = true
                if not context.check then
                    return {
                        level_up = -1
                    }
                end
            end
        end
    end
}
SMODS.Blind {
	key = 'angy',
	loc_txt = {
		name = 'Devious Bob',
		text = {
			'Like, really big blind'
		}
	},
	atlas = 'blimbus',
	pos = {x = 0, y = 1},
	dollars = 20,
	mult = 10000000,
	boss = {min = 14},
	boss_colour = HEX("ffffff")
}
SMODS.UndiscoveredSprite{
    key = 'Helios', --must be the same key as the consumabletype
    atlas = 'KRONOS',
    pos = {x = 1, y = 0},
    overlay_pos = {x = 2, y = 0}
}
SMODS.Atlas{
	key = 'newtex',
	px = 71,
	py = 95,
	path = 'revtex.png'
}
SMODS.Consumable{
	key = 'Kronos', --key
	set = 'Helios', --the set of the card: corresponds to a consumable type
	atlas = 'newtex', --atlas
	pos = {x = 3, y = 0}, --position in atlas
	soul_pos = {x = 2, y = 0},
	loc_txt = {
		name = 'Kronos', --name of card
		text = { --text of card
			'Create a {C:gold}Soleiescent {} Joker',
			'{C:inactive}(Must have room){}'
		}
	},
	hidden = true,
	soul_rate = 0.01,
	can_use = function(self,card)
		return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
	end,
	use = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
                local card_to_add = pseudorandom_element(G.P_JOKER_RARITY_POOLS.stickmin_soleiescent, "seed")
                if card_to_add then
                	local key = card_to_add.key
                	SMODS.add_card { key = key }
                    end
				return true
			end
		}))
	end
}

SMODS.Consumable{
	key = 'trade', --key
	set = 'Helios', --the set of the card: corresponds to a consumable type
	atlas = 'KRONOS', --atlas
	pos = {x = 4, y = 1}, --position in atlas
	loc_txt = {
		name = 'Trade', --name of card
		text = { --text of card
			'Create a {C:RARITY.Legendary}Legendary {} Joker,',
			'{C:attention}-$135{}',
			'{C:inactive}(Must have room){}'
		}
	},
	can_use = function(self,card)
		if G.STATE ~= G.STATES.HAND_PLAYED and to_big(G.GAME.dollars) >= to_big(135) and G.STATE ~=G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or
		any_state then
			return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
		end
	end,
	use = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
                SMODS.add_card({set = 'Joker', legendary = true})
				return true
			end
		}))
		delay(0.5)
		ease_dollars(-135)
		delay(0.3)
	end
}
SMODS.Joker {
	key = "skibidi_toilet",
	name = "Extra 0",
	rarity = 'stickmin_soleiescent',
	blueprint_compat = true,
	atlas = "atlaskib",
	pos = {x = 1, y = 0},
	cost = 0,
	visible = true,
	loc_txt = {
		name = "Extra 0",
		text = {
			"{X:mult,C:white}X10 {} Mult"
		}
	},
	init = function(self, card)
		card.ability = card.ability or {}
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.Xmult = 2 -- starting multiplier
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = 10,
				message = "X10 Mult"
			}
		end
	end
}

SMODS.Back{
    name = "Welded Deck",
    key = "swagger",
	atlas = 'dextures',
    pos = {x = 0, y = 0},
    config = {only_one_rank = '4'},
    loc_txt = {
        name ="Welded Deck",
        text={
            "Start with a Deck",
            "full of {C:attention}Steel Red Seal Kings of Spades{}",
        },
    },
	discovered = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
            	SMODS.destroy_cards(G.playing_cards)
				for i=#G.playing_cards, 1, -1 do
				    G.playing_cards[i]:remove()
				end
				for i = 1, 52, 1 do
					local card = SMODS.add_card{set = "Base", enhancement = "m_steel", rank = "King", suit = "Spades", area = G.deck}
					card:set_seal("Red", true, true)
				end
                return true
            end
        }))
    end
}
SMODS.Back{
    name = "Useless Deck",
    key = "dum",
	atlas = 'dextures',
	discovered = true,
    pos = {x = 1, y = 0},
    config = {only_one_rank = '4'},
    loc_txt = {
        name ="Useless Deck",
        text={
            "Start with a Deck",
            "full of {C:attention}2's{}",
			"and a Wee Joker"
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
				SMODS.add_card{key = 'j_wee', set = 'Joker', area = G.jokers}
            	SMODS.destroy_cards(G.playing_cards)
				for i=#G.playing_cards, 1, -1 do
				    G.playing_cards[i]:remove()
				end
				
				for i = 1, 52, 1 do
					local card = SMODS.add_card{set = "Base", rank = "2", area = G.deck}
				end
                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Shaper Deck",
    key = "woahski",
	discovered = true,
	atlas = 'dextures',
    pos = {x = 2, y = 0},
    config = {only_one_rank = '4'},
    loc_txt = {
        name ="Shaper Deck",
        text={
            "Start with Perkeo, Death,",
			"and Caught in 4K"
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
				SMODS.add_card{key = 'j_perkeo', set = 'Joker', area = G.jokers}
				SMODS.add_card{key = 'j_stickmin_sus', set = 'Joker', area = G.jokers}
				SMODS.add_card{key = 'c_death', set = 'Tarot', area = G.consumeables}
                return true
            end
        }))
    end
}
SMODS.Back{
    name = "Copier Deck",
    key = "unoriginal",
	discovered = true,
	atlas = 'dextures',
    pos = {x = 3, y = 0},
    config = {only_one_rank = '4'},
    loc_txt = {
        name ="Copier Deck",
        text={
            "Start with negative Blueprint,",
			"negative Brainstorm,",
			"and negative Split Paths"
        },
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
				SMODS.add_card{key = 'j_blueprint', set = 'Joker', area = G.jokers, edition = 'e_negative'}
				SMODS.add_card{key = 'j_brainstorm', set = 'Joker', area = G.jokers, edition = 'e_negative'}
				SMODS.add_card{key = 'j_stickmin_splitpaths', set = 'Joker', area = G.jokers, edition = 'e_negative'}
                return true
            end
        }))
    end
}
SMODS.Back{
    name = "Lucky Deck",
	discovered = true,
    key = "luck",
	atlas = 'atlaskib',
    pos = {x = 2, y = 2},
    loc_txt = {
        name = "Lucky Deck",
        text ={
            "Start with a Deck",
            "full of {C:attention}Lucky{} cards,",
			"{C:attention}Oops! All 6's!{}, and {C:attention}Lucky Cat{}"
        },
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_ability(G.P_CENTERS.m_lucky)
                end
				SMODS.add_card{key = 'j_lucky_cat', set = 'Joker', area = G.jokers}
				SMODS.add_card{key = 'j_oops', set = 'Joker', area = G.jokers}
                return true
            end
        }))
    end
}
SMODS.Atlas{
	key = 'broke',
	path = 'Broken Deck.png',
	px = 71,
	py = 95
}
SMODS.Back{
    name = "BROKEN DECK",
    key = "woahd",
	atlas = 'broke',
    pos = {x = 0, y = 0},
    config = {only_one_rank = '4'},
    loc_txt = {
        name ="OmegaNum Deck",
        text={
            "Start with a Deck",
            "full of {X:edition}Polychrome{} {C:attention}Steel Red Seal Kings of Spades{},",
			"{C:attention}Effarcire{}, {C:attention}9000 Joker slots{},",
			"{C:attention}Baron{}, {C:attention}Mime{},",
			"{C:mult}100 discards{}, {C:chips}100 hands{}, and",
			"{C:attention}52 Card selection limit{},",
			"{C:mult}X10{} Blind requirement and",
			"Blinds scale {C:attention}5X{} faster",
			"{C:inactive}(Must have Cryptid){}"
        },
    },
	discovered = true,
    apply = function(self, back)
		G.GAME.starting_params.hands = 100
		G.GAME.starting_params.discards = 100
		G.GAME.starting_params.joker_slots = 9000
		G.GAME.starting_params.ante_scaling = 1000
		G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) * 100
        G.E_MANAGER:add_event(Event({
            func = function()
            	SMODS.destroy_cards(G.playing_cards)
				for i=#G.playing_cards, 1, -1 do
				    G.playing_cards[i]:remove()
				end
				for i = 1, 52, 1 do
					local card = SMODS.add_card{set = "Base", enhancement = "m_steel", rank = "King", suit = "Spades", area = G.deck}
					card:set_seal("Red", true, true)
					card:set_edition("e_polychrome", true, true)
				end
				SMODS.add_card{key = 'j_cry_effarcire', set = 'Jokers', area = G.jokers}
				SMODS.add_card{key = 'j_baron', set = 'Jokers', area = G.jokers}
				SMODS.add_card{key = 'j_mime', set = 'Jokers', area = G.jokers}
				SMODS.change_play_limit(52)
				SMODS.change_discard_limit(52)
                return true
            end
        }))
    end,
}
SMODS.Atlas{
	key = 'stake',
	px = 29,
	py = 29,
	path = 'stake.png'
}
SMODS.Atlas{
	key = 'sticker',
	px = 71,
	py = 95,
	path = 'sticker.png'
}
SMODS.Stake {
    name = "OmegaNum Stake",
    key = "omegstake",
	loc_txt = {
		name = 'OmegaNum Stake',
		text = {
			'Blinds scale {C:attention}1,000X{} faster',
			"{C:inactive}(I hope you're playing on OmegaNum Deck...)"
		},
		sticker = {
			name = 'OmegaNum Sticker',
			text = {
				"Used this joker to win",
				"on OmegaNum Stake"
			}
		}
	},
	atlas = 'stake',
    pos = { x = 0, y = 0 },
	applied_stakes = {"white"},
	sticker_atlas = 'sticker',
    sticker_pos = { x = 0, y = 0 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 999
    end,
    colour = G.C.EDITION,
}
SMODS.Consumable{
	key = 'reallygood',
	set = 'Helios',
	loc_txt = {
		name = "Welding",
		text = { "Adds 2 Steel Red Seal Kings of Spades to the deck" }
	},
	atlas = 'KRONOS',
	pos = {x = 0, y = 1},
	can_use = function(self,card)	
		return true
	end,
	use = function(self)
		SMODS.add_card{set = "Base", enhancement = "m_steel", seal = 'Red', rank = "King", suit = "Spades"}
		SMODS.add_card{set = "Base", enhancement = "m_steel", seal = 'Red', rank = "King", suit = "Spades"}
	end
}

SMODS.Consumable{
	key = 'reallybad',
	set = 'Helios',
	loc_txt = {
		name = "Doom",
		text = { "{X:dark_edition,C:white}DON'T.{}" }
	},
	atlas = 'KRONOS',
	pos = {x = 2, y = 1},
	can_use = function(self,card)	
		return true
	end,
	use = function(self)
		SMODS.add_card{ key = 'j_stickmin_the_doombringer',  stickers = {"eternal"}, set = 'Joker', edition = "e_negative"}
	end
}

SMODS.Consumable{
	key = 'kaclick',
	set = 'Helios',
	loc_txt = {
		name = "Price",
		text = { "Creates a negative eternal rental Rare joker" }
	},
	atlas = 'KRONOS',
	pos = {x = 1, y = 1},
	can_use = function(self,card)	
		return true
	end,
	use = function(self)
		SMODS.add_card{stickers = {"eternal", "rental"}, set = 'Joker', edition = "e_negative", rarity = 3}
	end
}

SMODS.Consumable{
	key = 'pick',
	set = 'Helios',
	loc_txt = {
		name = "Pickaxe",
		text = { "Creates 2 random Ore consumables", "{C:inactive}(Must have room){}" }
	},
	atlas = 'KRONOS',
	pos = {x = 2, y = 2},
	can_use = function(self,card)	
		return true
	end,
	use = function(self)
		if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) then
			SMODS.add_card{key_append = "ncheck", set = 'ores'}
		end
		if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) then
			SMODS.add_card{key_append = "ncheck", set = 'ores'}
		end
	end
}

SMODS.Consumable{
	key = 'gambling',
	set = 'Helios',
	loc_txt = {
		name = "Gamble",
		text = { "{C:attention}1 in 2{} chance to give x5 money,", "otherwise /2 money" }
	},
	atlas = 'KRONOS',
	pos = {x = 3, y = 1},
	can_use = function(self,card)	
		return true
	end,
	use = function(self)
		if pseudorandom('gambling time') < 1 / 2 then --make the 1 and 2 variables so you can change them later ideally
   			ease_dollars(G.GAME.dollars * 4, true)
		else
    		ease_dollars(-G.GAME.dollars / 2, true)
		end
	end
}

SMODS.Joker {
	key = "the_doombringer",
	name = "The Doombringer",
	tags = { brainrot = true },
	rarity = 'stickmin_soleiescent',
	blueprint_compat = true,
	atlas = "atlaskib",
	pos = {x = 0, y = 0},
	cost = -10,
	visible = true,
	loc_txt = {
		name = "The Doombringer",
		text = {
			"{C:dark_edition}DON'T.{} {inactive}(especially on Plasma Deck){}"
		}
	},
	config = { extra = {
		Xmult = 1
	}
	},
	loc_vars = function(self,info_queue,center)
	end,
	init = function(self, card)
		card.ability = card.ability or {}
	end,

	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			G.E_MANAGER:add_event(Event({
				delay = 0.2,
				func = function()
					SMODS.add_card{ key = 'j_stickmin_the_doombringer',  stickers = {"eternal"}, set = 'Joker', edition = "e_negative"}
					return true
				end
			}))
		end
		if context.joker_main then
			local blind_chips = G.GAME.blind and G.GAME.blind.chips or 0
			if G.GAME.selected_back and G.GAME.selected_back.name == "Plasma Deck" then
				error("NICE TRY. NEXT TIME DONT BUY THE FREAKY AHH SWEATY FACE.")
			else
				SMODS.add_card{ key = 'j_stickmin_the_doombringer',  stickers = {"eternal"}, set = 'Joker', edition = "e_negative"}
				return {
					card = card,
					Xmult_mod = card.ability.extra.Xmult,
					chips = -2 * blind_chips,
					message = "HAHAHA"
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'tung',
	loc_txt = {
		name = 'Statue',
		text = {
			"Multiplies {X:mult,C:white}XMult{} by 1.15",
			"if played hand",
			"contains a {C:attention}Card{}",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} XMult)"
		}
	},
	config = { extra = { mult = 0.1, mult_gain = 10 } },
	rarity = 1,
	atlas = 'atlaskib',
	pos = { x = 2, y = 0 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
		card.ability.extra = card.ability.extra or {}
		return { vars = { card.ability.extra.mult or 0, card.ability.extra.mult_gain or 0 } }
	end,
	init = function(self, card)
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.mult = 0.1
		card.ability.extra.mult_gain = 10
	end,
	calculate = function(self, card, context)
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.mult = card.ability.extra.mult or 1
	
		local mult_factor = 1.15
	
		if context.joker_main then
			card.ability.extra.mult = card.ability.extra.mult * mult_factor
	
			return {
				Xmult_mod = 1 + card.ability.extra.mult,
				message = string.format("x%.2f", card.ability.extra.mult)
			}
		end
		if context.before and context.poker_hands and next(context.poker_hands['High Card']) and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult * mult_factor
			return {
				message = "Upgraded!",
				colour = G.C.MULT,
				card = card
			}
		end
	end

}

SMODS.Joker{
	key = 'jonkledonkler',
	loc_txt = {
		name = "Stupid Joker",
		text = {
			"At the beginning of the round,",
			"make a random {C:attention}Consumable{}",
			"{C:inactive}(Must have room){}"
		},
	},
	rarity = 'stickmin_soleiescent',
	atlas = 'atlaskib',
	pos = { x = 2, y = 1 },
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.setting_blind then
			if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) then
				SMODS.add_card{set = "Consumeables", area = G.consumeables}
			end	
		end
	end
}

SMODS.Joker {
	key = 'tral',
	loc_txt = {
		name = 'Archangel',
		text = {
			"Multiplies {X:mult,C:white}XMult{} by 1.3",
			"if played hand",
			"contains a {C:attention}Card{}",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} XMult)"
		}
	},
	config = { extra = { mult = 2, mult_gain = 10 } },
	rarity = 3,
	atlas = 'atlaskib',
	pos = { x = 4, y = 0 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
		card.ability.extra = card.ability.extra or {}
		return { vars = { card.ability.extra.mult or 0, card.ability.extra.mult_gain or 0 } }
	end,
	init = function(self, card)
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.mult = 1.3
		card.ability.extra.mult_gain = 10
	end,
	calculate = function(self, card, context)
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.mult = card.ability.extra.mult or 1
	
		local mult_factor = 1.3
	
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.mult,
				message = string.format("x%.2f", card.ability.extra.mult)
			}
		end
	
		if context.before and context.poker_hands and next(context.poker_hands['High Card']) and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult * mult_factor
			return {
				message = "Upgraded!",
				colour = G.C.MULT,
				card = card
			}
		end
	end

}

SMODS.Joker{
	key = 'smegma',
	loc_txt = {
		name = 'Smegma',
		text = {
			"Gain {X:mult,C:white}+0.1{} XMult",
			"for every discarded card",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})"
		}
	},
	rarity = 'stickmin_soleiescent',
	cost = 8,
	blueprint_compat = false,
	atlas = 'atlaskib',
	pos = {x = 3, y = 0},

	-- Localized display values
	loc_vars = function(self, info_queue, card)
		card.ability = card.ability or {}
		card.ability.extra = card.ability.extra or {}
		return {
			vars = {
				string.format("%.1f", card.ability.extra.Xmult_mod or 0)
			}
		}
	end,

	-- Init (called once)
	init = function(self, card)
		card.ability = card.ability or {}
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.Xmult_mod = 0
	end,

	-- Effect logic
	calculate = function(self, card, context)
		card.ability = card.ability or {}
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod or 0

		-- On discard
		if context.discard then
		-- Count catalysts in hand
			if not context.blueprint then
				local bonus = 0.1
				card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + bonus
				return {
					message = "+0.1 Mult",
					colour = G.C.MULT,
					card = card
				}
			end
		end

		-- On scoring
		if context.joker_main then
			local mult = card.ability.extra.Xmult_mod or 0
			return {
				Xmult_mod = 1 + mult,
				message = string.format("X%.1f", mult)
			}
		end
	end
}
if SMODS.current_mod.config.unfair_stuff then
	SMODS.Joker {
		key = 'unfair',
		loc_txt = {
			name = 'Seraphim',
			text = {
				"{X:edition,C:default}^1.2{} XMult",
				"every hand",
				"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} XMult)"
			}
		},
		config = { extra = { mult = 2, mult_gain = 10 } },
		rarity = 4,
		tags = { brainrot = true },
		atlas = 'newtex',
		pos = { x = 1, y = 0 },
		soul_pos = {x = 0, y = 0},
		cost = 10,
		loc_vars = function(self, info_queue, card)
			card.ability.extra = card.ability.extra or {}
			return { vars = { card.ability.extra.mult or 0, card.ability.extra.mult_gain or 0 } }
		end,
		init = function(self, card)
			card.ability.extra = card.ability.extra or {}
			card.ability.extra.mult = 1.3
			card.ability.extra.mult_gain = 10
		end,
		calculate = function(self, card, context)
			card.ability.extra = card.ability.extra or {}
			card.ability.extra.mult = card.ability.extra.mult or 1
	

			local mult_factor = 1.2
	
			if context.joker_main then
				return {
					Xmult_mod = card.ability.extra.mult,
					message = string.format("x%.2f", card.ability.extra.mult)
				}
			end
	
			if context.before and context.poker_hands and next(context.poker_hands['High Card']) and not context.blueprint then
				card.ability.extra.mult = card.ability.extra.mult ^ mult_factor
				card.ability.extra.mult = math.floor((card.ability.extra.mult) * 100 + 0.5) / 100
				return {
					message = "Upgraded!",
					colour = G.C.MULT,
					card = card
				}
			end
		end
	}
end


SMODS.Joker {
	key = 'cont',
	loc_txt = {
		name = 'Content Farm',
		text = {
			"{C:attention}$#1#{} at the end of round,",
			"payout increases by 50% every round"
		}
	},
	config = { extra = { mult = 2, mult_gain = 10 } },
	rarity = 'stickmin_soleiescent',
	atlas = 'atlaskib',
	pos = { x = 1, y = 1 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
		card.ability.extra = card.ability.extra or {}
		return { vars = { card.ability.extra.money or 1, card.ability.extra.money_gain or 1 } }
	end,
	init = function(self, card)
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.money = 1.3
	end,

	calc_dollar_bonus = function(self, card)
		card.ability.extra = card.ability.extra or {}
		card.ability.extra.money = card.ability.extra.money or 1.0

		local payout = math.floor(card.ability.extra.money + 0.5)
	
		-- Scale up the money for the next round
		card.ability.extra.money = card.ability.extra.money * 1.5

		return math.floor(payout * 100 + 0.5) / 100 -- optional rounding
	end

}

SMODS.Consumable {
    key = 'handofgod',
    set = 'Helios',
	atlas = 'KRONOS',
    pos = { x = 4, y = 0 },
    config = { max_highlighted = 2 },
    loc_txt = {
		name = 'Hand of God',
		text = {
			"Adds {C:dark_edition}Negative {} to",
			"up to 2 selected cards"
		}
	},

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_edition("e_negative")
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}

SMODS.Booster {
    key = "Helios_booster",
    weight = 13,
    cost = 4,
    atlas = "KRONOS",
    loc_txt = {
        name = "Infernal Pack",
        text = { "Gives the choice of 1 out of 3 {X:gold,C:white}Helios {} cards" },
		group_name = "Infernal Pack"
    },
    pos = { x = 3, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_helios_booster",
    draw_hand = true,
	kind = 'Helios_booster',
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        local _card
        _card = {
            set = "Helios",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }

        return _card
    end
}

SMODS.Booster {
    key = "jumboHelios_booster",
    weight = 10,
    cost = 6,
	kind = 'Helios_booster',
    atlas = "KRONOS",
    loc_txt = {
        name = "Jumbo Infernal Pack",
        text = { "Gives the choice of 1 out of 4 {X:gold,C:white}Helios {} cards" },
		group_name = "Infernal Pack"
    },
    pos = { x = 0, y = 2 },
    config = { extra = 4, choose = 1 },
    group_key = "k_helios_booster",
    draw_hand = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        local _card
        _card = {
            set = "Helios",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }

        return _card
    end
}

SMODS.Booster {
    key = "megaHelios_booster",
    weight = 7,
    cost = 8,
	kind = 'Helios_booster',
    atlas = "KRONOS",
    loc_txt = {
        name = "Mega Infernal Pack",
        text = { "Gives the choice of 2 out of 6 {X:gold,C:white}Helios {} cards" },
		group_name = "Infernal Pack"
    },
    pos = { x = 1, y = 2 },
    config = { extra = 6, choose = 2 },
    group_key = "k_helios_booster",
    draw_hand = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    create_card = function(self, card, i)
        local _card
        _card = {
            set = "Helios",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        }

        return _card
    end
}

SMODS.Joker{
	key = 'sus',
	loc_txt = {
		name = 'Caught in 4K',
		text = {
			'If hand contains 4 or',
			'more Kings, make them {C:dark_edition}Negative{}'
		}
	},
	atlas = 'atlaskib',
	rarity = 'stickmin_soleiescent',
	pos = {x = 3, y = 1},
	calculate = function(self, card, context)
		if context.before then
			local kings = {}
			for i,v in ipairs(context.scoring_hand) do
				if v:get_id() == 13 then table.insert(kings,v) end
			end
			if #kings >=4 then
				for i,v in ipairs(kings) do
					v:set_edition("e_negative")
				end
			end
		end
	end
}

SMODS.Joker{
	key = 'steve',
	loc_txt = {
		name = "Steve",
		text = {
			"Upgrades via Ore cards",
			"{C:inactive}(Currently {}{C:mult}+#1# Mult{}{C:inactive} and{}{C:chips} +#2# Chips{}{C:inactive}){}"
		}
	},
	atlas = 'ores',
	pos = {x = 0, y = 1},
	config = { extra = { mult = 0, chips = 0 } },
	loc_vars = function(self, info_queue, card)
		card.ability.extra = card.ability.extra or {}
		return { vars = { card.ability.extra.mult or 0, card.ability.extra.chips or 0 } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = string.format("+Mult"),
				extra = {chip_mod = card.ability.extra.chips, message = string.format("+Chips")}
			}
		end
	end

}

SMODS.ConsumableType{
    key = 'ores', --consumable type key

    collection_rows = {4,5}, --amount of cards in one page
    primary_colour = G.C.UI.TEXT_DARK, --first color
    secondary_colour = G.C.UI.TEXT_INACTIVE, --second color
    loc_txt = {
        collection = 'Ore Cards', --name displayed in collection
        name = 'Ore', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {"Discover it first, you absolute buffoon."} --undiscovered text
        }
    },
	shop_rate = 0
}

SMODS.Consumable{
	key = 'coal',
	set = 'ores',
	loc_txt = {
		name = "Coal",
		text = { "Upgrades Steve by +1 Mult and +5 Chips" }
	},
	atlas = 'ores',
	pos = {x = 0, y = 0},
	can_use = function(self,card)	
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then
				return true	
			end
		end
	end,
	use = function(self, card)
		local target_joker = nil
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then target_joker = v break end
		end
		if target_joker then
			target_joker.ability.extra.mult=target_joker.ability.extra.mult + 1
			target_joker.ability.extra.chips=target_joker.ability.extra.chips + 5
		end
	end
}

SMODS.Consumable{
	key = 'iron',
	set = 'ores',
	loc_txt = {
		name = "Iron",
		text = { "Upgrades Steve by +2 Mult and +20 Chips" }
	},
	atlas = 'ores',
	pos = {x = 1, y = 0},
	can_use = function(self,card)	
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then
				return true	
			end
		end
	end,
	use = function(self, card)
		local target_joker = nil
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then target_joker = v break end
		end
		if target_joker then
			target_joker.ability.extra.mult=target_joker.ability.extra.mult + 2
			target_joker.ability.extra.chips=target_joker.ability.extra.chips + 20
		end
	end
}

SMODS.Consumable{
	key = 'diamond',
	set = 'ores',
	loc_txt = {
		name = "Diamond",
		text = { "Upgrades Steve by +5 Mult and +20 Chips" }
	},
	atlas = 'ores',
	pos = {x = 2, y = 0},
	can_use = function(self,card)	
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then
				return true	
			end
		end
	end,
	use = function(self, card)
		local target_joker = nil
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then target_joker = v break end
		end
		if target_joker then
			target_joker.ability.extra.mult=target_joker.ability.extra.mult + 5
			target_joker.ability.extra.chips=target_joker.ability.extra.chips + 20
		end
	end
}

SMODS.Consumable{
	key = 'netherite',
	set = 'ores',
	loc_txt = {
		name = "Netherite",
		text = { "Upgrades Steve by {X:mult,C:white}X1.5{} Mult and {X:chips,C:white}X1.5{} Chips" }
	},
	atlas = 'ores',
	pos = {x = 4, y = 0},
	in_pool = "ncheck",
	soul_pos = {
		x = 3,
		y = 0
	},
	can_use = function(self,card)	
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then
				return true	
			end
		end
	end,
	use = function(self, card)
		local target_joker = nil
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then target_joker = v break end
		end
		if target_joker then
			target_joker.ability.extra.mult=target_joker.ability.extra.mult * 1.5
			target_joker.ability.extra.chips=target_joker.ability.extra.chips * 1.5
		end
	end
}

SMODS.Consumable{
	key = 'curse',
	set = 'Helios',
	loc_txt = {
		name = "Curse",
		text = { "{C:attention}-1 Joker slot{},", "create 2 random Spectral cards,", "{C:attention}+$50, and +1 Consumable slot", "{C:inactive}(Must have room for Spectral cards)" }
	},
	atlas = 'KRONOS',
	pos = {x = 3, y = 2},
	can_use = function(self,card)	
		if to_big(#G.jokers.cards) < to_big(G.jokers.config.card_limit) then
			return true
		end
	end,
	use = function(self, card, area, copier)
		G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
		if to_big(#G.consumeables.cards) + 1 < to_big(G.consumeables.config.card_limit) then
			SMODS.add_card{set = 'Spectral'}
			SMODS.add_card{set = 'Spectral'}
		end
		ease_dollars(50)
	end
}

SMODS.Consumable{
	key = 'emerald',
	set = 'ores',
	loc_txt = {
		name = "Emerald",
		text = { "Upgrades Steve by {X:chips,C:white}X2{} chips" }
	},
	atlas = 'ores',
	pos = {x = 1, y = 1},
	can_use = function(self,card)	
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then
				return true	
			end
		end
	end,
	use = function(self, card)
		local target_joker = nil
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then target_joker = v break end
		end
		if target_joker then
			target_joker.ability.extra.chips=target_joker.ability.extra.chips * 2
		end
	end
}
SMODS.Consumable{
	key = 'redstone',
	set = 'ores',
	loc_txt = {
		name = "Redstone",
		text = { "Upgrades Steve by {X:red,C:white}X2{} mult" }
	},
	atlas = 'ores',
	pos = {x = 3, y = 1},
	can_use = function(self,card)	
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then
				return true	
			end
		end
	end,
	use = function(self, card)
		local target_joker = nil
		for i,v in ipairs(G.jokers.cards) do
			if G.jokers.cards[i].config.center.key == "j_stickmin_steve" then target_joker = v break end
		end
		if target_joker then
			target_joker.ability.extra.mult=target_joker.ability.extra.mult * 2
		end
	end
}

SMODS.Joker{ --Split Paths
    key = "splitpaths",
    config = {
        extra = {
        }
    },
    loc_txt = {
        name = 'Split Paths',
        text = {
            'Copies the effects of the jokers',
            'to the {C:attention}left{} and {C:attention}right{} of itself'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    cost = 20,
    rarity = 'stickmin_soleiescent',
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ores',
	pos = {x = 2, y = 1},

    calculate = function(self, card, context)
	    if not G.jokers then return nil end

	    local left_effect, right_effect = nil, nil

	    for i = 1, #G.jokers.cards do
	        if G.jokers.cards[i] == card then
	            local left_joker = G.jokers.cards[i - 1]
	            local right_joker = G.jokers.cards[i + 1]

	            if left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat then
	                left_effect = SMODS.blueprint_effect(card, left_joker, context)
        	    end

	            if right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat then
	                right_effect = SMODS.blueprint_effect(card, right_joker, context)
	            end
	            break
	        end
	    end

	    if left_effect or right_effect then
	        local merged_effect = SMODS.merge_effects(
	            { left_effect or {} },
        	    { right_effect or {} }
    	    )

	        return merged_effect
	    else
	        return nil
	    end
	end
}

SMODS.Joker {
    key = "bigg",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 3,
    cost = 8,
	loc_txt = {
		name = "Big Joker",
		text = {
			"Gains {C:mult}+10{} Mult",
			"for every scoring Ace",
			"{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} Mult){}"
		}
	},
    pos = { x = 0, y = 0 },
    display_size = { w = 71 * 1.3, h = 95 * 1.3 },
    config = { extra = { mult = 0, mult_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod

            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
				message = string.format("+%.2f", card.ability.extra.mult),
				colour = G.C.MULT
            }
        end
    end,
}

SMODS.Joker{
	key = 'fluffy',
	rarity = 3,
	cost = 16,
	atlas = 'atlaskib',
	pos = {x = 4, y = 1},
	loc_txt = {
		name = "Chicken",
		text = {
			"At the beginning of the",
			"round, make a {C:dark_edition}negative{} {C:attention}Egg{}"
		}
	},
	calculate = function(self, card, context)
		if context.setting_blind then
			SMODS.add_card{key = 'j_egg', edition = 'e_negative', area = G.jokers}
		end
	end
}
SMODS.Atlas{
	key = 'yoink',
	px = 71,
	py = 95,
	path = 'yoinker.png'
}
SMODS.Joker{
	key = 'yoink',
	loc_txt = {
		name = 'Yoinker',
		text = {
			"{C:attention}-1 hand size{},",
			"{C:chips}+2 hands{}"
		}
	},
	atlas = 'yoink',
	pos = {x = 0, y = 0},
	add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
        ease_hands_played(2)
        G.hand:change_size(-1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2
        ease_hands_played(-2)
        G.hand:change_size(1)
    end,
}

SMODS.Joker{
	key = 'kaboom',
	atlas = 'atlaskib',
	pos = {x = 1, y = 2},
	loc_vars = function(self, info_queue, card)
        return { vars = {localize((G.GAME.current_round.stickmin_kaboom_card or {}).rank or 'King', 'ranks') } }
    end,
	rarity = 3,
	loc_txt = {
		name = 'Active Landmine',
		text = {
			'{X:edition}^1.1{} Mult,',
			'Lose the game if you play a {C:attention}#1#{}',
			'{C:inactive}(Rank changes every round){}'
		}
	},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.other_card.debuff and context.other_card:get_id() == G.GAME.current_round.stickmin_kaboom_card.id then
			G.STATE = G.STATES.GAME_OVER
			G.STATE_COMPLETE = false
		end
		if context.joker_main then
			return {
				mult = mult * (mult * 0.1),
				xmult_message = {message = '^1.1 Mult', colour = G.C.DARK_EDITION}
			}
		end
	end
}

local function resetbombrank()
    G.GAME.current_round.stickmin_kaboom_card = { rank = 'Ace' }
    local validcards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            validcards[#validcards + 1] = playing_card
        end
    end
    local bomb_card = pseudorandom_element(validcards, 'stickmin_kaboom' .. G.GAME.round_resets.ante)
    if bomb_card then
        G.GAME.current_round.stickmin_kaboom_card.rank = bomb_card.base.value
        G.GAME.current_round.stickmin_kaboom_card.id = bomb_card.base.id
    end
end
SMODS.Challenge{
	key = 'explosive',
	loc_txt = {
		name = 'Explosive'
	},
	jokers = {
		{ id = 'j_stickmin_kaboom', eternal = true},
		{ id = 'j_stickmin_boomies' }
	}
}
SMODS.Joker{
	key = 'boomies',
	atlas = 'atlaskib',
	pos = {x = 0, y = 2},
	loc_txt = {
		name = 'Time Bomb',
		text = {
			"Detonates in {C:red}???{} rounds,",
			"{C:attention}+$10{} at end of round",
			"{C:inactive}I hope you're paying attention...{}"
		}
	},
	rarity = 2,
	config = {extra = {bomb_rounds = 999, total_rounds = 0}},
	loc_vars = function(self, info_queue, card)
        return { main_end = main_end, vars = {
			card.ability.extra.total_rounds,
			card.ability.extra.bomb_rounds
		} }
    end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.bomb_rounds = pseudorandom('bomb', 0, 10)
		card.ability.extra.total_rounds = 0
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if card.ability.extra.total_rounds > card.ability.extra.bomb_rounds then
				G.STATE = G.STATES.GAME_OVER
				G.STATE_COMPLETE = false
			else
				if card.ability.extra.total_rounds < card.ability.extra.bomb_rounds then 
					card.ability.extra.total_rounds = card.ability.extra.total_rounds + 1
				else
					card.ability.extra.total_rounds = card.ability.extra.total_rounds + 1
					card:juice_up()
				end
			end
		end
	end,
	calc_dollar_bonus = function(self, card)
		return 10
	end
}
SMODS.Atlas{
	key = 'heliostag',
	path = 'heliospack.png',
	px = 32,
	py = 32
}
SMODS.Tag {
    key = "flame",
    min_ante = 1,
	atlas = 'heliostag',
	loc_txt = {
		name = 'Sun Tag',
		text = {
			'Gives a free Infernal Pack'
		}
	},
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_stickmin_Helios_booster
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_stickmin_Helios_booster', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
function SMODS.current_mod.reset_game_globals(run_start)
	resetbombrank()

end
