/**
 * human/4
 * A human player
 * @3: -Row - the played row
 * @4: -Col - the played col
 */
human(_, _, Row, Col) :-
  ask_user('Row', Row),
  ask_user('Col', Col).

/**
 * ask_user/2
 * @1: +What - what to ask
 * @2: -Input - the user input
 */
ask_user(What, Input) :-
  write(What),
  write(':\n'),
  read_line_to_codes(user_input,CodeInput),
  atom_codes(Input,CodeInput).
