unit class Scientist;

has      %.context    is rw;
has Bool $.enabled    is rw = True;
has Str  $.experiment is rw;
has      &.try        is rw;
has      &.use        is rw is required;

method publish (%result) {
    # Requires populating to be useful.
}

my %result;
method result {
    return %result;
}

method run {
    return &.use.() unless $.enabled;

    %result = (
        context    => %.context,
        experiment => $.experiment,
    );

    my ($candidate, $control);
    my $run_control = sub {
        my $start = now;
        $control = &.use.();
        %result{'control'}{'duration'} = now - $start;
    };

    my $run_candidate = sub {
        my $start = now;
        try {
            $candidate = &.try.();
        }
        %result{'candidate'}{'duration'} = now - $start;
    };

    if ( rand > 0.5 ) {
        $run_control.();
        $run_candidate.();
    }
    else {
        $run_candidate.();
        $run_control.();
    }
    %result{'mismatched'} = $control !eqv $candidate;

    $.publish(%result);

    return $control;
}
