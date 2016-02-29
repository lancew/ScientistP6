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

is $test.result{'mismatched'}, True, 'Mismatched identified correctly';

$test.try = sub{return 88};
$result = $test.run;
is $test.result{'mismatched'}, False, 'Match identified correctly';


$test.try = sub { return {a=>'alpha', b=>'beta', c => [1,2,3,4,5] } };
$test.use = sub { return { c => [1,2,3,4,5], a=>'alpha', b=>'beta' } };
$result = $test.run;
is $test.result{'mismatched'}, False, 'Complex data match identified correctly';

ok $test.result{'candidate'}{'duration'}.Real > 0, 'Candidate Duration returned > 0';
ok $test.result{'control'}{'duration'}.Real > 0, 'Control Duration returned > 0';

done-testing;