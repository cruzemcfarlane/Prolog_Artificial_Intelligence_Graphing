/*COMP3220 ASSIGNMENT 2
Roynor Thaxter (6200)
Dukiemar Shaw  (6200)
Anthony Scott  (6200)
Cruze McFarlane(6200)
*/

/*parishes in Jamaica*/
parish(westmoreland).
parish(st_elizabeth).
parish(manchester).
parish(clarendon).
parish(st_catherine).
parish(st_andrew).
parish(kingston).
parish(st_thomas).
parish(portland).
parish(st_mary).
parish(st_ann).
parish(trelawny).
parish(st_james).
parish(hanover).

/*Parish relationships*/
/*parishes that are adjacent to Westmoreland */
neighbour(westmoreland,hanover).
neighbour(westmoreland,st_james).
neighbour(westmoreland,st_elizabeth).

/*parishes that are adjacent to St.Elizabeth */
neighbour(st_elizabeth,manchester).
neighbour(st_elizabeth,westmoreland).
neighbour(st_elizabeth,trelawny).
neighbour(st_elizabeth,st_james).

/*parishes that are adjacent to Manchester */
neighbour(manchester,clarendon).
neighbour(manchester,st_ann).
neighbour(manchester,trelawny).
neighbour(manchester,st_elizabeth).

/*parishes that are adjacent to Clarendon  */
neighbour(clarendon,manchester).
neighbour(clarendon,st_catherine).
neighbour(clarendon,st_ann).
neighbour(clarendon,trelawny).

/*parishes that are adjacent to St.Catherine */
neighbour(st_catherine,clarendon).
neighbour(st_catherine,st_andrew).
neighbour(st_catherine,st_mary).
neighbour(st_catherine,st_ann).

/*parishes that are adjacent to St.Andrew */
neighbour(st_andrew,kingston).
neighbour(st_andrew,st_mary).
neighbour(st_andrew,st_thomas).
neighbour(st_andrew,portland).
neighbour(st_andrew,st_catherine).

/*parishes that are adjacent to Kingston */
neighbour(kingston,st_andrew).

/*parishes that are adjacent to St.Andrew */
neighbour(st_thomas,st_andrew).
neighbour(st_thomas,portland).

/*parishes that are adjacent to Portland */
neighbour(portland,st_andrew).
neighbour(portland,st_thomas).
neighbour(portland,st_mary).

/*parishes that are adjacent to St.Mary */
neighbour(st_mary,portland).
neighbour(st_mary,st_andrew).
neighbour(st_mary,st_catherine).
neighbour(st_mary,st_ann).

/*parishes that are adjacent to St.Ann */
neighbour(st_ann,st_mary).
neighbour(st_ann,st_catherine).
neighbour(st_ann,clarendon).
neighbour(st_ann,manchester).
neighbour(st_ann,trelawny).

/*parishes that are adjacent to Trelawny */
neighbour(trelawny,manchester).
neighbour(trelawny,st_ann).
neighbour(trelawny,clarendon).
neighbour(trelawny,st_james).
neighbour(trelawny,st_elizabeth).

/*parishes that are adjacent to St.James */
neighbour(st_james,trelawny).
neighbour(st_james,st_elizabeth).
neighbour(st_james,hanover).
neighbour(st_james,westmoreland).

/*parishes that are adjacent to Hanover */
neighbour(hanover,st_james).
neighbour(hanover,westmoreland).

/*This is the rule for adjacency*/
adjacent( Parish_A, Parish_B ) :-
	neighbour( Parish_A, Parish_B ).

adjacent( Parish_A, Parish_B  ) :-
	neighbour( Parish_A, Parish_B  ).

/*The colours to be use on the map as shown in the assignment description*/
colour(pink).
colour(green).
colour(orange).
colour(yellow).
colour(purple).

/*The list of parishes in jamaica*/
parish_list([westmoreland,st_elizabeth,manchester,clarendon,st_catherine,st_andrew,kingston,st_thomas,portland,st_mary,st_ann,trelawny,st_james,hanover]).

/*This is the rule to checks fo conflicts in the colouring,that is, if two parishes are adjacent to each other and have the same colour */
conflict( colour( Parish_A, Colour ), colour( Parish_B, Colour )) :-
	adjacent( Parish_A, Parish_B  ).

/*The utilizes the conflict rule to ensure that there are not conflicts in colours for adjacent nodes. This rule is used in "assign_colour" below as a part of the checks for assigning the colours*/
no_conflict( _, [] ).
no_conflict( ColourA, [ColourB | Other_Colours] ) :-
	not( conflict( ColourA, ColourB )),no_conflict( ColourA, Other_Colours ).

/*The "assign_colour" rules are recursive with the first "assign_colour" being the base case and the second assign colour being the recursive case where the head and tail of the parish list is assigned respective colours. */
assign_colour( [], [] ).
assign_colour( [First_parish | Others], [Colour_choice1 | Other_colours] ) :-
	assign_colour( Others, Other_colours ),
	Colour_choice1 = colour( First_parish, Colour ),colour( Colour ),
	no_conflict( Colour_choice1, Other_colours ).

/*This is the query that shows the overall colouring*/
colour_all_parishes( Colouring ) :-
	parish_list( Parish_list ),assign_colour( Parish_list, Colouring ).



/*Project Description
In solving this problem we first outlined a series of facts that
shows each of the parishes and their respective neighbours. We tracked
each parish relationship individually and from the facts about which
parish were neighbours we formulated the rule of adjacency which stated
that neighbouring parishes are adjacent to each other. We then create
the facts that defined the colours as seen on the map in the assignment.
A list to store the parishes was also created. We formulated three
important rules which were the no_conflict,conflict and assign_colour
which were at the heart of the solution. The rules uses
backtracking(depth first search) to traverse the lists and get to the
solution. If the initial state is a goal state, quit and return success
otherwise,it loops until success or failure is signaled.It generates a
state that is the successor of the initial state. If there is no
successor it signals failure and call Depth-First Search with the the
initial state.If success is returned,it signal success otherwise it
continue in this loop. This approach was used because it was simplest to
implement as it provided a simple traversal of the list of parishes and
colours.

Possible Drawback:
There is no guarantee that it will find the
minimal solution in terms of the amount of colours used if there is more
than one solution.


How to execute the program.
To execute the program run the following query:"colour_all_parishes(Colouring)."

NB. The prolog compiler may not display all the result and you may see
the list ending with "colour(..., ...)|...]".If you encounter this
case where only a part of the result is diplayed simply press "w" and it
will display all the colourings on the next line.

NB. Colouring is a variable so you could use any variable in the query
as long as it is capitalized. eg.
colour_all_parishes(Jamaica),colour_all_parishes(X). would also work.
*/









