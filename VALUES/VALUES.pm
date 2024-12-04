# VALUES.pm

=pod

=head1 NAME
VOTABLE::VALUES - VOTABLE VALUES XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the VALUES element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: VALUES.pm,v 1.1.1.9 2002/05/14 17:44:35 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: VALUES.pm,v $
# Revision 1.1.1.9  2002/05/14  17:44:35  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.8  2002/05/14  17:15:18  elwinter
# Fixed nextNext.
#
# Revision 1.1.1.7  2002/05/09  14:36:52  elwinter
# Fixed code in _build_from_XMLDOM().
#
# Revision 1.1.1.6  2002/05/08  13:01:08  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:34:11  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/06  17:31:54  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  19:40:18  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::VALUES;

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
use VOTABLE::MAX;
use VOTABLE::MIN;
use VOTABLE::OPTION;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'VALUES';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'invalid', 'null', 'type');

# List of valid values for the 'invalid' attribute.
my(@valid_invalids) = ('no', 'yes');

# List of valid values for the 'type' attribute.
my(@valid_types) = ('actual', 'legal');

#******************************************************************************

# Class variables.

# This object is used to access the factory methods in the
# XML::DOM::Document class. Assume it does not fail (for now).
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
# constructor, but do not want to specify a XML::DOM::Element to use,
# you must pass undef as the first additional argument.

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

sub get_ID()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('ID'));
}

sub set_ID()
{
    my($this, $id) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('ID', $id);
    return($this->get_ID);
}

sub get_invalid()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('invalid'));
}

sub set_invalid()
{
    my($this, $invalid) = @_;
    if (not grep(/$invalid/, @valid_invalids)) {
	carp("Invalid $TAG_NAME attribute value: $invalid!");
	return(undef);
    }
    $this->{'XML::DOM::Element'}->setAttribute('invalid', $invalid);
    return($this->get_invalid);
}

sub get_null()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('null'));
}

sub set_null()
{
    my($this, $null) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('null', $null);
    return($this->get_null);
}

sub get_type()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('type'));
}

sub set_type()
{
    my($this, $type) = @_;
    if (not grep(/$type/, @valid_types)) {
	carp("Invalid $TAG_NAME attribute value: $type!");
	return(undef);
    }
    $this->{'XML::DOM::Element'}->setAttribute('type', $type);
    return($this->get_type);
}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Element accessor methods.

# These methods assume they are called for a valid VOTABLE::VALUES
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

# get_max()

# Return a reference to the VOTABLE::MAX child of this
# VOTABLE::VALUES, or undef if no VOTABLE::MAX child exists.

sub get_max()
{
    my($this) = @_;
    if (exists($this->{'MAX'})) {
	return($this->{'MAX'});
    } else {
	return(undef);
    }
}

#------------------------------------------------------------------------------

# set_max()

# Set the MAX child of the VALUES to the specified value. Return a
# reference to the MAX child, or undef if an error occurs.

sub set_max()
{

    # Save arguments.
    # $this is a reference to the current object.
    # $votable_max is a reference to the VOTABLE::MAX object to add to
    # the current object.
    my($this, $votable_max) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::VALUES.
    my($xmldom_element_this);

    # Reference to XML::DOM::Element object for the new VOTABLE::MAX
    # object.
    my($xmldom_element_max);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Make sure a valid VOTABLE::MAX was supplied.
    if (not $votable_max) {
	carp('Undefined VOTABLE::MAX!');
	return(undef);
    }
    if (ref($votable_max) ne 'VOTABLE::MAX') {
	carp('Not a VOTABLE::MAX!');
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Link the VOTABLE::VALUES and the VOTABLE::MAX at the VOTABLE
    # level.
    $this->{'MAX'} = $votable_max;

    #--------------------------------------------------------------------------

    # Link the VOTABLE::VALUES and the VOTABLE::MAX at the XML::DOM
    # level.

    # Get the XML::DOM::Element for this VALUES.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new MAX.
    $xmldom_element_max = $votable_max->{'XML::DOM::Element'};
    if (not $xmldom_element_max) {
	carp('Unable to find XML::DOM::Element for VOTABLE::MAX!');
	return(undef);
    }

    # Delete any existing MAX.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('MAX', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::MAX to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::VALUES.
    $xmldom_element_max->setOwnerDocument($xmldom_element_this->
					  getOwnerDocument);

    # If any children exist for this VOTABLE::VALUES, insert the new
    # MAX as the first child _after_ any existing MIN. Otherwise, just
    # add the MAX as the first child.
    if ($xmldom_element_this->hasChildNodes) {

	# Check to see if there are any MIN elements.
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('MIN', 0)) {

	    # If this MIN element is not the last child, insert the
	    # MAX element right after it. Otherwise, append the MAX
	    # element.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		$xmldom_element_this->
		    insertBefore($xmldom_element_max,
				 $xmldom_elements[0]->getNextSibling);
	    } else {
		$xmldom_element_this->appendChild($xmldom_element_max);
	    }

	} else {

	    # No MIN element found, so insert the MAX element as the
	    # first child.
	    $xmldom_element_this->
		insertBefore($xmldom_element_max,
			     $xmldom_element_this->getFirstChild);

	}

    } else {

	# No existing children, so this MAX becomes the first child.
	$xmldom_element_this->appendChild($xmldom_element_max);

    }

    # Return the new object.
    return($this->get_max);

}

#------------------------------------------------------------------------------

# get_min()

# Return a reference to the VOTABLE::MIN child of this
# VOTABLE::VALUES, or undef if no VOTABLE::MIN child exists.

sub get_min()
{
    my($this) = @_;
    if (exists($this->{'MIN'})) {
	return($this->{'MIN'});
    } else {
	return(undef);
    }
}

sub set_min()
{

    # Save arguments.
    # $this is a reference to the current object.
    # $votable_min is a reference to the VOTABLE::MIN object to add to
    # the current object.
    my($this, $votable_min) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::VALUES.
    my($xmldom_element_this);

    # Reference to XML::DOM::Element object for the new VOTABLE::MIN
    # object.
    my($xmldom_element_min);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Make sure a valid VOTABLE::MIN was supplied.
    if (not $votable_min) {
	carp('Undefined VOTABLE::MIN!');
	return(undef);
    }
    if (ref($votable_min) ne 'VOTABLE::MIN') {
	carp('Not a VOTABLE::MIN!');
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Link the VOTABLE::VALUES and the VOTABLE::MIN at the VOTABLE
    # level.
    $this->{'MIN'} = $votable_min;

    #--------------------------------------------------------------------------

    # Link the VOTABLE::VALUES and the VOTABLE::MIN at the XML::DOM
    # level.

    # Get the XML::DOM::Element for this VALUES.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new MIN.
    $xmldom_element_min = $votable_min->{'XML::DOM::Element'};
    if (not $xmldom_element_min) {
	carp('Unable to find XML::DOM::Element for VOTABLE::MIN!');
	return(undef);
    }

    # Delete any existing MIN.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('MIN', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::MIN to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::VALUES.
    $xmldom_element_min->setOwnerDocument($xmldom_element_this->
					  getOwnerDocument);

    # If any children exist for this VOTABLE::VALUES, insert the new
    # MIN as the first child. Otherwise, just add the MIN as the first
    # child.
    if ($xmldom_element_this->hasChildNodes) {

	# Insert MIN as the first child.
	$xmldom_element_this->
	    insertBefore($xmldom_element_min,
			 $xmldom_element_this->getFirstChild);

    } else {

	# No existing children, so this MIN becomes the first child.
	$xmldom_element_this->appendChild($xmldom_element_min);

    }

    # Return the new object.
    return($this->get_min);

}

#------------------------------------------------------------------------------

# get_option()

# Return a list of references to the VOTABLE::OPTION children of this
# VOTABLE::VALUES, or undef if no VOTABLE::OPTION child exists.

sub get_option()
{
    my($this) = @_;
    if (exists($this->{'OPTION'})) {
	return(@{$this->{'OPTION'}});
    } else {
	return(());
    }
}

#------------------------------------------------------------------------------

# set_option()

# Set the OPTION children of the VALUES to the specified
# values. Return a list of the OPTION children, or undef if an error
# occurs.

sub set_option()
{

    # Save arguments.
    # $this is a reference to the current object.
    # @votable_option is a list of references to the VOTABLE::OPTIONs
    # to add to the current VALUES.
    my($this, @votable_option) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::VALUES.
    my($xmldom_element_this);

    # Temporary reference to the XML::DOM::Document object for this
    # object.
    my($xmldom_document);

    # Reference to a single new VOTABLE::OPTION.
    my($votable_option);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::OPTION object.
    my($xmldom_element_option);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Make sure a valid list of VOTABLE::OPTIONs was supplied.
    if (not @votable_option) {
	carp('Empty VOTABLE::OPTION list!');
	return(undef);
    }
    foreach $votable_option (@votable_option) {
	if (not $votable_option) {
	    carp('Undefined VOTABLE::OPTION!');
	    return(undef);
	}
	if (ref($votable_option) ne 'VOTABLE::OPTION') {
	    carp('Not a VOTABLE::OPTION!');
	    return(undef);
	}
    }

    #--------------------------------------------------------------------------

    # Link the VOTABLE::VALUES and the VOTABLE::OPTIONs at the VOTABLE
    # level.
    $this->{'OPTION'} = [@votable_option];

    #--------------------------------------------------------------------------

    # Link the VOTABLE::VALUES and the VOTABLE::OPTION at the XML::DOM
    # level.

    # Get the XML::DOM::Element for this VALUES.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the owner XML::DOM::Document object for this object.
    $xmldom_document = $xmldom_element_this->getOwnerDocument;

    # If any OPTION elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('OPTION', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::OPTION to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::VALUES.
    for ($i = 0; $i <= $#votable_option; $i++) {
	$xmldom_element_option = $votable_option[$i]->{'XML::DOM::Element'};
	$xmldom_element_option->setOwnerDocument($xmldom_document);
    }

    # If any children exist for this VOTABLE::VALUES, insert the new
    # OPTIONs as the first children _after_ any existing MAX. If there
    # are no MAX elements, check for MIN elements and handle them
    # similarly. Otherwise, just add the OPTIONs as the first
    # children.
    if ($xmldom_element_this->hasChildNodes) {

	# Check to see if there are any MAX elements, then MIN
	# elements.
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('MAX', 0)) {

	    # If this MAX element is not the last child, insert the
	    # OPTION elements right after it. Otherwise, append the
	    # OPTION elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_option (@votable_option) {
		    $xmldom_element_this->
			insertBefore($votable_option->{'XML::DOM::Element'},
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_option (@votable_option) {
		    $xmldom_element_this->
			appendChild($votable_option->{'XML::DOM::Element'});
		}
	    }

	} elsif (@xmldom_elements =
		 $xmldom_element_this->getElementsByTagName('MIN', 0)) {

	    # If this MIN element is not the last child, insert the
	    # OPTION elements right after it. Otherwise, append the
	    # OPTION elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_option (@votable_option) {
		    $xmldom_element_this->
			insertBefore($votable_option->{'XML::DOM::Element'},
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_option (@votable_option) {
		    $xmldom_element_this->
			appendChild($votable_option->{'XML::DOM::Element'});
		}
	    }

	} else {

	    # No MIN or MAX elements, so insert as the first children.
	    foreach $votable_option (@votable_option) {
		$xmldom_element_this->
		    insertBefore($votable_option->{'XML::DOM::Element'},
				 $xmldom_element_this->getFirstChild);
	    }

	}

    }


    # Return the new objects.
    return($this->get_option);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# PCDATA content accessor methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Internal methods.

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

    # Single XML::DOM::Element.
    my($xmldom_element);

    # References to new VOTABLE objects.
    my($votable_min);
    my($votable_max);
    my($votable_option);

    # Array of new VOTABLE::OPTIONs.
    my(@votable_option);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $this_xmldom_element = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # MIN

    # The current element should contain at most a single MIN element.
    @xmldom_elements =
	$this_xmldom_element->getElementsByTagName('MIN', 0);
    if (@xmldom_elements > 1) {
	carp('Multiple MIN elements!');
	return(undef);
    }
    if (@xmldom_elements) {
	$votable_min = new VOTABLE::MIN $xmldom_elements[0];
	$this->set_min($votable_min);
    }

    #--------------------------------------------------------------------------

    # MAX

    # The current element should contain at most a single MAX element.
    @xmldom_elements =
	$this_xmldom_element->getElementsByTagName('MAX', 0);
    if (@xmldom_elements > 1) {
	carp('Multiple MAX elements!');
	return(undef);
    }
    if (@xmldom_elements) {
	$votable_max = new VOTABLE::MAX $xmldom_elements[0];
	$this->set_max($votable_max);
    }

    #--------------------------------------------------------------------------

    # OPTION

    # Any number of OPTIONs are allowed.
    if (@xmldom_elements =
	$this_xmldom_element->getElementsByTagName('OPTION', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $votable_option = new VOTABLE::OPTION $xmldom_element;
	    push(@votable_option, $votable_option);
	}
	$this->set_option(@votable_option);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
