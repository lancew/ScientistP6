use v6;
use Test;
use lib 'lib';
use Scientist;

class MyScientist is Scientist {
    has $.test_value is rw;
    method publish (%result){
        $.test_value =  101;
    }
}

my $experiment = MyScientist.new(
    experiment => 'Tree',
    enabled => True,
    try => sub {return 99},
    use => sub {return 88},
);

$experiment.run;

is $experiment.test_value, 101, 'Publish set the value we expected';

done-testing;