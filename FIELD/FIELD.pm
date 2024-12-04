# FIELD.pm

=pod

=head1 NAME
VOTABLE::FIELD - VOTABLE FIELD XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the FIELD element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: FIELD.pm,v 1.1.1.6 2002/05/14 17:40:43 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: FIELD.pm,v $
# Revision 1.1.1.6  2002/05/14  17:40:43  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.5  2002/05/14  17:12:50  elwinter
# Fixed nextNext bug.
#
# Revision 1.1.1.4  2002/05/13  18:17:34  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  14:53:52  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::FIELD;

# Specify the minimum acceptable Perl version.
use 5.006;

# Turn on strict syntax checking.
use strict;

# Use enhanced diagnostic messages.
use diagnostics;

# Use enhanced warnings.
use warnings;

#******************************************************************************

# Set up the inheritance mechanism.
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
my($TAG_NAME) = 'FIELD';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'arraysize', 'datatype', 'name',
			      'precision', 'ref', 'type', 'ucd', 'unit',
			      'width');

# List of valid values for the 'datatype' attribute.
my(@valid_datatypes) = ('bit', 'boolean', 'char', 'double', 'doubleComplex',
			'float', 'floatComplex', 'int', 'long', 'short',
			'unicodeChar', 'unsignedByte');

# List of valid values for the 'type' attribute.
my(@valid_types) = ('hidden', 'no_query', 'trigger');

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
    my($this, $name) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('name', $name);
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
    return($this->get_precision);
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

    # Reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the current
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

    # If this object already has a DESCRIPTION element, remove the
    # DESCRIPTION element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {
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
	return(@{$this->{'VALUES'}});
    } else {
	return(());
    }
}

sub set_values()
{

    # Save arguments.
    my($this, @votable_values) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the current
    # VOTABLE::VALUES object.
    my($xmldom_element_values);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Current XML::DOM::Element.
    my($xmldom_element);

    # Current VOTABLE::VALUES.
    my($votable_values);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'VALUES'} = [@votable_values];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If this object already has any VALUES elements, remove the
    # VALUES elements.
    if (@xmldom_elements =
 	$xmldom_element_this->getElementsByTagName('VALUES', 0)) {
 	foreach $xmldom_element (@xmldom_elements) {
 	    $xmldom_element_this->removeChild($xmldom_element);
 	}
    }

    # Attach the new objects to the owner document for this
    # object. THIS IS IMPORTANT!
    foreach $votable_values (@votable_values) {
	$xmldom_element_values = $votable_values->{'XML::DOM::Element'};
	$xmldom_element_values->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # VALUES elements as the first child elements of this object after
    # any DESCRIPTION. Otherwise, just add the VALUES elements as the
    # first children.
    if ($xmldom_element_this->hasChildNodes) {
 	if (@xmldom_elements =
 	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

 	    # If this DESCRIPTION element is not the last child,
 	    # insert the VALUES elements right after it. Otherwise,
 	    # append the VALUES elements.
 	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
 		foreach $votable_values (@votable_values) {
 		    $xmldom_element_values =
			$votable_values->{'XML::DOM::Element'};
 		    $xmldom_element_this->
 			insertBefore($xmldom_element_values,
 				     $xmldom_elements[0]->getNextSibling);
 		}
	    } else {
 		foreach $votable_values (@votable_values) {
 		    $xmldom_element_values =
 			$votable_values->{'XML::DOM::Element'};
 		    $xmldom_element_this->appendChild($xmldom_element_values);
 		}
	    }

	} else {

 	    # No DESCRIPTION element found, so insert the VALUES
 	    # elements as the first children.
 	    foreach $votable_values (@votable_values) {
 		$xmldom_element_values =
 		    $votable_values->{'XML::DOM::Element'};
 		$xmldom_element_this->
 		    insertBefore($xmldom_element_values,
 				 $xmldom_element_this->getFirstChild);
 	    }

 	}

    } else {

 	# No existing children, so these VALUES becomes the first
 	# children.
 	foreach $votable_values (@votable_values) {
 	    $xmldom_element_values = $votable_values->{'XML::DOM::Element'};
 	    $xmldom_element_this->appendChild($xmldom_element_values);
 	}

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

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the current
    # VOTABLE::LINK object.
    my($votable_link);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Current XML::DOM::Element.
    my($xmldom_element);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::LINK object.
    my($xmldom_element_link);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'LINK'} = [@votable_link];

    #--------------------------------------------------------------------------

    # Link the VOTABLE::PARAM and the VOTABLE::LINK at the XML::DOM
    # level.

    # Get the XML::DOM::Element for this PARAM.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any LINK elements exist for the this object, delete them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('LINK', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $xmldom_element_this->removeChild($xmldom_element);
	}
    }

    # Attach the new objects to the owner document for this
    # object. THIS IS IMPORTANT!
    foreach $votable_link (@votable_link) {
 	$xmldom_element_link = $votable_link->{'XML::DOM::Element'};
 	$xmldom_element_link->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # Append the LINKs to this object.
    foreach $votable_link (@votable_link) {
 	$xmldom_element_link = $votable_link->{'XML::DOM::Element'};
 	$xmldom_element_this->appendChild($xmldom_element_link);
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

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to new VOTABLE::DESCRIPTION object.
    my($votable_description);

    # Reference to new VOTABLE::VALUES object array.
    my(@votable_values);

    # Reference to new VOTABLE::LINK object array.
    my(@votable_link);

    # Temporary array of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # DESCRIPTION

    # Get a list of new DESCRIPTION elements. There should be at most
    # 1.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {
 	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
 	$this->set_description($votable_description);
    }

    #--------------------------------------------------------------------------

    # VALUES

    # Get a list of new VALUES elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('VALUES', 0)) {
 	foreach $xmldom_element (@xmldom_elements) {
 	    push(@votable_values, new VOTABLE::VALUES $xmldom_element);
 	}
 	$this->set_values((@votable_values));
    }

    #--------------------------------------------------------------------------

    # LINK

    # Get a list of new LINK elements.
    if (@xmldom_elements =
 	$xmldom_element_this->getElementsByTagName('LINK', 0)) {
 	foreach $xmldom_element (@xmldom_elements) {
 	    push(@votable_link, new VOTABLE::LINK $xmldom_element);
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
