#
# https://adventofcode.com/2017/day/3
#
# According to which rules do the rings of the spiral and their numbers work?
# 1. Every ring has n*4 elements, where n is double the number of the
# rings (r), so the first one has 8 (1*2*4) the second one 16 (2*2*4) and so on.
# This can be simplified in that every ring adds 8 more to the bunch than
# the previous one (except the first, which is 1).
# So if we want to know how many numbers there are including
# ring 6, we can compute ring 6: 2*6*4 = 48 + (48 - 8) + (48 - 16) ...
# which can be simplified to 8 * r+1 * r/2 so 8 * 7 * 3 = 168
# (https://de.wikipedia.org/wiki/Gau%C3%9Fsche_Summenformel)
# So 168 + 1 (for square 1)
# TODO: generalize this including square 1
#
# 2. The biggest number of a ring is always in the lower right corner, which is
# two additional Manhattan distances from the previous one, same for the
# other corners. The points that have the shortest distance to
# go, are in the middle of the sides of the rings (distance r). The distance for
# any point in a ring can be computed by distance from the nearest middle plus
# |distance| to the number in question, with the furthest distance being the one
# of the corner elements (r + 1/2 r).
#
# 3. From knowing the number, how can we tell, which ring we are in?
# Some rings (without square 1)
#   8   =  1 * 8
#  24   =  3 * 8 factor +2
#  48   =  6 * 8 factor +3
#  80   = 10 * 8 factor +4
# 120   = 15 * 8 ...
# 168   = 21 * 8
# ...
#
# Factors sum up to the current factor (i.e. 10 = 4 + 3 + 2 + 1)
#

use v6;

sub find_next_ring(Int $number) {

    # find next biggest divisible by 8
    my $div_by_8 = $number;
    if !($div_by_8 %% 2) {
        $div_by_8++;
    }
    while !($div_by_8 %% 8) { $div_by_8 += 2; }

    my $factor = $div_by_8 / 8;
    # find next ring - next divisible by 8 that is a sum of 1,2,3 ...
    my $ring = 0;
    my $i = 0;
    while $ring < $number {
      $i++;
      $ring += $i * 8;
    }

    # to return all numbers up to the last of the current ring add square 1
    return ($ring + 1, $i * 8, $i);
}

sub MAIN(Int :$number = 289326) {
    my ($numbers_total, $numbers_ring, $ring) = find_next_ring($number - 1);

    my $middle_offset = $numbers_ring / 4 / 2;

    # to find the first middle of the sides, subtract one offset from max
    my $shortest = $numbers_total - $middle_offset;
    while abs($number - $shortest) > abs($number - ($shortest - $middle_offset * 2)) {
        # to find the next middle, subtract two offsets to skip the corners
        $shortest -= $middle_offset * 2;
    }

    say "Steps from number to shortest path entry ($shortest): "
          ~ abs($number - $shortest)
          ~ " Rings: $ring"
          ~ " Steps needed: " ~ abs($number - $shortest) + $ring;

    # Part b
    # to calculate the numbers we need our position, which means orientation
    # (upper, right ...) and our direction (to know what is empty)
    # corners: sum = previous number + diagonal
    # other: sum = previous number + diagonal + inner number
}
