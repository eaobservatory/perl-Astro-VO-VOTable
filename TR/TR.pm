# TR.pm

=pod

=head1 NAME
VOTABLE::TR - VOTABLE TR XML element class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class implements the TR element from the VOTABLE DTD.

=head1 WARNINGS

This code assumes that the internal state of the objects is consistent
at all times.

This code assumes that calls to XML::DOM methods and subroutines never
fail.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: TR.pm,v 1.1.1.8 2002/05/14 17:46:54 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: TR.pm,v $
# Revision 1.1.1.8  2002/05/14  17:46:54  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.7  2002/05/07  16:00:35  elwinter
# Fixed TD bug.
#
# Revision 1.1.1.6  2002/05/07  15:48:01  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/03  18:02:43  elwinter
# Removed superfluous code.
#
# Revision 1.1.1.4  2002/05/03  17:45:29  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  19:35:13  elwinter
# Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::TR;

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
use VOTABLE::TD;

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'TR';

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

sub get_td()
{
    my($this) = @_;
    if (exists($this->{'TD'})) {
	return(@{$this->{'TD'}});
    } else {
	return(());
    }
}

sub set_td()
{

    # Save arguments.
    my($this, @votable_td) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Temporary reference to the XML::DOM::Document object for this
    # object.
    my($xmldom_document);

    # Reference to current VOTABLE::TD object.
    my($votable_td);

    # Temporary arrays of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the new elements to this VOTABLE object. This is easy,
    # since parent/child links in the VOTABLE class hierarchy are
    # one-way, from parent to child.
    $this->{'TD'} = [@votable_td];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    # Get the owner XML::DOM::Document object for this object.
    $xmldom_document = $xmldom_element_this->getOwnerDocument;

    # Attach each INFO XML::DOM::Element to the
    # XML::DOM::Document. THIS IS IMPORTANT!
    foreach $votable_td (@votable_td) {
	$votable_td->{'XML::DOM::Element'}->setOwnerDocument($xmldom_document);
    }

    # If any TD elements exist for the this object, delete them. Then
    # add each of the new TD elements.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('TD', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }
    foreach $votable_td (@votable_td) {
	$xmldom_element_this->
	    appendChild($votable_td->{'XML::DOM::Element'});
    }

    # Return the new objects.
    return($this->get_td);

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
    my($this_xmldom_element);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New TD element, single and all.
    my($votable_td, @votable_td);

    # Temporary reference to current XML::DOM::Element.
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $this_xmldom_element = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # TD

    # There must be at least one TD, eventually.
    @xmldom_elements =
	$this_xmldom_element->getElementsByTagName('TD', 0);
    foreach $xmldom_element (@xmldom_elements) {
	$votable_td = new VOTABLE::TD $xmldom_element;
	push(@votable_td, $votable_td);
    }
    $this->set_td(@votable_td);

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************
1;
__END__
