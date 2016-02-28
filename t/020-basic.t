use v6;
use Test;
use lib 'lib';
use Scientist;

my $test = Scientist.new(
    experiment => 'Tree',
    enabled => True,
    try => sub {return 99},
    use => sub {return 88},
);
is $test.experiment, 'Tree', 'Experiment is set correctly';

$test.experiment = 'Fauna';
is $test.experiment, 'Fauna', 'Able to change the experiment name';


my $result = $test.run;
is $result, 88, 'Run() Returns correct value';

done-testing;