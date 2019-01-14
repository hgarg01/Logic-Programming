:-use_module('maze.pl',[mazeSize/2,barrier/2]).
:- use_module(drawmaze).

% Checks if a particular Row and Column is inside the maze and not a
% barrier
is_available(Row,Col) :-
    mazeSize(Rows, Cols),
    \+barrier(Row,Col),
    Row >= 1,
    Row =< Rows,
    Col >= 1,
    Col =< Cols.

%Finds the next move from the current position
next_move([Row0,Col0],[Row1,Col0]) :-
          Row1 is Row0+1.%Down
next_move([Row0,Col0],[Row0,Col1]) :-
          Col1 is Col0+1.%Right
next_move([Row0,Col0],[Row0,Col1]) :-
          Col1 is Col0-1.%Left
next_move([Row0,Col0],[Row1,Col0]) :-
          Row1 is Row0-1.%Up

% CAlls the path function to calculate and display path from Source to
% Destination
solve(Src, Dest, P) :- path(Src, Dest, [Src], P),
    !.
%If the Destination is reached, it displays the path on the maze
path(Dest,Dest, M,[]) :-
    draw(5,9,M),!.

%Calculates the path
path([Row0,Col0],[Row1,Col1],M,[Rnew,Cnew]|Path) :-
    %writeln(M),
    next_move([Row0,Col0],[Rnew,Cnew]),
    is_available(Rnew, Cnew),
    not(member([Rnew, Cnew],M )),
    path([Rnew, Cnew], [Row1, Col1],[[Rnew,Cnew]|M],Path).

