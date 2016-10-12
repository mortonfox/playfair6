# Playfair 6

## Introduction

Playfair 6 is a variation of the [Playfair
cipher](https://en.wikipedia.org/wiki/Playfair_cipher) that uses a 6x6 key grid
instead of a 5x5 grid. A 6x6 grid has 36 cells, enough for the letters A to Z
and the digits 0 to 9, so unlike the original Playfair, Playfair 6 supports
both letters and numbers, and doesn't need to combine I and J.

## How it works

First, we construct a grid from the letters A to Z and the digits 0 to 9:

    A B C D E F
    G H I J K L
    M N O P Q R
    S T U V W X
    Y Z 0 1 2 3
    4 5 6 7 8 9

Then, we add the key, in this case "PLAYFAIR 6", to the grid:

    P L A Y F I
    R 6 B C D E
    G H J K M N
    O Q S T U V
    W X Z 0 1 2
    3 4 5 7 8 9

From there on, encoding or decoding proceeds the same way as in the original
Playfair cipher.

## Usage

The command line help:

    $ ruby playfair6.rb -h
    Usage: playfair6.rb [options] message key
        -h, -?, --help                   Show help message
        -d, --decode                     Decode message (default)
        -e, --encode                     Encode message

Use the -e option to encode a message:

    $ ruby playfair6.rb -e 'the narwhal bacons at midnight' 'playfair 6'
    Grid:
    P L A Y F I
    R 6 B C D E
    G H J K M N
    O Q S T U V
    W X Z 0 1 2
    3 4 5 7 8 9

    Encoded message: QK NV PB XG YA JB RT JV YS NF EM PN KQ

Decoding is the default. So omit the -e option to decode a message:

    $ ruby playfair6.rb 'QK NV PB XG YA JB RT JV YS NF EM PN KQ' 'playfair 6'
    Grid:
    P L A Y F I
    R 6 B C D E
    G H J K M N
    O Q S T U V
    W X Z 0 1 2
    3 4 5 7 8 9

    Decoded message: TH EN AR WH AL BA CO NS AT MI DN IG HT

## Credits

The idea for writing this encoder/decoder came from several geocaching puzzles,
chiefly [GC2C604 - Playfair
6](https://www.geocaching.com/geocache/GC2C604_playfair-6).
