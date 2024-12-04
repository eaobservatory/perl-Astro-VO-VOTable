# VOTABLE.pm

=pod

=head1 NAME
VOTABLE - Master VOTABLE XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class is the top-level class in the VOTABLE hierarchy.

=head1 WARNINGS

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: VOTABLE.pm,v 1.1.1.2 2002/04/28 19:52:37 elwinter Exp elwinter $

=cut

#******************************************************************************

# Revision history

# $Log: VOTABLE.pm,v $
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
require Exporter;
our @ISA = qw(Exporter);

# Sets of exported items.
our %EXPORT_TAGS = ('all' => [qw()]);

# Items the user may explicitly import.
our @EXPORT_OK = (@{$EXPORT_TAGS{'all'}});

# Automatically exported items.
our @EXPORT = qw();

# Module version.
our $VERSION = '0.01';

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
