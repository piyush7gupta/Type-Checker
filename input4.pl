andhastype([],const(33),T).
andhastype([],const(33),tint).
hastype([],true,T).
hastype([],true,tbool).

hastype([],add(const(5),const(33)),T).
hastype([],add(const(5),const(33)),tint).
hastype([],sub(const(5),const(33)),T1).
hastype([],add(const(5),true),T2).
hastype([],add(const(5),true),tbool).
hastype([],add(const(5),true),tint).
hastype([],sub(const(5),true),T3).
hastype([],abs(const(3)),tint).
hastype([],abs(const(3)),T4).
hastype([],abs(false),T5).

hastype([],and(true,const(4)),T).
hastype([],and(true,const(4)),tbool).
hastype([],and(true,false),tbool).
hastype([],and(true,false),tint).
hastype([],and(true,false),T).

hastype([{"x",tint},{"Y",tbool},{"L",intA},{"Q",intAA}],and(true,variable("x")),T).
hastype([{"x",tint},{"Y",tbool},{"L",intA},{"Q",intAA}],and(true,variable("x")),tbool).
hastype([{"x",tint},{"Y",tbool},{"L",intA},{"Q",intAA}],and(true,variable("Y")),T).
hastype([{"x",tint},{"Y",tbool},{"L",intA},{"Q",intAA}],and(true,variable("Y")),tint).
hastype([{"x",tint},{"Y",tbool},{"L",intA},{"Q",intAA}],and(true,variable("Y")),tbool).

lookup([{"x",tint},{"Y",intZ},{"L",intA},{"Q",intAA}],variable("x"),T).

union([{"x",tint},{"Y",intZ}],[{"Y",intA},{"Q",intAA}],XX).

hastype([],or(true,false),tbool).
hastype([],or(true,false),T).
hastype([],not(true),tbool).
hastype([],not(true),T).
hastype([],not(true),tint).
hastype([],and(true,false),tbool).
hastype([],and(true,false),tint).
hastype([],and(true,false),tcartesian).
hastype([],and(true,false),T).

hastype([],greater_than(const(X),const(Y)),T).
hastype([],greater_than(const(X),const(Y)),tint).
hastype([],greater_than(const(X),const(Y)),tbool).
hastype([],greater_than_equalto(const(X),const(Y)),T).
hastype([],less_than(const(X),const(Y)),T).
hastype([],less_than_equalto(const(X),const(Y)),T).
hastype([],less_than_equalto(const(X),false),tbool).
hastype([],less_than_equalto(const(X),false),T).

hastype([],equality(add(const(4),const(2)),mul(const(33),const(22))),T).
hastype([],equality(add(const(4),const(2)),mul(const(33),const(22))),tint).
hastype([],equality(and(true,false),not(true)),T).

hastype([],if_then_else(and(true,true),const(3),false),tint).
hastype([],if_then_else(and(true,true),const(3),false),T).
hastype([],if_then_else(and(true,true),const(3),const(33)),T).
hastype([],if_then_else(and(true,true),const(3),const(33)),tint).
hastype([],if_then_else(and(true,true),const(3),const(33)),tint).

hastype([],let_in(def("x",true),variable("x")),T).
hastype([{"x",tint},{"Y",intZ},{"L",intA},{"Q",intAA}],let_in(def("x",true),variable("x")),T).
hastype([],let_in(par(def("x",true),def("x",const(4))),variable("y")),T).
hastype([],let_in(seq(def("x",true),def("y",const(4))),variable("x")),T).
hastype([],let_in(local(def("x",true),def("y",and(variable("x"),true))),variable("y")),T).
hastype([],let_in(seq(def("x",true),def("x",const(4))),variable("x")),T).

typeElaborates([],local(def("x",true),def("y",and(variable("x"),true))),T).
typeElaborates([],par(def("x",true),def("x",const(4))),T).
typeElaborates([],par(def("x",true),def("y",const(4))),T).
typeElaborates([],seq(def("x",true),def("x",const(4))),T).



hastype([],nTuple([and(true,false),const(3)]),tcartesian(XX)).
hastype([{"x",tbool}],nTuple([and(true,false),const(3),add(const(4),const(33))]),tcartesian(XX)).
hastype([{"x",tbool}],nTuple([and(true,false),const(3),add(const(4),const(33))]),T).
hastype([{"x",tbool}],nTuple([and(true,false),const(3),add(const(4),const(33)),variable("x")]),tcartesian(XX)).

hastype([],projection(const(1),nTuple([and(true,false),const(3),add(const(4),const(33))])),T).
hastype([],projection(const(3),nTuple([and(true,false),const(3),add(const(4),const(33))])),T).

hastype([],func(variable("x"),add(variable("x"),const(4))),arrowT(tint,tint)).
hastype([],func(variable("x"),add(variable("x"),const(4))),X).
hastype([{"x",tint}],func(variable("x"),add(variable("x"),const(4))),X).
hastype([{"x",tint}],func(variable("x"),equality(variable("x"),const(4))),X).
hastype([{"x",tint}],call(func(variable("x"),add(variable("x"),const(4))),4),X).
hastype([{"x",tint}],call(func(variable("x"),add(variable("x"),const(4))),4),X).
hastype([{"x",tint}],call(func(variable("x"),equality(variable("x"),const(4))),true),X).


hastype([{"x",tint}],call(func(variable("x"),add(variable("x"),const(4))),add(add(const(4),const(4)),const(22))),TT).
% hastype([],call(func(variable("x"),equality(add(6,const(4)),8)),add(add(const(4),const(4)),const(22))),TT).
% hastype([],call(func(variable("x"),equality(add(6,const(4)),8)),add(add(const(4),const(4)),const(22))),tbool).

% hastype([],call(func(variable("x"),equality(add(6,const(4)),8)),add(add(const(4),const(4)),const(22))),tbool).


hastype([{variable("x"),tint},{variable("y"),tbool}],func(func(variable("y"),variable("x")),3),T).
hastype([{variable("x"),tint},{variable("y"),tbool}],func(func(variable("y"),variable("x")),nTuple([])),T).
hasype([],call(X,tint),tint).
hastype([],func(variable("x"),variable("x")),T).


hastype([],equality(X,Y),tbool).
hastype([],equality(and(true,false),add(4,const(6))),TT).

typeElaborates([],par(def(variable("x"),const(3)),def(variable("y"),variable("x"))),T).
typeElaborates([],par(def(variable("x"),variable("y")),def(variable("y"),const(3))),T).
typeElaborates([],seq(def(variable("x"),const(3)),def(variable("y"),variable("x"))),T).
typeElaborates([],local(def(variable("x"),const(3)),def(variable("y"),variable("x"))),T).
typeElaborates([],seq(def(variable("y"),variable("x")),def(variable("x"),const(3))),T).
typeElaborates([],seq(seq(def(variable("x"),const(3)),def(variable("y"),variable("x"))),def(variable("z"),534)),T).
typeElaborates([],par(seq(def(variable("x"),const(3)),def(variable("y"),variable("x"))),def(variable("z"),534)),T).
typeElaborates([{variable("x"),tbool}],seq(def(variable("y"),variable("x")),def(variable("x"),const(3))),T).
typeElaborates([{variable("x"),tint}],def(variable("y"),variable("x")),T).
typeElaborates([],def(variable("x"),1),T).

bind([{a,b}],[{c,d}],[]).

%Polymorphism type
hastype([],func(variable("x"),variable("x")),arrowT(tint,tint)).
hastype([{"x",tint}],func(variable("x"),variable("x")),arrowT(tint,tint)).
