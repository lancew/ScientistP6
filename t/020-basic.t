use v6;
use Test;
use lib 'lib';
use Scientist;

my $test = Scientist.new(
    experiment => 'Tree',
    try => sub {return 99},
);
my $name = $test.experiment;
ok $name eq 'Tree', 'Experiment is set correctly';

my $result = $test.run();
ok $result == 88, 'Run() Returns correct value';

done-testing;