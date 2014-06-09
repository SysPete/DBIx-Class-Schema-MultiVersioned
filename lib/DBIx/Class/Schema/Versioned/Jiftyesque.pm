package DBIx::Class::Schema::Versioned::Jiftyesque;

use 5.006;
use strict;
use warnings FATAL => 'all';

=head1 NAME

DBIx::Class::Schema::Versioned::Jiftyesque - The great new DBIx::Class::Schema::Versioned::Jiftyesque!

=head1 VERSION

Version 0.001

=cut

our $VERSION = '0.001';


=head1 SYNOPSIS

  package MyApp::Schema;

  use base 'DBIx::Class::Schema::Versioned::Jiftyesque';

  package MyApp::Schema::Result::Tree;

  __PACKAGE__->since( '0.002' );

  __PACKAGE__->table("trees");

  __PACKAGE__->add_columns(
      "height",
      { data_type => "numeric", size => [10, 2] },
      "age",
      { data_type => "integer", extra => { since => '0.004' } },
      "branches",
      { data_type => "integer", extra => { until => '0.003' } },
      ...
  );
  ...

=head1 AUTHOR

Peter Mottram (SysPete), C<< <peter at sysnix.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-dbix-class-schema-versioned-jiftyesque at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DBIx-Class-Schema-Versioned-Jiftyesque>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc DBIx::Class::Schema::Versioned::Jiftyesque


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=DBIx-Class-Schema-Versioned-Jiftyesque>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DBIx-Class-Schema-Versioned-Jiftyesque>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DBIx-Class-Schema-Versioned-Jiftyesque>

=item * Search CPAN

L<http://search.cpan.org/dist/DBIx-Class-Schema-Versioned-Jiftyesque/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Peter Mottram (SysPete).

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of DBIx::Class::Schema::Versioned::Jiftyesque