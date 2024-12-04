# MAX.pm

=pod

=head1 NAME
VOTABLE::MAX - VOTABLE MAX XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the MAX element from the VOTABLE DTD.

=head1 WARNINGS

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: MAX.pm,v 1.1.1.5 2002/05/07 13:21:03 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: MAX.pm,v $
# Revision 1.1.1.5  2002/05/07  13:21:03  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/03  15:05:04  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/05/01  16:34:04  elwinter
# Overhauled.
#
# Revision 1.1.1.2  2002/04/28  15:11:35  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::MAX;

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

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'MAX';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('inclusive', 'value');

# List of valid values for the 'type' attribute.
my(@valid_inclusives) = ('no', 'yes');

#******************************************************************************

# Class variables.

# This object is used to access the factory methods in the
# XML::DOM::Document class.
my($xmldom_factory_document) = new XML::DOM::Document;

#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# This is the main constructor for the class.

# The first argument ($class) always contains the name of the class to
# bless the new object into. This will usually be the name of the
# current class, unless this constructor is called for an object that
# inherits from the current class.

# All remaining arguments are stored in the @options array. The first
# additional argument, if it exists, contains either a string to use
# to initialize the PCDATA content of the new object, or a reference
# to an existing XML::DOM::Element object to use for the new
# object. Any additional items in the @options array are assumed to be
# keyword => value pairs to use to initialize the attributes of the
# new object.

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

    # String with initial text for element.
    my($str);

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
	if (ref($options[0]) eq 'XML::DOM::Element') {
	    ($xmldom_element_this, %attributes) = @options;
	} else {
	    ($str, %attributes) = @options;
	}
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

    } elsif ($str) {

	# Create a new XML::DOM::Element object.
	$xmldom_element_this =
	    $xmldom_factory_document->createElement($TAG_NAME);

	# Create a text node for the content.
	$xmldom_textnode = $xmldom_factory_document->createTextNode($str);

	# Add the text node to the element.
	$xmldom_element_this->appendChild($xmldom_textnode);

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

sub get_inclusive()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('inclusive'));
}

sub set_inclusive()
{
    my($this, $inclusive) = @_;
    if (not grep(/$inclusive/, @valid_inclusives)) {
	carp("Invalid $TAG_NAME attribute value: $inclusive!");
	return(undef);
    }
    $this->{'XML::DOM::Element'}->setAttribute('inclusive', $inclusive);
    return($this->get_inclusive);
}

sub get_value()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('value'));
}

sub set_value()
{
    my($this, $value) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('value', $value);
    return($this->get_value);
}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Element accessor methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# PCDATA content accessor methods.

# These accessors assume the use of a single text node to hold the
# PCDATA content of the element. The get() method simply returns the
# content of the text node, and the set() method creates the node if
# it needs to.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

sub get()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to XML::DOM text node containing the PCDATA.
    my($xmldom_textnode);

    #--------------------------------------------------------------------------

    # Fetch the underlying XML::DOM::Element object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If there are any child nodes, there should be only one, and it
    # should be a text node. If so, fetch the content of the text
    # node. Otherwise, not text has been defined for this element, so
    # return undef.
    if ($xmldom_element_this->hasChildNodes) {
 	$xmldom_textnode = $xmldom_element_this->getFirstChild;
 	return($xmldom_textnode->getData);
    } else {
 	return(undef);
    }

}

sub set()
{

    # Save arguments.
    my($this, $str) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to XML::DOM text node containing the PCDATA.
    my($xmldom_textnode);

    #--------------------------------------------------------------------------

    # Fetch the underlying XML::DOM::Element object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If the text node exists, use it. Otherwise, create a new
    # one. Note that this object should have at most one child node,
    # and it can only be a text node.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_textnode = $xmldom_element_this->getFirstChild;
	$xmldom_textnode->setData($str);
    } else {
	$xmldom_textnode = $xmldom_factory_document->createTextNode($str);
	$xmldom_element_this->appendChild($xmldom_textnode);
    }

    # Return the string.
    return($str);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Internal methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

sub _build_from_XMLDOM()
{
    return(1);
}

#******************************************************************************
1;
__END__
