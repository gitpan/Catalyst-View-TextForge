package Catalyst::Helper::View::TextForge;

use strict;

=head1 NAME

Catalyst::Helper::View::TextForge - Helper for Text::Forge Views

=head1 SYNOPSIS

    script/create.pl view TextForge TextForge 

=head1 DESCRIPTION

Helper for Text::Forge Views.

=head2 METHODS

=head3 mk_compclass

=cut

sub mk_compclass {
  my ( $self, $helper ) = @_;
  my $file = $helper->{file};
  $helper->render_file('compclass', $file);
}

=head1 SEE ALSO

L<Catalyst::View::TextForge>, L<Catalyst::Help>

=head1 AUTHOR

Maurice Aubrey, C<maurice@cpan.org>

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;

__DATA__

__compclass__
package [% class %];

use strict;
use base qw/ Catalyst::View::TextForge /;

=head1 NAME

[% class %] - Text::Forge View Component

=head1 SYNOPSIS

    Very simple to use

=head1 DESCRIPTION

Very nice component.

=head1 AUTHOR

Clever guy

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
