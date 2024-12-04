# FITS.pm

=pod

=head1 NAME
VOTABLE::FITS - VOTABLE FITS XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the FITS element from the VOTABLE DTD.

=head1 WARNINGS

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: FITS.pm,v 1.1.1.6 2002/05/07 15:36:41 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: FITS.pm,v $
# Revision 1.1.1.6  2002/05/07  15:36:41  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:16:51  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/01  18:13:24  elwinter
# Added accessors for STREAM element.
#
# Revision 1.1.1.3  2002/04/28  14:57:45  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::FITS;

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
use VOTABLE::STREAM;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'FITS';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('extnum');

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
	carp('Unable to build $TAG_NAME object from XML::DOM object!');
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Attribute accessor methods.

# These methods assume they are called for a valid VOTABLE
# object. Therefore, no error checking is done on the object
# internals.

# For each attribute get_xxx() method, simply return the result of the
# getAttribute() method for the corresponding attribute of the
# XML::DOM::Element object.

# For each attribute set_xxx() method, validate the new value if
# possible, then call the setAttribute() method for the
# XML::DOM::Element object. Return the new value with a call to the
# getAttribute() method.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

sub get_extnum()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('extnum'));
}

sub set_extnum()
{
    my($this, $extnum) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('extnum', $extnum);
    return($this->get_extnum);
}

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

sub get_stream()
{
    my($this) = @_;
    if (exists($this->{'STREAM'})) {
	return($this->{'STREAM'});
    } else {
	return(undef);
    }
}

sub set_stream()
{

    # Save arguments.
    # $this is a reference to the current object.
    # $votable_stream is a reference to the VOTABLE::STREAM to use for
    # the current VOTABLE::FITS.
    my($this, $votable_stream) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for the current
    # VOTABLE::FITS object.
    my($xmldom_element_fits);

    # Reference to the XML::DOM::Element object for the current
    # VOTABLE::STREAM object.
    my($xmldom_element_stream);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'STREAM'} = $votable_stream;

    #--------------------------------------------------------------------------

    # Now link the XML::DOM FITS element and the XML::DOM STREAM
    # element. This is complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this FITS element.
    $xmldom_element_fits = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new STREAM element.
    $xmldom_element_stream = $votable_stream->{'XML::DOM::Element'};
    if (not $xmldom_element_stream) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this FITS element already has a STREAM element, remove the
    # STREAM element.
    @xmldom_elements =
	$xmldom_element_fits->getElementsByTagName('STREAM', 0);
    if (@xmldom_elements) {
	$xmldom_element_fits->removeChild($xmldom_elements[0]);
    }

    # Attach the STREAM element to the FITS element owner
    # document. THIS IS IMPORTANT!
    $xmldom_element_stream->
	setOwnerDocument($xmldom_element_fits->getOwnerDocument);

    # Attach the STREAM element as the first child node of the FITS
    # element.
    if ($xmldom_element_fits->hasChildNodes) {
	$xmldom_element_fits->
	    insertBefore($xmldom_element_stream,
			 $xmldom_element_fits->getFirstChild);
    } else {
	$xmldom_element_fits->appendChild($xmldom_element_stream);
    }

    # Return the STREAM element.
    return($this->get_stream);

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

# Build the object from its XML::DOM equivalent.

sub _build_from_XMLDOM()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for current VOTABLE object.
    my($this_xmldom_element);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New STREAM element.
    my($votable_stream);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $this_xmldom_element = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # STREAM

    # The current element should contain at most a single STREAM
    # element.
    @xmldom_elements =
	$this_xmldom_element->getElementsByTagName('STREAM', 0);
    if (@xmldom_elements > 1) {
	carp('Multiple STREAM elements!');
	return(undef);
    }
    if (@xmldom_elements) {
	$votable_stream = new VOTABLE::STREAM $xmldom_elements[0];
	$this->set_stream($votable_stream);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
__END__
