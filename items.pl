:-include('player.pl').

/* items.pl */

/* TOOLS*/
/* tool(X,Y): X adalah tool milik Y */
tool('hoe',farmer).
tool('fishing rod',fisherman).

hoelevel(1).
fishingrodlevel(1).

changeHoeLevel :- 
    levelplayer(CurrentPlayerLevel),
    hoelevel(Old),
    ( 0 =:= mod(CurrentPlayerLevel, 2)
        ->  NewHoeLevel is Old + 1,
            retract(hoelevel(Old)),
            asserta(hoelevel(NewHoeLevel))
    ).

changeFishingRodLevel :-
    levelplayer(CurrentPlayerLevel),
    fishingrodlevel(Old),
    ( 0 =:= mod(CurrentPlayerLevel, 2)
        ->  NewFishRodLevel is Old + 1,
            retract(fishingrodlevel(Old)),
            asserta(fishingrodlevel(NewFishRodLevel))
    ).

/* SEASON */
/* season(X): X adalah season */
/* sudah ada di main */

/* TYPE */
/* type(X): X adalah type */
type(harvest_item).
type(fish_item).
type(tool_item).
type(ranch_item).
type(animal_item).

/* SEEDS */
/* seed(X): X adalah seed */
seed('turnip seed').
seed('potato seed').
seed('cucumber seed').
seed('strawberries seed').
seed('cabbage seed').
seed('moondrop flower seed').
seed('toy flower seed').

seed('tomato seed').
seed('corn seed').
seed('onion seed').
seed('pumpkin seed').
seed('pineapple seed').
seed('pink cat flower seed').

seed('eggplant seed').
seed('carrot seed').
seed('yam seed').
seed('spinach seed').
seed('green pepper seed').
seed('adzuki beans seed').
seed('chili peppers seed').
seed('blue magic red flower seed').
seed('true magic red flower seed').
seed('sunsweet flower seed').

/* FISH */
/* fish(X): X adalah fish */
fish('arowana').
fish('beltfish').
fish('carp').
fish('char').
fish('cherry trout').
fish('honmoroko').
fish('keiji salmon').
fish('killfish').
fish('lake prawn').
fish('large crucian carp').
fish('large sea bass').
fish('large snakehead').

/* RANCH */
/* ranch(X): X adalah hasil produksi ranch */
ranch('egg').
ranch('golden egg').
ranch('milk').
ranch('golden milk').
ranch('wool').
ranch('golden wool').

/* ANIMAL */
/* animal(X): X adalah animal */
animal('chicken').
animal('cow').
animal('sheep').

/* SEASON SEED */
/* seasonSeed(X, Y): X adalah seed pada season Y */
seasonSeed('turnip seed',spring).
seasonSeed('potato seed',spring).
seasonSeed('cucumber seed',spring).
seasonSeed('strawberries seed',spring).
seasonSeed('cabbage seed',spring).
seasonSeed('moondrop flower seed',spring).
seasonSeed('toy flower seed',spring).

seasonSeed('tomato seed',summer).
seasonSeed('corn seed',summer).
seasonSeed('onion seed',summer).
seasonSeed('pumpkin seed',summer).
seasonSeed('pineapple seed',summer).
seasonSeed('pink cat flower seed',summer).

seasonSeed('eggplant seed',fall).
seasonSeed('carrot seed',fall).
seasonSeed('yam seed',fall).
seasonSeed('spinach seed',fall).
seasonSeed('green pepper seed',fall).
seasonSeed('adzuki beans seed',fall).
seasonSeed('chili peppers seed',fall).
seasonSeed('blue magic red flower seed',fall).
seasonSeed('true magic red flower seed',fall).
seasonSeed('sunsweet flower seed',fall).

/* SEASON FISH*/
/* seasonFish(X,Y): X adalah fish pada season Y */
seasonFish('arowana',spring).
seasonFish('arowana',summer).
seasonFish('arowana',fall).
seasonFish('arowana',winter).
seasonFish('beltfish',summer).
seasonFish('beltfish',fall).
seasonFish('carp',spring).
seasonFish('carp',summer).
seasonFish('carp',fall).
seasonFish('carp',winter).
seasonFish('char',spring).
seasonFish('char',summer).
seasonFish('cherry trout',spring).
seasonFish('cherry trout',summer).
seasonFish('honmoroko',fall).
seasonFish('honmoroko',winter).
seasonFish('keiji salmon',spring).
seasonFish('keiji salmon',summer).
seasonFish('keiji salmon',fall).
seasonFish('keiji salmon',winter).
seasonFish('killfish',spring).
seasonFish('killfish',summer).
seasonFish('killfish',fall).
seasonFish('lake prawn',fall).
seasonFish('lake prawn',winter).
seasonFish('large crucian carp',winter).
seasonFish('large sea bass',spring).
seasonFish('large sea bass',summer).
seasonFish('large snakehead',spring).
seasonFish('large snakehead',summer).
seasonFish('large snakehead',fall).

/* GROW TIME */
/* growTime(X,Y): Waktu tumbuh seed X adalah Y hari */
growTime('turnip seed',4).
growTime('potato seed',7).
growTime('cucumber seed',9).
growTime('strawberries seed',9).
growTime('cabbage seed',14).
growTime('moondrop flower seed',6).
growTime('toy flower seed',12).

growTime('tomato seed',9).
growTime('corn seed',14).
growTime('onion seed',7).
growTime('pumpkin seed',14).
growTime('pineapple seed',20).
growTime('pink cat flower seed',6).

growTime('eggplant seed',9).
growTime('carrot seed',7).
growTime('yam seed',6).
growTime('spinach seed',5).
growTime('green pepper seed',7).
growTime('adzuki beans seed',10).
growTime('chili peppers seed',12).
growTime('blue magic red flower seed',10).
growTime('true magic red flower seed',10).
growTime('sunsweet flower seed',10).

/* GROW */
growTo('turnip seed','turnip').
growTo('potato seed','potato').
growTo('cucumber seed','cucumber').
growTo('strawberries seed','strawberries').
growTo('cabbage seed','cabbage').
growTo('moondrop flower seed','moondrop flower').
growTo('toy flower seed','toy flower').

growTo('tomato seed','tomato').
growTo('corn seed','corn').
growTo('onion seed','onion').
growTo('pumpkin seed','pumpkin').
growTo('pineapple seed','pineapple').
growTo('pink cat flower seed','pink cat flower').

growTo('eggplant seed','eggplant').
growTo('carrot seed','carrot').
growTo('yam seed','yam').
growTo('spinach seed','spinach').
growTo('green pepper seed','green pepper').
growTo('adzuki beans seed','adzuki').
growTo('chili peppers seed','chili peppers').
growTo('blue magic red flower seed','blue magic red flower').
growTo('true magic red flower seed','true magic red flower').
growTo('sunsweet flower seed','sunsweet flower').

/* PRICE */
/* price(X,Y): Harga X adalah Y */
price('turnip seed',120).
price('potato seed',150).
price('cucumber seed',200).
price('strawberries seed',150).
price('cabbage seed',500).
price('moondrop flower seed',500).
price('toy flower seed',400).

price('tomato seed',200).
price('corn seed',300).
price('onion seed',150).
price('pumpkin seed',500).
price('pineapple seed',1000).
price('pink cat flower seed',300).

price('eggplant seed',120).
price('carrot seed',300).
price('yam seed',300).
price('spinach seed',200).
price('green pepper seed',150).
price('adzuki beans seed',300).
price('chili peppers seed',300).
price('blue magic red flower seed',600).
price('true magic red flower seed',600).
price('sunsweet flower seed',1000).

price('turnip',120).
price('potato',150).
price('cucumber',200).
price('strawberries',150).
price('cabbage',500).
price('moondrop flower',500).
price('toy flower',400).

price('tomato',200).
price('corn',300).
price('onion',150).
price('pumpkin',500).
price('pineapple',1000).
price('pink cat flower',300).

price('eggplant',120).
price('carrot',300).
price('yam',300).
price('spinach',200).
price('green pepper',150).
price('adzuki beans',300).
price('chili peppers',300).
price('blue magic red flower',600).
price('true magic red flower',600).
price('sunsweet flower',1000).

price('arowana',350).
price('beltfish',200).
price('carp',120).
price('char',120).
price('cherry trout',120).
price('honmoroko',50).
price('keiji salmon',350).
price('killfish',50).
price('lake prawn',20).
price('large crucian carp',200).
price('large sea bass',200).
price('large snakehead',200).

price('egg',35).
price('golden egg',125).
price('milk',55).
price('golden milk',250).
price('wool',75).
price('golden wool',375).

price('chicken',1000).
price('cow',2000).
price('sheep',4000).

price('Level 1 fishing rod', 500).
price('Level 1 hoe', 500).
price('Level 2 fishing rod', 1000).
price('Level 2 hoe', 1000).
price('Level 3 fishing rod', 1500).
price('Level 3 hoe', 1500).
price('Level 4 fishing rod', 2500).
price('Level 4 hoe', 2500).

/* ITEM TYPE */
/* itemType(X,Y): X adalah item dengan tipe Y */
itemType('hoe', tool_item).
itemType('fishing rod', tool_item).

itemType('arowana',fish_item).
itemType('beltfish',fish_item).
itemType('carp',fish_item).
itemType('char',fish_item).
itemType('cherry trout',fish_item).
itemType('honmoroko',fish_item).
itemType('keiji salmon',fish_item).
itemType('killfish',fish_item).
itemType('lake prawn',fish_item).
itemType('large crucian carp',fish_item).
itemType('large sea bass',fish_item).
itemType('large snakehead',fish_item).

itemType('turnip',harvest_item).
itemType('potato',harvest_item).
itemType('cucumber',harvest_item).
itemType('strawberries',harvest_item).
itemType('cabbage',harvest_item).
itemType('moondrop flower',harvest_item).
itemType('toy flower',harvest_item).
itemType('tomato',harvest_item).
itemType('corn',harvest_item).
itemType('onion',harvest_item).
itemType('pumpkin',harvest_item).
itemType('pineapple',harvest_item).
itemType('pink cat flower',harvest_item).
itemType('eggplant',harvest_item).
itemType('carrot',harvest_item).
itemType('yam',harvest_item).
itemType('spinach',harvest_item).
itemType('green pepper',harvest_item).
itemType('adzuki beans',harvest_item).
itemType('chili peppers',harvest_item).
itemType('blue magic red flower',harvest_item).
itemType('true magic red flower',harvest_item).
itemType('sunsweet flower',harvest_item).

itemType('egg',ranch_item).
itemType('golden egg',ranch_item).
itemType('milk',ranch_item).
itemType('golden milk',ranch_item).
itemType('wool',ranch_item).
itemType('golden wool',ranch_item).

itemType('chicken',animal_item).
itemType('cow',animal_item).
itemType('sheep',animal_item).

/* Seeds */
itemType('turnip seed',seed).
itemType('potato seed',seed).
itemType('cucumber seed',seed).
itemType('strawberries seed',seed).
itemType('cabbage seed',seed).
itemType('moondrop flower seed',seed).
itemType('toy flower seed',seed).

itemType('tomato seed',seed).
itemType('corn seed',seed).
itemType('onion seed',seed).
itemType('pumpkin seed',seed).
itemType('pineapple seed',seed).
itemType('pink cat flower seed',seed).

itemType('eggplant seed',seed).
itemType('carrot seed',seed).
itemType('yam seed',seed).
itemType('spinach seed',seed).
itemType('green pepper seed',seed).
itemType('adzuki beans seed',seed).
itemType('chili peppers seed',seed).
itemType('blue magic red flower seed',seed).
itemType('true magic red flower seed',seed).
itemType('sunsweet flower seed',seed).

/* ITEM TAGS */
/* Special quest items */
fishTag('arowana', 1).
fishTag('beltfish', 2).
fishTag('carp', 3).
fishTag('char', 4).
fishTag('cherry trout', 5).
fishTag('honmoroko', 6).
fishTag('keiji salmon', 7).
fishTag('killfish', 8).
fishTag('lake prawn', 9).
fishTag('large crucian carp', 10).
fishTag('large sea bass', 11).
fishTag('large snakehead', 12).

harvestTag('turnip', 1).
harvestTag('potato', 2).
harvestTag('cucumber', 3).
harvestTag('strawberries', 4).
harvestTag('cabbage', 5).
harvestTag('moondrop flower', 6).
harvestTag('toy flower', 7).
harvestTag('tomato', 8).
harvestTag('corn', 9).
harvestTag('onion', 10).
harvestTag('pumpkin', 11).
harvestTag('pineapple', 12).
harvestTag('pink cat flower', 13).
harvestTag('eggplant', 14).
harvestTag('carrot', 15).
harvestTag('yam', 16).
harvestTag('spinach', 17).
harvestTag('green pepper', 18).
harvestTag('adzuki beans', 19).
harvestTag('chili peppers', 20).
harvestTag('blue magic red flower', 21).
harvestTag('true magic red flower', 22).
harvestTag('sunsweet flower', 23).

ranchTag('egg', 1).
ranchTag('milk', 2).
ranchTag('wool', 3).