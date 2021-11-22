/* items.pl */

/* Fakta */

/* TOOLS*/
/* tool(X,Y): X adalah tool milik Y */
tool('hoe',farmer).
tool('fishing rod',fisherman).

/* SEASON */
/* season(X): X adalah season */
season(spring).
season(summer).
season(fall).
season(winter).

/* TYPE */
/* type(X): X adalah type */
type(harvest_item).
type(fish_item).
type(tool_item).
type(ranch_item).
type(animal_item).

/* SEEDS */
/* seed(X): X adalah seed */
seed('turnip').
seed('potato').
seed('cucumber').
seed('strawberries').
seed('cabbage').
seed('moondrop flower').
seed('toy flower').

seed('tomato').
seed('corn').
seed('onion').
seed('pumpkin').
seed('pineapple').
seed('pink cat flower').

seed('eggplant').
seed('carrot').
seed('yam').
seed('spinach').
seed('green pepper').
seed('adzuki beans').
seed('chili peppers').
seed('blue magic red flower').
seed('true magic red flower').
seed('sunsweet flower').

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
seasonSeed('turnip',spring).
seasonSeed('potato',spring).
seasonSeed('cucumber',spring).
seasonSeed('strawberries',spring).
seasonSeed('cabbage',spring).
seasonSeed('moondrop flower',spring).
seasonSeed('toy flower',spring).

seasonSeed('tomato',summer).
seasonSeed('corn',summer).
seasonSeed('onion',summer).
seasonSeed('pumpkin',summer).
seasonSeed('pineapple',summer).
seasonSeed('pink cat flower',summer).

seasonSeed('eggplant',fall).
seasonSeed('carrot',fall).
seasonSeed('yam',fall).
seasonSeed('spinach',fall).
seasonSeed('green pepper',fall).
seasonSeed('adzuki beans',fall).
seasonSeed('chili peppers',fall).
seasonSeed('blue magic red flower',fall).
seasonSeed('true magic red flower',fall).
seasonSeed('sunsweet flower',fall).

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
growTime('turnip',4).
growTime('potato',7).
growTime('cucumber',9).
growTime('strawberries',9).
growTime('cabbage',14).
growTime('moondrop flower',6).
growTime('toy flower',12).

growTime('tomato',9).
growTime('corn',14).
growTime('onion',7).
growTime('pumpkin',14).
growTime('pineapple',20).
growTime('pink cat flower',6).

growTime('eggplant',9).
growTime('carrot',7).
growTime('yam',6).
growTime('spinach',5).
growTime('green pepper',7).
growTime('adzuki beans',10).
growTime('chili peppers',12).
growTime('blue magic red flower',10).
growTime('true magic red flower',10).
growTime('sunsweet flower',10).

/* PRICE */
/* price(X,Y): Harga X adalah Y */
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

/* ITEM TYPE */
/* itemType(X,Y): X adalah item dengan tipe Y */
itemType('hoe', tool_item).
itemType('fishing rod', tool_item).

itemType('arowana',fish_item).
itemType('arowana',fish_item).
itemType('arowana',fish_item).
itemType('arowana',fish_item).
itemType('beltfish',fish_item).
itemType('beltfish',fish_item).
itemType('carp',fish_item).
itemType('carp',fish_item).
itemType('carp',fish_item).
itemType('carp',fish_item).
itemType('char',fish_item).
itemType('char',fish_item).
itemType('cherry trout',fish_item).
itemType('cherry trout',fish_item).
itemType('honmoroko',fish_item).
itemType('honmoroko',fish_item).
itemType('keiji salmon',fish_item).
itemType('keiji salmon',fish_item).
itemType('keiji salmon',fish_item).
itemType('keiji salmon',fish_item).
itemType('killfish',fish_item).
itemType('killfish',fish_item).
itemType('killfish',fish_item).
itemType('lake prawn',fish_item).
itemType('lake prawn',fish_item).
itemType('large crucian carp',fish_item).
itemType('large sea bass',fish_item).
itemType('large sea bass',fish_item).
itemType('large snakehead',fish_item).
itemType('large snakehead',fish_item).
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