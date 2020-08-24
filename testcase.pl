hastype([{variable(y),tbool},{variable(x),tint}],less_than(variable(x),23),W).
hastype([{variable(y),tbool},{variable(x),tint}],nTuple([true,false,23,variable(y),variable(x)]),W).
typeElaborates([], seq(def(variable(y), 23), def(variable(x), true)), W).