:- module(drawmaze,[draw/3,draw_char/4,draw_rows/4]).
:- use_module('maze.pl',[mazeSize/2,barrier/2]).

draw(Row,Col,Path) :-
    mazeSize(Row,Col),
    %Displays the Column numbers
    writeln('    1 2 3 4 5 6 7 8 9 '),
    writeln('  +-------------------+'),
    Rows is Row+1,
    Cols is Col+1,
    %Displays all the rows
    draw_rows(Rows,1,Cols,Path),
    writeln('  +-------------------+').
draw(_,_,[]).

draw_char(Cols,Cols,_,_).
draw_char(Cols,I,J,Path) :-
    member([J,I],Path),
    %if the path exists at location I,J , it displays '*'
    write(' *'),
    NextI is I+1,
    draw_char(Cols, NextI, J, Path).
draw_char(Cols,I,J,Path) :-
      barrier(J,I),
      %If there is a barrier on a particular positin , display X
      write(' X'),
      NextI is I+1,
    draw_char(Cols,NextI,J,Path).
draw_char(Cols,I,J,Path) :-
    NextI is I+1,
   \+barrier(J,I),
   %If there's no barrier on that position, display '.'
      write(' .'),
    draw_char(Cols,NextI,J, Path).


draw_rows(Rows,Rows,_,_).
draw_rows(Rows,J,Cols,Path) :-
    NextJ is J+1,
    write(J),
    write(' |'),
    draw_char(Cols,1,J,Path),
    write(' |\n'),
    draw_rows(Rows,NextJ,Cols,Path).

