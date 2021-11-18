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