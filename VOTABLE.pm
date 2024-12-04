# VOTABLE.pm

=pod

=head1 NAME

VOTABLE - VOTABLE XML manipulation package

=head1 SYNOPSIS

C<use VOTABLE>;

=head1 DESCRIPTION

The C<VOTABLE::> class hierarchy forms a set of wrappers around the
X<XML::DOM> class hierarchy. When using the C<VOTABLE> classes, the
user does not need to worry about the implementation details of the
underlying XML technology (currently C<XML::DOM>, but subject to
change).

In general, the code consists of a C<VOTABLE> module/class for each
VOTABLE element defined in the VOTABLE DTD (version 1.0). This is VERY
alpha code. It provides a crude but essentially complete capability to
read, modify, and write VOTABLE documents. The code does its best to
maintain the internal integrity of the document so that adherence to
the DTD (or schema) is maintained.

The overall design of the VOTABLE objects is straightforward. Each XML
element in the VOTABLE DTD is represented by a class. Each element
class is a subclass of C<VOTABLE::Element> (this class). Within each
element class, there are attributes and child elements, along with
implementation-specific data, such as references to the underlying
C<XML::DOM> objects.

Attributes are manipulated using C<get_ATTNAME> and C<set_ATTNAME>
methods (accessors), where C<ATTNAME> is replaced by the name of the
attribute in question. The C<set> methods take a single argument (the
value to set the attribute to), and the C<get> methods take no
arguments. Since attributes can only take single values, all
C<set_ATTNAME> methods take single scalars as arguments, and
C<get_ATTNAME> methods return single scalars. All C<set_ATTNAME>
methods return the newly-set value on success, or C<undef> if an error
occurs.

Child elements have similar accessors, of the form C<get_ELNAME> and
C<set_ELNAME>, where C<ELNAME> is replaced by the name of the element
(more precisely, the name of the element I<tag>, such as C<TABLEDATA>
for a C<TABLEDATA> element). Note that these names, and the methods,
are case-sensitive. The type of arguments passed to and returned from
the element accessors is determined by the multiplicity of the child
elements (as defined by the VOTABLE DTD). Elements which can occur 0
or 1 times (those which are unquantified, or quantified with a '?' in
the DTD) are passed and returned as scalars, while elements which can
occur 1 or more times (those quantified with a '+' or '*' in the DTD)
are passed and returned as lists. Like C<set_ATTNAME> accessors,
C<set_ELNAME> accessors return the new value(s) on success. On
failure, scalar-returning methods return C<undef>, while
list-returning methods return an empty list.

The C<VOTABLE> class hierarchy is simple. The C<VOTABLE::Document>
class is used for objects representing entire XML documents, which are
composed of C<VOTABLE::ELEMENT_NAME> objects, where C<ELEMENT_NAME> is
replaced by the name of a valid VOTABLE element tag. There is a class
for each valid VOTABLE element. Classes are arranged in tiers, where
an element in a higher tier is composed exclusively of elements in
lower tiers. The current list of valid elements is:

=over 4

=item *

Tier 0: C<COOSYS>, C<DESCRIPTION>, C<INFO>, C<LINK>, C<MAX>, C<MIN>,
C<STREAM>, C<TD>

=item *

Tier 1: C<BINARY>, C<FITS>, C<OPTION>, C<TR>

=item *

Tier 2: C<TABLEDATA>, C<VALUES>

=item *

Tier 3: C<DATA>, C<FIELD>, C<PARAM>

=item *

Tier 4: C<DEFINITIONS>, C<TABLE>

=item *

Tier 5: C<RESOURCE>

=item *

Tier 6: C<Document>

=back

=head1 WARNINGS

=over 4

=item *

Alpha code. Caveat programmor.

=item *

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE::Element> I<always> has an underlying C<XML::DOM::Element>
object. When aberrant cases are encountered, an exception is raised
(using the C<Carp::croak> subroutine).

=item *

Similarly, this code assumes that C<XML::DOM> methods always
succeed. When aberrant cases are encountered, an exception is raised
(using the C<Carp::croak> subroutine).

=item *

Attribute and element names containing embedded hyphens ('-') use
accessors where the hyphen is mapped to an underscore ('_') in the
name of the accessor method. This is a necessity, since the hyphen is
not a valid name character in Perl.

=item *

External data is not yet supported, although the infrastructure has
been started (BINARY and FITS elements, and STREAMs).

=item *

No testing has been done with Perl prior to version 5.6.1.

=back

=head1 SEE ALSO

=over 4

=item * C<VOTABLE::Document>

=item * C<XML::DOM>

=back

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: VOTABLE.pm,v 1.1.1.5 2002/06/09 21:13:08 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: VOTABLE.pm,v $
# Revision 1.1.1.5  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.4  2002/05/21  14:07:09  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.3  2002/05/21  11:44:26  elwinter
# Updated documentation.
#
# Revision 1.1.1.2  2002/04/28  19:52:37  elwinter
# Converted to canonical form.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE;

# Specify the minimum acceptable Perl version.
use 5.006;

# Turn on strict syntax checking.
use strict;

# Use enhanced diagnostic messages.
use diagnostics;

# Use enhanced warnings.
use warnings;

#******************************************************************************

# Set up the inheritance mexhanism.
our @ISA = qw();

# Module version.
our $VERSION = '0.03';

#******************************************************************************

# Specify external modules to use.

# Standard modules.
use XML::DOM;

# Third-party modules.

# Project modules.

#******************************************************************************

# Class constants.

#******************************************************************************

# Class variables.

#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Accessor methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Internal methods.

#******************************************************************************
1;
__END__
