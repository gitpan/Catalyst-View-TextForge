package Catalyst::View::TextForge;

use strict;
use base qw/ Catalyst::View /;

our $VERSION = '0.01';

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
  eval { $tf->run($path, %{ $c->stash }) };
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

    # __PACKAGE__->config->{root} = '/path/to/template/root';
    # Defaults to $catalyst->config->{root}

    1;

=head1 DESCRIPTION

Use Text::Forge templates as Catalyst views.

Text::Forge templates are very similar to ERB/ASP/PHP in syntax.
See the Text::Forge module for details.

The contents of the Catalyst stash are passed into the template through @_.
Example template:

  <% my %args = @_ %>
  <h1>Hello, <%= $args{name} %><h1>
  <p>
    The current time is <%= scalar localtime %>.
  </p>

=head1 SEE ALSO

L<Catalyst>, L<Text::Forge>

=head1 AUTHOR

Maurice Aubrey C<maurice@cpan.org>

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
