unit class Scientist;

has %.context is rw;
has Bool $.enabled is rw;
has $.experiment is rw;
has &.try is rw;
has &.use is rw;

method ver { v0.0.1 }

method publish {
    # Requires populating to be useful.
}

my %result;
method result {
    return %result;
}

method run {
    return &.use.() unless ?$.enabled;

    my ( $control, $candidate );
    my $run_control = sub {
        $control = &.use.();
    };

    my $run_candidate = sub {
        $candidate = &.try.();
    };

    if ( rand > 0.5 ) {
        $run_control.();
        $run_candidate.();
    }
    else {
        $run_candidate.();
        $run_control.();
    }

    %result = (
        context    => %.context,
        experiment => $.experiment,
        mismatched => $control !eqv $candidate,
    );

    return $control;

}
