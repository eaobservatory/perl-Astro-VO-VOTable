# PARAM.pm

=pod

=head1 NAME
VOTABLE::PARAM - VOTABLE PARAM XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the PARAM element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: PARAM.pm,v 1.1.1.7 2002/05/14 17:42:00 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: PARAM.pm,v $
# Revision 1.1.1.7  2002/05/14  17:42:00  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.6  2002/05/14  17:13:23  elwinter
# Fixed nextNext.
#
# Revision 1.1.1.5  2002/05/10  16:33:25  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/06  17:37:52  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  19:08:32  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::PARAM;

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
use VOTABLE::DESCRIPTION;
use VOTABLE::LINK;
use VOTABLE::VALUES;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'PARAM';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'arraysize', 'datatype', 'name',
			      'precision', 'ref', 'ucd', 'unit', 'value',
			      'width');

# List of valid values for the 'datatype' attribute.
my(@valid_datatypes) = ('bit', 'boolean', 'char', 'double', 'doubleComplex',
			'float', 'floatComplex', 'int', 'long', 'short',
			'unicodeChar', 'unsignedByte');

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
# value pairs to use to initialize the attributes of the element for
# the new object.

# Note that if you want to specify attribute values to the
# constructor, but do not want to specify an object reference to use,
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

    # Name of element tag.
    my($tag_name);

    # Current attribute name and value.
    my($attribute_name, $attribute_value);

    # Reference to new object.
    my($this);

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
	$xmldom_element_this = $xmldom_factory_document->
	    createElement($TAG_NAME);

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
	carp('Unable to build $TAG_NAME from XML::DOM!');
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the new object.
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

sub get_arraysize()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('arraysize'));
}

sub set_arraysize()
{
    my($this, $arraysize) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('arraysize', $arraysize);
    return($this->get_arraysize);
}

sub get_datatype()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('datatype'));
}

sub set_datatype()
{
    my($this, $datatype) = @_;
    if (not grep(/$datatype/, @valid_datatypes)) {
	carp("Invalid $TAG_NAME attribute value: $datatype!");
	return(undef);
    }
    $this->{'XML::DOM::Element'}->setAttribute('datatype', $datatype);
    return($this->get_datatype);
}

sub get_name()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('name'));
}

sub set_name()
{
    my($this, $namee) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('name', $namee);
    return($this->get_name);
}

sub get_precision()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('precision'));
}

sub set_precision()
{
    my($this, $precision) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('precision', $precision);
    return($precision);
}

sub get_ref()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('ref'));
}

sub set_ref()
{
    my($this, $ref) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('ref', $ref);
    return($this->get_ref);
}

sub get_ucd()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('ucd'));
}

sub set_ucd()
{
    my($this, $ucd) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('ucd', $ucd);
    return($this->get_ucd);
}

sub get_unit()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('unit'));
}

sub set_unit()
{
    my($this, $unit) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('unit', $unit);
    return($this->get_unit);
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

sub get_width()
{
    my($this) = @_;
    return($this->{'XML::DOM::Element'}->getAttribute('width'));
}

sub set_width()
{
    my($this, $width) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('width', $width);
    return($this->get_width);
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

sub get_description()
{
    my($this) = @_;
    if (exists($this->{'DESCRIPTION'})) {
	return($this->{'DESCRIPTION'});
    } else {
	return(undef);
    }
}

sub set_description()
{

    # Save arguments.
    my($this, $votable_description) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Document object for the current
    # VOTABLE::DESCRIPTION object.
    my($xmldom_element_description);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'DESCRIPTION'} = $votable_description;

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_description =
	$votable_description->{'XML::DOM::Element'};
    if (not $xmldom_element_description) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this PARAM element already has a DESCRIPTION element, remove
    # the DESCRIPTION element.
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0);
    if (@xmldom_elements) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the new object to the owner document for this
    # object. THIS IS IMPORTANT!
    $xmldom_element_description->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # If any child nodes exist for the this object, insert the new
    # DESCRIPTION element as the first child element of this
    # object. Otherwise, just add the DESCRIPTION element as the first
    # child.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_description,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_description);
    }

    # Return the new object.
    return($this->get_description);

}

sub get_values()
{
    my($this) = @_;
    if (exists($this->{'VALUES'})) {
	return($this->{'VALUES'});
    } else {
	return(undef);
    }
}

sub set_values()
{

    # Save arguments.
    my($this, $votable_values) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Document object for the current
    # VOTABLE::VALUES object.
    my($xmldom_element_values);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'VALUES'} = $votable_values;

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_values =
	$votable_values->{'XML::DOM::Element'};
    if (not $xmldom_element_values) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this PARAM element already has a VALUES element, remove the
    # VALUES element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('VALUES', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the new object to the owner document for this
    # object. THIS IS IMPORTANT!
    $xmldom_element_values->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # If any child nodes exist for the this object, insert the new
    # VALUES element as the first child element of this object after
    # any DESCRIPTION. Otherwise, just add the VALUES element as the
    # first child.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the VALUES element right after it. Otherwise,
	    # append the VALUES element.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		$xmldom_element_this->
		    insertBefore($xmldom_element_values,
				 $xmldom_elements[0]->getNextSibling);
	    } else {
		$xmldom_element_this->appendChild($xmldom_element_values);
	    }

	} else {

	    # No DESCRIPTION element found, so insert the VALUES
	    # element as the first child.
	    $xmldom_element_this->
		insertBefore($xmldom_element_values,
			     $xmldom_element_this->getFirstChild);

	}

    } else {

	# No existing children, so this VALUES becomes the first
	# child.
	$xmldom_element_this->appendChild($xmldom_element_values);

    }

    # Return the new object.
    return($this->get_values);

}

sub get_link()
{
    my($this) = @_;
    if (exists($this->{'LINK'})) {
	return(@{$this->{'LINK'}});
    } else {
	return(());
    }
}

sub set_link()
{

    # Save arguments.
    # $this is a reference to the current object.
    # @votable_link is a list of references to the VOTABLE::LINKs to
    # add to the current PARAM.
    my($this, @votable_link) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::PARAM.
    my($xmldom_element_this);

    # Temporary reference to the XML::DOM::Document object for this
    # object.
    my($xmldom_document);

    # Reference to a single new VOTABLE::LINK.
    my($votable_link);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::LINK object.
    my($xmldom_element_link);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Make sure a valid list of VOTABLE::LINKs was supplied.
    foreach $votable_link (@votable_link) {
	if (not $votable_link) {
	    carp('Undefined VOTABLE::LINK!');
	    return(undef);
	}
	if (ref($votable_link) ne 'VOTABLE::LINK') {
	    carp('Not a VOTABLE::LINK!');
	    return(undef);
	}
    }

    #--------------------------------------------------------------------------

    # Link the VOTABLE::PARAM and the VOTABLE::LINKs at the VOTABLE
    # level.
    $this->{'LINK'} = [@votable_link];

    #--------------------------------------------------------------------------

    # Link the VOTABLE::PARAM and the VOTABLE::LINK at the XML::DOM
    # level.

    # Get the XML::DOM::Element for this PARAM.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the owner XML::DOM::Document object for this object.
    $xmldom_document = $xmldom_element_this->getOwnerDocument;

    # If any LINK elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::LINKs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::PARAM.
    for ($i = 0; $i <= $#votable_link; $i++) {
	$xmldom_element_link = $votable_link[$i]->{'XML::DOM::Element'};
	$xmldom_element_link->setOwnerDocument($xmldom_document);
    }

    # Append the LINKs to the PARAM.
    foreach $votable_link (@votable_link) {
	$xmldom_element_this->
	    appendChild($votable_link->{'XML::DOM::Element'});
    }

    # Return the new objects.
    return($this->get_link);

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

    # Reference to the XML::DOM::Element object for the current
    # VOTABLE::PARAM object.
    my($xmldom_element_param);

    # Reference to XML::DOM::Document object for current
    # VOTABLE::Document object.
    my($xmldom_document);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Reference to new VOTABLE::DESCRIPTION object.
    my($votable_description);

    # Reference to new VOTABLE::VALUES object.
    my($votable_values);

    # Reference to new VOTABLE::LINK object, and all of them.
    my($votable_link);
    my(@votable_link);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this PARAM
    # element, and its owner document.
    $xmldom_element_param = $this->{'XML::DOM::Element'};
    $xmldom_document = $xmldom_element_param->getOwnerDocument;

    #--------------------------------------------------------------------------

    # DESCRIPTION

    # Get a list of all DESCRIPTION elements which are children of the
    # PARAM element. There should be at most 1.
    if (@xmldom_elements = $xmldom_element_param->
	getElementsByTagName('DESCRIPTION', 0)) {
	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
	$this->set_description($votable_description);
    }

    #--------------------------------------------------------------------------

    # VALUES

    # Get a list of all VALUES elements which are children of the
    # PARAM element. There should be at most 1.
    if (@xmldom_elements = $xmldom_element_param->
	getElementsByTagName('VALUES', 0)) {
	$votable_values = new VOTABLE::VALUES $xmldom_elements[0];
	$this->set_values($votable_values);
    }

    #--------------------------------------------------------------------------

    # LINK

    # Get a list of all LINK elements which are children of the PARAM
    # element.
    if (@xmldom_elements =
	$xmldom_element_param->getElementsByTagName('LINK', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_link = new VOTABLE::LINK $xmldom_elements[$i];
	    push(@votable_link, $votable_link);
	}
	$this->set_link(@votable_link);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
__END__
