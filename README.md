# DESCRIPTION

Raku module inspired by [GitHub's Scientist](https://github.com/github/scientist) ([announcement](https://github.blog/2016-02-03-scientist/)).

See also: [Test::Lab](https://raku.land/github:MadcapJake/Test::Lab) for a different take on the same idea.

[![test](https://github.com/lancew/ScientistP6/actions/workflows/test.yml/badge.svg)](https://github.com/lancew/ScientistP6/actions/workflows/test.yml)

# SYNOPSIS

```mermaid
flowchart LR
    raku[$exp.run]
         -->|execute| use(Control Code)
         --> compare(Compare Result)

    raku -->|execute| try(Candidate Code)
         --> compare(Compare Result)

    use --> return[Return Result]

    compare -->|publish| Metrics
```

```raku
use Scientist;

my $experiment = Scientist.new(
    experiment => 'Tree',
    try => sub {return 99},
    use => sub {return 10},
);

my $answer = $experiment.run;

say "The number ten is $answer";
warn 'There was a mismatch between control and candidate'
    if $test.result{'mismatched'};
```

# Introduction

This module is inspired by the Scientist ruby code released by GitHub under the MIT license in 2015/2016.

In February 2016 I started writing the Perl5 module to bring similar ideas to Perl. Later I started this module to apply same ideas in Raku.

Please get involved in this module; contact lancew@cpan.org with ideas, suggestions; support, etc.

This code is also released under the MIT license to match the original Ruby implementation.

# Methods / Attributes

## context(<HASHREF>)

Provide contextual information for the experiment; will be returned in the result set.

Should be a hashref

## enabled(<TRUE>|<FALSE>)

DEFAULT : TRUE
Boolean switch to enable or disable the experiment. If disabled the experiment will only return
the control code (use) result. The candidate code (try) will NOT be executed. The results set will
not be populated.

## experiment(<STRING>)

Simply the name of the experiment included in the result set.

## publish

Publish is a method called by ->run().

Scientist is design so that you create your own personalised My::Scientist module and extend publish to do what you want/need.
For example push timing and mismathc information to Statsd.

## use(<CODEREF>)

Control code to be included in the experiment.
This code will be executed and returned when the experiment is run.
NB: This code is run and returned even if experiment enabed=false.

## run()

This method executes the control (use) code and if experiment enabled will also run the candidate (try)
code. The control and candidate code is run in random order.

## try(<CODEREF>)

Candidate code to be included in the experiment.
This code will be executed and discarded when the experiment is run.

# Extending Publish

To automate reporting of experiement results, you will want to write your own .publish() method. Publish is called by .run().

A typical example would be to push timing information to Statsd or a database.

```raku
use Scientist;

class MyScientist is Scientist {
    has $.test_value is rw;
    method publish {
        # Do Stuff...
    }
}

my $experiment = MyScientist.new(
    experiment => 'Tree',
    enabled => True,
    try => sub {return 99},
    use => sub {return 88},
);
```

# AUTHOR

Lance Wicks <lancew@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Lance Wicks.

This is free software, licensed under:

  The MIT (X11) License

The MIT License

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to
whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall
be included in all copies or substantial portions of the
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT
SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

# SEE ALSO

http://www.infoq.com/news/2016/02/github-scientist-refactoring

http://githubengineering.com/scientist/

https://news.ycombinator.com/item?id=11104781

https://github.com/ziyasal/scientist.js

http://tech-blog.cv-library.co.uk/2016/03/03/introducing-scientist/

