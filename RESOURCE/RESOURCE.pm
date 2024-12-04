# RESOURCE.pm

=pod

=head1 NAME
VOTABLE::RESOURCE - VOTABLE RESOURCE XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the RESOURCE element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: RESOURCE.pm,v 1.1.1.9 2002/05/14 17:35:33 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: RESOURCE.pm,v $
# Revision 1.1.1.9  2002/05/14  17:35:33  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.8  2002/05/14  17:19:00  elwinter
# Fixed nextSibling.
#
# Revision 1.1.1.7  2002/05/14  17:09:02  elwinter
# Filled in _build_from_XMLDOM().
#
# Revision 1.1.1.6  2002/05/14  14:12:07  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:44:15  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/04/29  15:45:50  elwinter
# Added use of factory document.
#
# Revision 1.1.1.3  2002/04/28  14:04:49  elwinter
# Rearranged. Added code for constructor and accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::RESOURCE;

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
use VOTABLE::COOSYS;
use VOTABLE::DESCRIPTION;
use VOTABLE::INFO;
use VOTABLE::LINK;
use VOTABLE::PARAM;
use VOTABLE::TABLE;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'RESOURCE';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'name', 'type');

# List of valid values for the 'type' attribute.
my(@valid_types) = ('meta', 'results');

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

sub get_type()
{
    my($this) = @_;
    $this->{'XML::DOM::Element'}->getAttribute('type');
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

    # If this RESOURCE element already has a DESCRIPTION element, remove
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

sub get_info()
{
    my($this) = @_;
    if (exists($this->{'INFO'})) {
	return(@{$this->{'INFO'}});
    } else {
	return(());
    }
}

sub set_info()
{

    # Save arguments.
    my($this, @votable_info) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::INFO object and its underlying
    # XML::DOM::Element object.
    my($votable_info);
    my($xmldom_element_info);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'INFO'} = [@votable_info];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any INFO elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::INFOs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_info; $i++) {
	$xmldom_element_info = $votable_info[$i]->{'XML::DOM::Element'};
	$xmldom_element_info->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # INFO elements as the first child elements of this object after
    # any DESCRIPTION. Otherwise, just add the INFO elements as the
    # first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the INFO elements right after it. Otherwise,
	    # append the INFO elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info =
			$votable_info->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_info,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info =
			$votable_info->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_info);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the INFO
	    # elements as the first children.
	    foreach $votable_info (@votable_info) {
		$xmldom_element_info =
		    $votable_info->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_info,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these INFO becomes the first
	# children.
	foreach $votable_info (@votable_info) {
	    $xmldom_element_info =
		$votable_info->{'XML::DOM::Element'};
	    $xmldom_element_this->appendChild($xmldom_element_info);
	}

    }

    # Return the new object.
    return($this->get_info);

}

sub get_coosys()
{
    my($this) = @_;
    if (exists($this->{'COOSYS'})) {
	return(@{$this->{'COOSYS'}});
    } else {
	return(());
    }
}

sub set_coosys()
{

    # Save arguments.
    my($this, @votable_coosys) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::COOSYS object and its underlying
    # XML::DOM::Element object.
    my($votable_coosys);
    my($xmldom_element_coosys);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'COOSYS'} = [@votable_coosys];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any COOSYS elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::COOSYSs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_coosys; $i++) {
	$xmldom_element_coosys = $votable_coosys[$i]->{'XML::DOM::Element'};
	$xmldom_element_coosys->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # COOSYS elements as the first child elements of this object after
    # the last INFO, or any DESCRIPTION. Otherwise, just add the
    # COOSYS elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {

	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the COOSYS elements right after it. Otherwise, append
	    # the COOSYS elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_coosys (@votable_coosys) {
		    $xmldom_element_coosys =
			$votable_coosys->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_coosys,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_coosys (@votable_coosys) {
		    $xmldom_element_coosys =
			$votable_coosys->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_coosys);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the COOSYS elements right after it. Otherwise,
	    # append the COOSYS elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_coosys (@votable_coosys) {
		    $xmldom_element_coosys =
			$votable_coosys->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_coosys,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_coosys (@votable_coosys) {
		    $xmldom_element_coosys =
			$votable_coosys->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_coosys);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the COOSYS
	    # elements as the first children.
	    foreach $votable_coosys (@votable_coosys) {
		$xmldom_element_coosys =
		    $votable_coosys->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_coosys,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these COOSYS becomes the first
	# children.
	foreach $votable_coosys (@votable_coosys) {
	    $xmldom_element_coosys =
		$votable_coosys->{'XML::DOM::Element'};
	    $xmldom_element_this->appendChild($xmldom_element_coosys);
	}

    }

    # Return the new object.
    return($this->get_coosys);

}

sub get_param()
{
    my($this) = @_;
    if (exists($this->{'PARAM'})) {
	return(@{$this->{'PARAM'}});
    } else {
	return(());
    }
}

sub set_param()
{

    # Save arguments.
    my($this, @votable_param) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::PARAM object and its underlying
    # XML::DOM::Element object.
    my($votable_param);
    my($xmldom_element_param);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'PARAM'} = [@votable_param];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any PARAM elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::PARAMs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_param; $i++) {
	$xmldom_element_param = $votable_param[$i]->{'XML::DOM::Element'};
	$xmldom_element_param->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # PARAM elements as the first child elements of this object after
    # the last COOSYS, the last INFO, or any DESCRIPTION. Otherwise,
    # just add the PARAM elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {

	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the PARAM elements right after it. Otherwise, append
	    # the PARAM elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param =
			$votable_param->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_param,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param =
			$votable_param->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_param);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the PARAM elements right after it. Otherwise, append
	    # the PARAM elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param =
			$votable_param->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_param,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param =
			$votable_param->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_param);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the PARAM elements right after it. Otherwise,
	    # append the PARAM elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param =
			$votable_param->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_param,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param =
			$votable_param->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_param);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the PARAM
	    # elements as the first children.
	    foreach $votable_param (@votable_param) {
		$xmldom_element_param =
		    $votable_param->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_param,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these PARAM becomes the first
	# children.
	foreach $votable_param (@votable_param) {
	    $xmldom_element_param =
		$votable_param->{'XML::DOM::Element'};
	    $xmldom_element_this->appendChild($xmldom_element_param);
	}

    }

    # Return the new object.
    return($this->get_param);

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
    my($this, @votable_link) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::LINK object and its underlying
    # XML::DOM::Element object.
    my($votable_link);
    my($xmldom_element_link);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'LINK'} = [@votable_link];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

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
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_link; $i++) {
	$xmldom_element_link = $votable_link[$i]->{'XML::DOM::Element'};
	$xmldom_element_link->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # LINK elements as the first child elements of this object after
    # the last PARAM, the last COOSYS, the last INFO, or any
    # DESCRIPTION. Otherwise, just add the LINK elements as the first
    # children.
    if ($xmldom_element_this->hasChildNodes) {

	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {

	    # If the last PARAM element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append
	    # the LINK elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append
	    # the LINK elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append
	    # the LINK elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link =
			$votable_link->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} elsif (@xmldom_elements =
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

	# No existing children, so these LINK becomes the first
	# children.
	foreach $votable_link (@votable_link) {
	    $xmldom_element_link =
		$votable_link->{'XML::DOM::Element'};
	    $xmldom_element_this->appendChild($xmldom_element_link);
	}

    }

    # Return the new object.
    return($this->get_link);

}

sub get_table()
{
    my($this) = @_;
    if (exists($this->{'TABLE'})) {
	return(@{$this->{'TABLE'}});
    } else {
	return(());
    }
}

sub set_table()
{

    # Save arguments.
    my($this, @votable_table) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::TABLE object and its underlying
    # XML::DOM::Element object.
    my($votable_table);
    my($xmldom_element_table);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'TABLE'} = [@votable_table];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any TABLE elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('TABLE', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::TABLEs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_table; $i++) {
	$xmldom_element_table = $votable_table[$i]->{'XML::DOM::Element'};
	$xmldom_element_table->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # TABLE elements as the first child elements of this object after
    # the last LINK, the last PARAM, the last COOSYS, the last INFO,
    # or any DESCRIPTION. Otherwise, just add the TABLE elements as
    # the first children.
    if ($xmldom_element_this->hasChildNodes) {

	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {

	    # If the last LINK element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {

	    # If the last PARAM element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the TABLE elements right after it. Otherwise,
	    # append the TABLE elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table =
			$votable_table->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the TABLE
	    # elements as the first children.
	    foreach $votable_table (@votable_table) {
		$xmldom_element_table =
		    $votable_table->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_table,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these TABLE becomes the first
	# children.
	foreach $votable_table (@votable_table) {
	    $xmldom_element_table =
		$votable_table->{'XML::DOM::Element'};
	    $xmldom_element_this->appendChild($xmldom_element_table);
	}

    }

    # Return the new object.
    return($this->get_table);

}

sub get_resource()
{
    my($this) = @_;
    if (exists($this->{'RESOURCE'})) {
	return(@{$this->{'RESOURCE'}});
    } else {
	return(());
    }
}

sub set_resource()
{

    # Save arguments.
    my($this, @votable_resource) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::RESOURCE object and its underlying
    # XML::DOM::Element object.
    my($votable_resource);
    my($xmldom_element_resource);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'RESOURCE'} = [@votable_resource];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # If any RESOURCE elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('RESOURCE', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::RESOURCEs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_resource; $i++) {
	$xmldom_element_resource =
	    $votable_resource[$i]->{'XML::DOM::Element'};
	$xmldom_element_resource->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # RESOURCE elements as the first child elements of this object
    # after the last TABLE, the last LINK, the last PARAM, the last
    # COOSYS, the last INFO, or any DESCRIPTION. Otherwise, just add
    # the RESOURCE elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {

	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('TABLE', 0)) {

	    # If the last TABLE element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {

	    # If the last LINK element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {

	    # If the last PARAM element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the RESOURCE elements right after it. Otherwise,
	    # append the RESOURCE elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the RESOURCE
	    # elements as the first children.
	    foreach $votable_resource (@votable_resource) {
		$xmldom_element_resource =
		    $votable_resource->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_resource,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these RESOURCE becomes the first
	# children.
	foreach $votable_resource (@votable_resource) {
	    $xmldom_element_resource =
		$votable_resource->{'XML::DOM::Element'};
	    $xmldom_element_this->appendChild($xmldom_element_resource);
	}

    }

    # Return the new object.
    return($this->get_resource);

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

    # References to elements.
    my($votable_description);
    my(@votable_info);
    my(@votable_coosys);
    my(@votable_param);
    my(@votable_link);
    my(@votable_table);
    my(@votable_resource);

    # Temporary XML::DOM::Elements.
    my(@xmldom_elements, $xmldom_element);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # DESCRIPTION
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {
	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
	$this->set_description($votable_description);
    }

    #--------------------------------------------------------------------------

    # INFO
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('INFO', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_info[$i] = new VOTABLE::INFO $xmldom_elements[$i];
	}
	$this->set_info(@votable_info);
    }

    #--------------------------------------------------------------------------

    # COOSYS
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_coosys[$i] = new VOTABLE::COOSYS $xmldom_elements[$i];
	}
	$this->set_coosys(@votable_coosys);
    }

    #--------------------------------------------------------------------------

    # PARAM
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_param[$i] = new VOTABLE::PARAM $xmldom_elements[$i];
	}
	$this->set_param(@votable_param);
    }

    #--------------------------------------------------------------------------

    # LINK
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('LINK', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_link[$i] = new VOTABLE::LINK $xmldom_elements[$i];
	}
	$this->set_link(@votable_link);
    }

    #--------------------------------------------------------------------------

    # TABLE
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLE', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_table[$i] = new VOTABLE::TABLE $xmldom_elements[$i];
	}
	$this->set_table(@votable_table);
    }

    #--------------------------------------------------------------------------

    # RESOURCE
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('RESOURCE', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_resource[$i] = new VOTABLE::RESOURCE $xmldom_elements[$i];
	}
	$this->set_resource(@votable_resource);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************

# End of VOTABLE::RESOURCE module.

1;
__END__
