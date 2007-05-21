package Catalyst::View::TextForge;

use strict;
use base qw/ Catalyst::View /;

our $VERSION = '0.02';

BEGIN {
  package Text::Forge::Catalyst;

  use strict;
  use base qw/ Text::Forge /;

  sub catalyst { $_[0]->{catalyst} }
  *c = \&catalyst;
}

sub process {
  my ($self, $c) = @_;

  my $path = $c->stash->{template} || $c->req->match;
  unless ($path) {
    $c->log->debug('No template specified') if $c->debug;
    return 0;
  }

  $c->log->debug(qq/Rendering template "$path"/) if $c->debug;

  my $tf = Text::Forge::Catalyst->new;
  $tf->search_paths($self->config->{root} || $c->config->{root});
  $tf->{catalyst} = $c;
  eval { $tf->run($path, $c->stash, $c) };
  if ($@) {
    my $err = "Error generating template '$path': $@";
    $c->log->error($err);
    $c->error($err);
    return 0;
  }

  unless ($c->response->content_type) {
    $c->response->content_type('text/html;charset=utf8');
  }

  $c->response->body($tf->content);

  return 1;
}

=head1 NAME

Catalyst::View::TextForge - Text::Forge View Class

=head1 SYNOPSIS

    # use the helper
    script/create.pl view TextForge TextForge

    # lib/MyApp/View/TextForge.pm
    package MyApp::View::TextForge;

    use base qw/ Catalyst::View::TextForge /;

    # Set search path for templates (default: $c->config->{root})
    # __PACKAGE__->config->{root} = '/path/to/template/root';
  
    # Set cache mode (default: 1); See Text::Forge for details 
    # __PACKAGE__->config->{cache} = 2;

    1;

=head1 DESCRIPTION

Use Text::Forge templates as Catalyst views.

Text::Forge templates are very similar to ERB/ASP/PHP in syntax.
See the Text::Forge module for details.

Templates are passed two parameters, the stash and the Catalyst object itself.

Example template:

  <% my $s = shift; # now contains $c->stash %>
  <h1>Hello, <%= $s->{name} %><h1>
  <p>
    The current time is <%= scalar localtime %>.
  </p>

The catalyst object can also be obtained through $forge->catalyst()
from any template.

=head1 SEE ALSO

L<Catalyst>, L<Text::Forge>

=head1 AUTHOR

Maurice Aubrey C<maurice@cpan.org>

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
