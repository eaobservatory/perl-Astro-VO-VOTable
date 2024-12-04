# OPTION.pm

=pod

=head1 NAME
VOTABLE::OPTION - VOTABLE OPTION XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the OPTION element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: OPTION.pm,v 1.1.1.6 2002/05/14 17:45:52 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: OPTION.pm,v $
# Revision 1.1.1.6  2002/05/14  17:45:52  elwinter
# Chanegd undef list returns to empty lists.
#
# Revision 1.1.1.5  2002/05/08  12:59:29  elwinter
# Fixed bug for string argument to constructor.
#
# Revision 1.1.1.4  2002/05/07  16:09:44  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/05/06  17:22:21  elwinter
# Overhauled.
#
# Revision 1.1.1.2  2002/04/28  15:19:46  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::OPTION;

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
my($TAG_NAME) = 'OPTION';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('name', 'value');

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
	carp('Unable to build $TAG_NAMEE object from XML::DOM object!');
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Attribute accessor methods.

# These methods assume they are called for a valid VOTABLE::INFO
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

sub get_name()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('name'));
}

sub set_name()
{
    my($this, $name) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('name', $name);
    return($this->get_name);
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

sub get_option()
{
    my($this) = @_;
    if (exists($this->{'OPTION'})) {
	return(@{$this->{'OPTION'}});
    } else {
	return(());
    }
}

sub set_option()
{

    # Save arguments.
    my($this, @votable_option) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Temporary reference to the XML::DOM::Document object for this
    # object.
    my($xmldom_document);

    # Reference to current VOTABLE::OPTION object.
    my($votable_option);

    # Temporary arrays of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the new elements to this VOTABLE object. This is easy,
    # since parent/child links in the VOTABLE class hierarchy are
    # one-way, from parent to child.
    $this->{'OPTION'} = [@votable_option];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the owner XML::DOM::Document object for this object.
    $xmldom_document = $xmldom_element_this->getOwnerDocument;

    # Attach each OPTION XML::DOM::Element to the
    # XML::DOM::Document. THIS IS IMPORTANT!
    foreach $votable_option (@votable_option) {
	$votable_option->{'XML::DOM::Element'}->
	    setOwnerDocument($xmldom_document);
    }

    # If any OPTION elements exist for the this object, delete them. Then
    # add each of the new OPTION elements.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('OPTION', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }
    foreach $votable_option (@votable_option) {
	$xmldom_element_this->
	    appendChild($votable_option->{'XML::DOM::Element'});
    }

    # Return the new objects.
    return($this->get_option);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# PCDATA accessor methods.

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
    my($this_xmldom_element);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New OPTION element, single and all.
    my($votable_option, @votable_option);

    # Temporary reference to current XML::DOM::Element.
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $this_xmldom_element = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # OPTION

    @xmldom_elements =
	$this_xmldom_element->getElementsByTagName('OPTION', 0);
    foreach $xmldom_element (@xmldom_elements) {
	$votable_option = new VOTABLE::OPTION $xmldom_element;
	push(@votable_option, $votable_option);
    }
    $this->set_option(@votable_option);

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
__END__
