use v6;

my %funcs =  
            "minmax" => 
                    sub (@numbers) {
                        my ($min, $max) = (@numbers[0], 0);
                        for @numbers -> $number {
                          if $number < $min { $min = $number }
                          if $number > $max { $max = $number }
                        }
                        return $max - $min;
                    },

            "evendiv" =>
                    sub (@numbers) {
                        my @sorted = @numbers.sort( { $^a <=> $^b });
                        for @sorted -> $divisor {
                          for @sorted.reverse -> $dividend {
                              if $dividend < $divisor * 2 {
                                  last;
                              }
                              if $dividend %% $divisor {
                                  return $dividend / $divisor;
                              }
                          }
                        }
                        return 0;
                    }
            ;

my $base = $*PROGRAM-NAME.split(/\./)[0];

sub MAIN(Str :$inputfile = "$base.in",
         Str :$mode where { $mode eq "minmax" || $mode eq "evendiv" } = "minmax") {

    my @lines = $inputfile.IO.lines;

    my $checksum = 0;
    for @lines -> $line {
        $checksum += %funcs{$mode}($line.split(/\s+/, :skip_empty));
    }

    say $checksum;
}

