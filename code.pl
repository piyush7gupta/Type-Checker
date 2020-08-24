lookup([{X,T}|_],X,T).
lookup([{Y,T2}|L2],X,T):-lookup(L2,X,T).

%union(L1,L2,Res).
union([],L2,L2).
union(L1,[],L1).
union([{X,T}|L1],L2,L3):-lookup(L2,variable(X),T2),union(L1,L2,L3).
union([{X,T}|L1],L2,[{X,T}|L3]):- ( \+ lookup(L2,variable(X),T2)),union(L1,L2,L3).

concat(G1,[],G1).
concat(G1,[G|G2],[G|G3]):-concat(G1,G2,G3).

bind_helper([{X,T1}|G],{X,T},[{X,T}|G]).
bind_helper([{Y,T1}|G],{X,T},[{Y,T1}|G1]):-bind_helper(G,{X,T},G1).
bind_helper([],{X,T},[{X,T}]).

bind(G1,[],G1).
bind(G1,[G|G2],G4):-bind_helper(G1,G,G3),bind(G3,G2,G4).


%Variable
hastype(G,variable(X),T):-lookup(G,variable(X),T).
hastype(G,variable(X),T):-lookup(G,X,T).

%constants both numerical and boolean
hastype(G, I, tint) :- integer(I).
hastype(G,const(X),tint).
hastype(G, true, tbool).
hastype(G, false, tbool).


%arithmetic operation over numerical operation
hastype(G,add(I1,I2),tint):-hastype(G,I1,tint) ,hastype(G,I2,tint).
hastype(G,sub(I1,I2),tint):-hastype(G,I1,tint) ,hastype(G,I2,tint).
hastype(G,mul(I1,I2),tint):-hastype(G,I1,tint) ,hastype(G,I2,tint).
hastype(G,div(I1,I2),tint):-hastype(G,I1,tint) ,hastype(G,I2,tint).
hastype(G,mod(I1,I2),tint):-hastype(G,I1,tint) ,hastype(G,I2,tint).
hastype(G,abs(I1),tint):-hastype(G,I1,tint).

%boolean operation over boolean operation
hastype(G,and(B1,B2),tbool):-hastype(G,B1,tbool),hastype(G,B2,tbool).
hastype(G,or(B1,B2),tbool):-hastype(G,B1,tbool),hastype(G,B2,tbool).
hastype(G,not(B1),tbool):-hastype(G,B1,tbool).

%compare operation over numerical operation
hastype(G,equal(I1,I2),tbool):-hastype(G,I1,tint),hastype(G,I2,tint).
hastype(G,less_than(I1,I2),tbool):-hastype(G,I1,tint),hastype(G,I2,tint).
hastype(G,greater_than(I1,I2),tbool):-hastype(G,I1,tint),hastype(G,I2,tint).
hastype(G,less_than_equalto(I1,I2),tbool):-hastype(G,I1,tint),hastype(G,I2,tint).
hastype(G,greater_than_equalto(I1,I2),tbool):-hastype(G,I1,tint),hastype(G,I2,tint).

%equality over abstract operations
hastype(G,equality(E1,E2),tbool):-hastype(G,E1,T),hastype(G,E2,T).

%if_then_else
hastype(G,if_then_else(B,E1,E2),T):-hastype(G,B,tbool),hastype(G,E1,T),hastype(G,E2,T).

%let D in E where D=def(V,E1).
hastype(G, let_in(D, E), T) :- typeElaborates(G, D, G1), bind(G,G1,C1),hastype(C1, E, T).

%function call and function abstraction
hastype(G,call(E1,E2),T2):-hastype(G,E1,arrowT(T1,T2)),hastype(G,E2,T1).
hastype(G,func(A,E1),arrowT(T1,T2)):-hastype(G,A,T1),hastype(G,E1,T2).

%ntuples
hastype(G, nTuple([]), tcartesian([])).
hastype(Gamma, nTuple([G|Gs]), tcartesian([T|Ts])) :- hastype(Gamma, G, T), hastype(Gamma, nTuple(Gs), tcartesian(Ts)).

%expression using projection
hastype(G,projection(const(1),nTuple([E|Es])),T):-hastype(G,E,T).
hastype(G,projection(const(N),nTuple([E|Es])),T):-N1 is N-1,hastype(G,projection(const(N1),nTuple(Es)),T).

%Simple Def,sequential def, parallel def, local def
typeElaborates(G, def(X,E),[{X,T}]):-hastype(G,E,T).
typeElaborates(G, seq(D1, D2), G3) :- typeElaborates(G, D1, G1), bind(G,G1,C1),typeElaborates(C1, D2, G2),bind(G1,G2,G3).
typeElaborates(G, par(D1,D2), G3) :- typeElaborates(G, D1, G1), typeElaborates(G, D2, G2),concat(G1,G2,G3).
typeElaborates(G, local(D1,D2) ,G2):-typeElaborates(G, D1, G1), bind(G,G1,C1),typeElaborates(C1, D2, G2).