# DEFINITIONS.pm

=pod

=head1 NAME
VOTABLE::DEFINITIONS - VOTABLE DEFINITIONS XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the DEFINITIONS element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: DEFINITIONS.pm,v 1.1.1.7 2002/05/14 17:37:20 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: DEFINITIONS.pm,v $
# Revision 1.1.1.7  2002/05/14  17:37:20  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.6  2002/05/14  12:18:13  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:41:20  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/04/28  21:06:34  elwinter
# Added use of factory document.
#
# Revision 1.1.1.3  2002/04/28  14:17:42  elwinter
# Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::DEFINITIONS;

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
use VOTABLE::PARAM;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'DEFINITIONS';

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

    # Reference to current VOTABLE::COOSYS object, and its underlying
    # XML::DOM::Element.
    my($votable_coosys);
    my($xmldom_element_coosys);

    # Temporary arrays of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'COOSYS'} = [@votable_coosys];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};


    # If this object already has any COOSYS elements, remove the
    # COOSYS elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $xmldom_element_this->removeChild($xmldom_element);
	}
    }

    # Attach the new objects to the owner document for this
    # object. THIS IS IMPORTANT!
    foreach $votable_coosys (@votable_coosys) {
	$xmldom_element_coosys = $votable_coosys->{'XML::DOM::Element'};
	$xmldom_element_coosys->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # Append the new COOSYS elements.
    foreach $votable_coosys (@votable_coosys) {
	$xmldom_element_this->
	    appendChild($votable_coosys->{'XML::DOM::Element'});
    }

    # Return the new objects.
    return(@votable_coosys);

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

    # Reference to current VOTABLE::PARAM object, and its underlying
    # XML::DOM::Element.
    my($votable_param);
    my($xmldom_element_param);

    # Temporary arrays of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'PARAM'} = [@votable_param];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};


    # If this object already has any PARAM elements, remove the
    # PARAM elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $xmldom_element_this->removeChild($xmldom_element);
	}
    }

    # Attach the new objects to the owner document for this
    # object. THIS IS IMPORTANT!
    foreach $votable_param (@votable_param) {
	$xmldom_element_param = $votable_param->{'XML::DOM::Element'};
	$xmldom_element_param->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # Append the new PARAM elements.
    foreach $votable_param (@votable_param) {
	$xmldom_element_this->
	    appendChild($votable_param->{'XML::DOM::Element'});
    }

    # Return the new objects.
    return(@votable_param);

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

    # Reference to new VOTABLE::COOSYS object, and all of them.
    my($votable_coosys);
    my(@votable_coosys);

    # Reference to new VOTABLE::PARAM object, and all of them.
    my($votable_param);
    my(@votable_param);

    # Temporary array of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # COOSYS

    # Get a list of all COOSYS elements which are children of the
    # DEFINITIONS element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $votable_coosys = new VOTABLE::COOSYS $xmldom_element;
	    push(@votable_coosys, $votable_coosys);
	}
	$this->set_coosys(@votable_coosys);
    }

    #--------------------------------------------------------------------------

    # PARAM

    # Get a list of all PARAM elements which are children of the
    # DEFINITIONS element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $votable_param = new VOTABLE::PARAM $xmldom_element;
	    push(@votable_param, $votable_param);
	}
	$this->set_param(@votable_param);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
__END__
