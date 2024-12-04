# TABLE.pm

=pod

=head1 NAME
VOTABLE::TABLE - VOTABLE TABLE XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the TABLE element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: TABLE.pm,v 1.1.1.7 2002/05/14 19:11:00 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: TABLE.pm,v $
# Revision 1.1.1.7  2002/05/14  19:11:00  elwinter
# Fixed multiple DATA bug.
#
# Revision 1.1.1.6  2002/05/14  17:38:56  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.5  2002/05/14  17:14:26  elwinter
# Fixed nextNext.
#
# Revision 1.1.1.4  2002/05/14  13:07:28  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  19:24:30  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::TABLE;

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
use VOTABLE::DATA;
use VOTABLE::DESCRIPTION;
use VOTABLE::FIELD;
use VOTABLE::LINK;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'TABLE';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'name', 'ref');

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
    $this->{'XML::DOM::Element'}->getAttribute('ID');
}

sub set_ID()
{
    my($this, $id) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('ID', $id);
    return($this->get_ID);
}

sub get_name()
{
    my($this) = @_;
    $this->{'XML::DOM::Element'}->getAttribute('name');
}

sub set_name()
{
    my($this, $name) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('name', $name);
    return($this->get_name);
}

sub get_ref()
{
    my($this) = @_;
    $this->{'XML::DOM::Element'}->getAttribute('ref');
}

sub set_ref()
{
    my($this, $ref) = @_;
    $this->{'XML::DOM::Element'}->setAttribute('ref', $ref);
    return($this->get_ref);
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
    # add to this object.
    my($this, @votable_link) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to a single new VOTABLE::LINK.
    my($votable_link);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::LINK object.
    my($xmldom_element_link);

    # Temporary array of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'LINK'} = [@votable_link];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any LINK elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {
	    foreach $xmldom_element (@xmldom_elements) {
		$xmldom_element_this->removeChild($xmldom_element);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::LINKs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this object.
    foreach $votable_link (@votable_link) {
	$xmldom_element_link = $votable_link->{'XML::DOM::Element'};
	$xmldom_element_link->setOwnerDocument($xmldom_element_this
					       ->getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # LINK elements as the first child elements of this object after
    # any DESCRIPTION. Otherwise, just add the LINK elements as the
    # first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the LINK elements right after it. Otherwise,
	    # append the LINK elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the LINK
	    # elements as the first children.
	    foreach $votable_link (@votable_link) {
		$xmldom_element_link =
		    $votable_link->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_link,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the LINKS become the first
	# children.
	foreach $votable_link (@votable_link) {
	    $xmldom_element_link = $votable_link->{'XML::DOM::Element'}; 
	    $xmldom_element_this->appendChild($xmldom_element_link);
	}

    }

    # Return the new objects.
    return($this->get_link);

}

sub get_field()
{
    my($this) = @_;
    if (exists($this->{'FIELD'})) {
	return(@{$this->{'FIELD'}});
    } else {
	return(());
    }
}

sub set_field()
{

    # Save arguments.
    # $this is a reference to the current object.
    # @votable_field is a list of references to the VOTABLE::FIELDs to
    # add to this object.
    my($this, @votable_field) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to a single new VOTABLE::FIELD.
    my($votable_field);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::FIELD object.
    my($xmldom_element_field);

    # Temporary array of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Field the objects at the VOTABLE level.
    $this->{'FIELD'} = [@votable_field];

    #--------------------------------------------------------------------------

    # Field the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any FIELD elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('FIELD', 0)) {
	    foreach $xmldom_element (@xmldom_elements) {
		$xmldom_element_this->removeChild($xmldom_element);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::FIELDs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this object.
    foreach $votable_field (@votable_field) {
	$xmldom_element_field = $votable_field->{'XML::DOM::Element'};
	$xmldom_element_field->setOwnerDocument($xmldom_element_this
					       ->getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # FIELD elements as the first child elements of this object after
    # any LINK, then any DESCRIPTION. Otherwise, just add the FIELD
    # elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {

	    # If this LINK element is not the last child, insert the
	    # FIELD elements right after it. Otherwise, append the
	    # FIELD elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_field (@votable_field) {
		    $xmldom_element_field =
			$votable_field->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_field,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_field (@votable_field) {
		    $xmldom_element_field =
			$votable_field->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_field);
		}
	    }

	} elsif (@xmldom_elements =
		 $xmldom_element_this->
		 getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the FIELD elements right after it. Otherwise,
	    # append the FIELD elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_field (@votable_field) {
		    $xmldom_element_field =
			$votable_field->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_field,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_field (@votable_field) {
		    $xmldom_element_field =
			$votable_field->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_field);
		}
	    }

	} else {

	    # No DESCRIPTION or LINK element found, so insert the
	    # FIELD elements as the first children.
	    foreach $votable_field (@votable_field) {
		$xmldom_element_field =
		    $votable_field->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_field,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the FIELDS become the first
	# children.
	foreach $votable_field (@votable_field) {
	    $xmldom_element_field = $votable_field->{'XML::DOM::Element'}; 
	    $xmldom_element_this->appendChild($xmldom_element_field);
	}

    }

    # Return the new objects.
    return($this->get_field);

}

sub get_data()
{
    my($this) = @_;
    if (exists($this->{'DATA'})) {
	return($this->{'DATA'});
    } else {
	return(undef);
    }
}

sub set_data()
{

    # Save arguments.
    # $this is a reference to the current object.
    # @votable_data is a list of references to the VOTABLE::DATAs to
    # add to this object.
    my($this, $votable_data) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::DATA object.
    my($xmldom_element_data);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'DATA'} = $votable_data;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this PARAM.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the underlying XML::DOM::Element for this DATA.
    $xmldom_element_data = $votable_data->{'XML::DOM::Element'};

    # If any DATA elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DATA', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::DATA to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::TABLE.
    $xmldom_element_data->setOwnerDocument($xmldom_element_this->
					   getOwnerDocument);

    # Append the DATA to the TABLE.
    $xmldom_element_this->
	appendChild($votable_data->{'XML::DOM::Element'});

    # Return the new objects.
    return($this->get_data);

}

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

    # Reference to one and all VOTABLE::LINK objects.
    my($votable_link);
    my(@votable_link);

    # Reference to one and all VOTABLE::FIELD objects.
    my($votable_field);
    my(@votable_field);

    # Reference to one and all VOTABLE::DATA objects.
    my($votable_data);
    my(@votable_data);

    # Array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # DESCRIPTION

    # Get a list of all DESCRIPTION elements.
    if (@xmldom_elements = $xmldom_element_this->
	getElementsByTagName('DESCRIPTION', 0)) {
	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
	$this->set_description($votable_description);
    }

    #--------------------------------------------------------------------------

    # LINK

    # Get a list of all LINK elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('LINK', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_link = new VOTABLE::LINK $xmldom_elements[$i];
	    push(@votable_link, $votable_link);
	}
	$this->set_link(@votable_link);
    }

    #--------------------------------------------------------------------------

    # FIELD

    # Get a list of all FIELD elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FIELD', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_field = new VOTABLE::FIELD $xmldom_elements[$i];
	    push(@votable_field, $votable_field);
	}
	$this->set_field(@votable_field);
    }

    #--------------------------------------------------------------------------

    # DATA

    # Get a list of all DATA elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DATA', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_data = new VOTABLE::DATA $xmldom_elements[$i];
	    push(@votable_data, $votable_data);
	}
	$this->set_data(@votable_data);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
__END__
