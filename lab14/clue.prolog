victim(mr_boddy).
victim(cook).
victim(motorist).
victim(police_officer).
victim(yvette).
victim(singing_telegram).

suspect(professor_plum).
suspect(mrs_peacock).
suspect(mrs_white).
suspect(miss_scarlet).
suspect(colonel_mustard).
suspect(mr_green).
suspect(wadsworth).

weapon(wrench).
weapon(candlestick).
weapon(lead_pipe).
weapon(knife).
weapon(revolver).
weapon(rope).

room(hall).
room(kitchen).
room(lounge).
room(library).
room(billiard_room).

murder(mr_boddy,candlestick,hall).
murder(cook,knife,kitchen).
murder(motorist,wrench,lounge).
murder(police_officer,lead_pipe,library).
murder(singing_telegram,revolver,hall).
murder(yvette,rope,billiard_room).

%Victim, Suspect
motive(mr_boddy, A):- A \= wadsworth.
motive(cook, mrs_peacock).
motive(motorist, colonel_mustard).
motive(miss_scarlet, yvette).
motive(yvette, colonel_mustard).
motive(yvette, mrs_white).
motive(police_officer, miss_scarlet).
motive(singing_telegram, professor_plum).
motive(singing_telegram, wadsworth).

notuse(colonel_mustard, rope).
notuse(professor_plum, revolver).

notroom(miss_scarlet, billiard_room).
notroom(professor_plum, kitchen).

alibi(colonel_mustard, mr_boddy).
alibi(mrs_white, mr_boddy).
alibi(mr_green, _).
alibi(miss_scarlet, V) :- murder(V,_, R), murder(_, revolver,R).



% Update accuse to solve the murders.
% Add more facts and rules as needed.
accuse(V,S) :- murder(V,W,R), suspect(S),motive(V, S), not(notuse(S, W)), not(notroom(S, R)), not(alibi(S, V)).

