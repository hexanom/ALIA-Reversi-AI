/* Package imports */
?- ['../../engine/init'].
?- ['../../engine/model'].
?- ['../../engine/rules'].

?- admissible_plays(w, B, 2, 4),board(B).
?- admissible_plays(b, B, 4, 5),board(B).
