use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'EmbedIT::WebIT',
    AUTHOR              => q{Dimitris Evmorfopoulos <devmorfo@gmail.com>},
    VERSION_FROM        => 'lib/EmbedIT/WebIT.pm',
    ABSTRACT_FROM       => 'lib/EmbedIT/WebIT.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'EmbedIT-WebIT-*' },
);
