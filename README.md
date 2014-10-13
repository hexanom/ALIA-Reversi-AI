ALIA-Reversi-AI
===============

A game of Reversi and multiple AIs

Installation
------------

Install a recent distribution of [SWI Prolog](http://www.swi-prolog.org/).

Clone this repo:

```shell
git clone https://github.com/hexanom/ALIA-Reversi-AI.git
cd ALIA-Reversi-AI
```

Usage
-----

### Setup

Reversi-AI has multiple configurations in `settings.pl`. Comment and uncomment what you want and what you don't want.

> **WARNING:** Just wire 1 predicate for each element.

### Run the match

Open a swipl:
```shell
swipl
```

And then just call the main !
```prolog
?- [main].
```

### Run the tests

Just do:
```prolog
?- [tests/tests].
```

