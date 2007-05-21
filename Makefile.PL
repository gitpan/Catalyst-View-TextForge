use 5.008007;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Catalyst::View::TextForge',
    VERSION_FROM      => 'lib/Catalyst/View/TextForge.pm', # finds $VERSION
    PREREQ_PM         => { Text::Forge => 4 }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Catalyst/View/TextForge.pm', # retrieve abstract from module
       AUTHOR         => 'Maurice Aubrey <maurice@cpan.org>') : ()),
);
