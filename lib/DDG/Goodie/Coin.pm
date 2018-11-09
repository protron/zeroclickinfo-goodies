package DDG::Goodie::Coin;
# ABSTRACT: flip a (fair) coin.

use strict;
use DDG::Goodie;

zci is_cached => 0;

triggers start => 'flip', 'toss', 'coin', 'heads';

handle query_lc => sub {
    my $flips;
    if ($_ =~ /^(heads or tails[ ]?[\?]?)|((flip|toss) (a )?coin)|(coin (flip|toss))$/) {
        $flips = 1;
    } elsif ($_ =~ /^(?:flip|toss) (\d{0,2}) coins?$/) {
        $flips = $1;
    }

    return unless ($flips);

    my @output;

    my @ht = ("heads", "tails");

    for (1 .. $flips) {
        my $flip = $ht[int rand @ht];
        push @output, $flip;
    }

    return unless @output;

    my $result = join(', ', @output);
    return $result . ' (random)', structured_answer => {
		data => {
			title => $result,
			subtitle => "Flip coin: $flips"
		},
		templates => {
			group => 'text'
		}
	};
};

1;
