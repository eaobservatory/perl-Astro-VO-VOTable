# DATA.pm

=pod

=head1 NAME
VOTABLE::DATA - VOTABLE DATA XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the DATA element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: DATA.pm,v 1.1.1.5 2002/05/14 11:48:19 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: DATA.pm,v $
# Revision 1.1.1.5  2002/05/14  11:48:19  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/06  17:28:56  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  14:29:13  elwinter
# Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::DATA;

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
our $VERSION = '0.01';

#******************************************************************************

# Specify external modules to use.

# Standard modules.
use Carp;
use English;
use XML::DOM;

# Third-party modules.

# Project modules.
use VOTABLE::BINARY;
use VOTABLE::FITS;
use VOTABLE::TABLEDATA;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'DATA';

# List of valid attributes for this element.
my(@valid_attribute_names) = ();

#******************************************************************************

# Class variables.

# This object is used to access the factory methods in the
# XML::DOM::Document class.
my($xmldom_factory_document) = new XML::DOM::Document;

#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# new()

# This is the main constructor for the class.

# The first argument ($class) always contains the name of the class to
# bless the new object into. This will usually be the name of the
# current class, unless this constructor is called for an object that
# inherits from the current class.

# All remaining arguments are stored in the @options array. The first
# additional argument, if it exists, contains a reference to an
# existing XML::DOM::Element object to use for the new object. Any
# additional items in the @options array are assumed to be keyword =>
# value pairs to use to initialize the attributes of the new object.

# Note that if you want to specify attribute values to the
# constructor, but do not want to specify a string or object reference
# to use, you must pass an empty string or undef as the first
# additional argument.

sub new()
{

    # Save arguments.
    # $class is the class name for the new object.
    # @options contains all of the remaining options used when the
    # constructor is invoked.
    my($class, @options) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for the new object.
    my($xmldom_element_this);

    # Hash containing keyword-value pairs to initialize attributes.
    my(%attributes);

    # Name of current element tag.
    my($tag_name);

    # Current attribute name and value.
    my($attribute_name, $attribute_value);

    # Reference to new object.
    my($this);

    # XML::DOM text node object for the content.
    my($xmldom_textnode);

    # Code string for eval.
    my($set_attribute);

    #--------------------------------------------------------------------------

    # Process the options.
    if (@options) {
	($xmldom_element_this, %attributes) = @options;
    }

    # Make sure the specified element (if any) is the correct type.
    if ($xmldom_element_this) {
	$tag_name = $xmldom_element_this->getTagName;
	if ($tag_name ne $TAG_NAME) {
	    carp("Invalid $TAG_NAME tag name: $tag_name!");
	    return(undef);
	}
    }

    # Make sure only valid attributes were specified.
    foreach $attribute_name (keys(%attributes)) {
	if (not grep(/$attribute_name/, @valid_attribute_names)) {
	    carp("Invalid $TAG_NAME attribute name: $attribute_name!");
	    return(undef);
	}
    }

    #--------------------------------------------------------------------------

    # Create the object as an empty hash.
    $this = {};

    # Bless the object.
    bless $this, $class;

    # Fill in the object.
    if ($xmldom_element_this) {

	# Save the specified XML::DOM::Element.

    } else {

	# Create a new XML::DOM::Element object.
	$xmldom_element_this =
	    $xmldom_factory_document->createElement($TAG_NAME);

    }

    # Save the new XML::DOM::Element.
    $this->{'XML::DOM::Element'} = $xmldom_element_this;

    # Process any specified attributes. This code assumes that the
    # name of each attribute can be directly mapped to a subroutine
    # name.
    while (($attribute_name, $attribute_value) = each(%attributes)) {
	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";
	eval($set_attribute);
	if ($EVAL_ERROR) {
	    carp("Error evaluating $TAG_NAME '$set_attribute': $EVAL_ERROR!");
	    return(undef);
	}
    }

    # Construct the VOTABLE object from the XML::DOM object.
    if (not $this->_build_from_XMLDOM) {
	carp('Unable to build $TAG_NAME from XML::DOM object!');
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Attribute accessor methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Element accessor methods.

# These methods assume they are called for a valid VOTABLE
# object. Therefore, no error checking is done on the object
# internals.

# For each element get_xxx() method, check to see if the element(s)
# exists. If so, return a reference to the VOTABLE object for the
# element (or a list of VOTABLE object references for multiple
# elements). Note that these methods use exists() to check for the
# element(s), to avoid creation on non-existence (which is what
# defined() would do if we used it instead of exists()). If the child
# is not found, return undef. If an error occurs, carp() a message and
# return undef.

# For each set_xxx() method, check to see if the element(s) currently
# exist. If so, remove them before attaching the new elements. Note
# that the set_xxx() methods must maintain the element order specified
# in the DTD. The current object (always referred to as $this) and its
# children must be linked at two levels - the VOTABLE level, and the
# XML::DOM level. Linking at the VOTABLE level is easy, since links
# are unidirectional, from parent to child. At the XML::DOM level,
# many more steps must be taken to establish the links. Return the
# supplied argument, using the matching get_xxx() method, to ensure
# success. Otherwise, carp() and error message and return undef.

# These methods follow the standard naming convention that variables
# referring to VOTABLE objects have a 'votable_' prefix, and those
# referring to XML::DOM objects have a 'xmldom_' prefix.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

sub get_binary()
{
    my($this) = @_;
    if (exists($this->{'BINARY'})) {
	return($this->{'BINARY'});
    } else {
	return(undef);
    }
}

sub set_binary()
{

    # Save arguments.
    my($this, $votable_binary) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the new
    # VOTABLE::BINARY object.
    my($xmldom_element_binary);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the elements at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'BINARY'} = $votable_binary;

    #--------------------------------------------------------------------------

    # Now link the elements at the XML::DOM level. This is
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new BINARY element.
    $xmldom_element_binary = $votable_binary->{'XML::DOM::Element'};
    if (not $xmldom_element_binary) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this object currently has any BINARY, FITS, or TABLEDATA
    # elements among its children, remove them. Note that it should
    # have only one of any of them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FITS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the BINARY element to this element owner
    # document. THIS IS IMPORTANT!
    $xmldom_element_binary->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the BINARY element as the first child node of the DATA
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_binary,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_binary);
    }

    # Return the new element.
    return($votable_binary);

}

sub get_fits()
{
    my($this) = @_;
    if (exists($this->{'FITS'})) {
	return($this->{'FITS'});
    } else {
	return(undef);
    }
}

sub set_fits()
{

    # Save arguments.
    my($this, $votable_fits) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the new
    # VOTABLE::FITS object.
    my($xmldom_element_fits);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the elements at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'FITS'} = $votable_fits;

    #--------------------------------------------------------------------------

    # Now link the elements at the XML::DOM level. This is
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new FITS element.
    $xmldom_element_fits = $votable_fits->{'XML::DOM::Element'};
    if (not $xmldom_element_fits) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this object currently has any BINARY, FITS, or TABLEDATA
    # elements among its children, remove them. Note that it should
    # have only one of any of them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FITS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the FITS element to this element owner
    # document. THIS IS IMPORTANT!
    $xmldom_element_fits->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the FITS element as the first child node of the DATA
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_fits,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_fits);
    }

    # Return the new element.
    return($votable_fits);

}

sub get_tabledata()
{
    my($this) = @_;
    if (exists($this->{'TABLEDATA'})) {
	return($this->{'TABLEDATA'});
    } else {
	return(undef);
    }
}

sub set_tabledata()
{

    # Save arguments.
    my($this, $votable_tabledata) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the new
    # VOTABLE::TABLEDATA object.
    my($xmldom_element_tabledata);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the elements at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'TABLEDATA'} = $votable_tabledata;

    #--------------------------------------------------------------------------

    # Now link the elements at the XML::DOM level. This is
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new TABLEDATA element.
    $xmldom_element_tabledata = $votable_tabledata->{'XML::DOM::Element'};
    if (not $xmldom_element_tabledata) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this object currently has any BINARY, FITS, or TABLEDATA
    # elements among its children, remove them. Note that it should
    # have only one of any of them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FITS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the TABLEDATA element to this element owner
    # document. THIS IS IMPORTANT!
    $xmldom_element_tabledata->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the TABLEDATA element as the first child node of the DATA
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_tabledata,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_tabledata);
    }

    # Return the new element.
    return($votable_tabledata);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# PCDATA content accessor methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Internal methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

sub _build_from_XMLDOM()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for current VOTABLE object.
    my($xmldom_element_this);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New elements to add.
    my($votable_binary, $votable_fits, $votable_tabledata);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # The DATA element can contain a BINARY element, OR a FITS
    # element, OR a TABLEDATA element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {

	# Make sure only one element was found.
	if (@xmldom_elements > 1) {
	    carp('Multiple BINARY elements!');
	    return(0);
	}

	# Create a new VOTABLE object for this element.
	$votable_binary = new VOTABLE::BINARY $xmldom_elements[0];
	if (not $votable_binary) {
	    carp('Unable to create VOTABLE::BINARY object!');
	    return(0);
	}
	$this->set_binary($votable_binary);

    } elsif (@xmldom_elements =
	     $xmldom_element_this->getElementsByTagName('FITS', 0)) {

	# Make sure only one element was found.
	if (@xmldom_elements > 1) {
	    carp('Multiple FITS elements!');
	    return(0);
	}

	# Create a new VOTABLE object for this element.
	$votable_fits = new VOTABLE::FITS $xmldom_elements[0];
	if (not $votable_fits) {
	    carp('Unable to create VOTABLE::FITS object!');
	    return(0);
	}
	$this->set_fits($votable_fits);

    } elsif (@xmldom_elements =
	     $xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {

	# Make sure only one element was found.
	if (@xmldom_elements > 1) {
	    carp('Multiple TABLEDATA elements!');
	    return(0);
	}

	# Create a new VOTABLE object for this element.
	$votable_tabledata = new VOTABLE::TABLEDATA $xmldom_elements[0];
	if (not $votable_tabledata) {
	    carp('Unable to create VOTABLE::TABLEDATA object!');
	    return(0);
	}
	$this->set_tabledata($votable_tabledata);

    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);
}

#******************************************************************************
1;
__END__
