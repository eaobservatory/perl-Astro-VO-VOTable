# DEFINITIONS.pm

=pod

=head1 NAME

VOTABLE::DEFINITIONS - VOTABLE DEFINITIONS XML element class

=head1 SYNOPSIS

C<use VOTABLE::DEFINITIONS;>

=head1 DESCRIPTION

This class implements the C<DEFINITIONS> element from the C<VOTABLE>
DTD. This element is used as a glossary to store definitions used in
other parts of the document.

The C<DEFINITIONS> element is a Tier 4 element, and is described by
the following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT DEFINITIONS (COOSYS?, PARAM?)*>

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::DEFINITIONS> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::DEFINITIONS> object. Return C<undef> if an error occurs.

=head3 C<get_coosys>

Return a list of the C<VOTABLE::COOSYS> objects for the C<COOSYS>
elements which are the children of this C<DEFINITIONS> element. Return
an empty list if no C<COOSYS> elements are found, or if an error
occurs.

=head3 C<set_coosys(@votable_coosys)>

Set the C<COOSYS> elements for this C<DEFINITIONS> element using the
supplied list of C<VOTABLE::COOSYS> objects. Any previously existing
C<COOSYS> elements are first removed. Return the input list on
success, or an empty list if an error occurs.

=head3 C<get_param>

Return a list of the C<VOTABLE::PARAM> objects for the C<PARAM>
elements which are the children of this C<DEFINITIONS> element. Return
an empty list if no C<PARAM> elements are found, or if an error
occurs.

=head3 C<set_param(@votable_param)>

Set the C<PARAM> elements for this C<DEFINITIONS> element using the
supplied list of C<VOTABLE::PARAM> objects. Any previously existing
C<PARAM> elements are first removed. Return the input list on success,
or an empty list if an error occurs.

=head2 Notes on class internals

=over 4

=item *

Method names that begin with a leading underscore ('C<_>') are for
internal use only, and should I<not> be used outside of the C<VOTABLE>
class hierarchy.

=item *

The names of the C<get_XXX> and C<set_XXX> accessors for attributes
and elements are derived directly from the names of the attributes or
elements. Attribute and element names containing embedded hyphens
('C<->') use accessors where the hyphen is mapped to an underscore
('C<_>') in the name of the accessor method. This is a necessity,
since the hyphen is not a valid name character in Perl.

=back

=head1 WARNINGS

=over 4

=item *

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE::TABLEDATA> object I<always> has an underlying
C<XML::DOM::Element> object. As long as the internal structure is
manipulated only by the publicly-available methods, this should be an
adequate assumption. If a method detects an aberrant case, a warning
message is printed (using the C<Carp::carp> subroutine), and the
method fails.

=item *

Similarly, this code assumes that C<XML::DOM> methods always
succeed. If a method detects an aberrant case, a warning message is
printed (using the C<Carp::carp> subroutine), and the method fails.

=item *

Most attribute C<set_XXX> accessors do not perform validation of the
new attribute values. The exceptions are the accessors for attributes
with enumerated values; the new value is checked against the list of
acceptable values, as defined in the DTD.

=back

=head1 SEE ALSO

C<VOTABLE>, C<VOTABLE::COOSYS>, C<VOTABLE::Document>, C<VOTABLE::PARAM>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: DEFINITIONS.pm,v 1.1.1.9 2002/05/21 14:09:19 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: DEFINITIONS.pm,v $
# Revision 1.1.1.9  2002/05/21  14:09:19  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.8  2002/05/21  11:52:18  elwinter
# Overhauled and updated documentation.
#
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

#------------------------------------------------------------------------------

# Set up the inheritance mexhanism.
our @ISA = qw();

# Module version.
our $VERSION = '0.02';

#------------------------------------------------------------------------------

# Specify external modules to use.

# Standard modules.
use Carp;
use English;
use XML::DOM;

# Third-party modules.

# Project modules.
use VOTABLE::COOSYS;
use VOTABLE::PARAM;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'DEFINITIONS';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ();

#------------------------------------------------------------------------------

# Class variables.

# This object is used to access the factory methods in the
# XML::DOM::Document class.
my($xmldom_document_factory);

#******************************************************************************

# Class methods

#------------------------------------------------------------------------------

# INIT()

# This subroutine is run just before the main program starts. It is
# used to initialize the package as a whole.

sub INIT()
{

    # Create the factory document.
    $xmldom_document_factory = new XML::DOM::Document;
    if (not $xmldom_document_factory) {
	croak('Unable to create factory document!');
    }

}

#------------------------------------------------------------------------------

# Object methods

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
	if (ref($options[0])) {
	    if (ref($options[0]) ne $XMLDOM_BASE_CLASS) {
 		carp('Bad input class: ', ref($options[0]));
 		return(undef);
 	    }
	}
	($xmldom_element_this, %attributes) = @options;
    }

    # Make sure the specified element (if any) is the correct type.
    if ($xmldom_element_this) {
	$tag_name = $xmldom_element_this->getTagName;
	if ($tag_name ne $TAG_NAME) {
	    carp("Invalid tag name: $tag_name!");
	    return(undef);
	}
    }

    # Make sure only valid attributes were specified.
    foreach $attribute_name (keys(%attributes)) {
	if (not grep(/$attribute_name/, @valid_attribute_names)) {
	    carp("Invalid attribute name: $attribute_name!");
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
	    $xmldom_document_factory->createElement($TAG_NAME);
	if (not $xmldom_element_this) {
	    carp('Unable to create XML::DOM::Element.');
	    return(undef);
	}

    }

    # Save the new XML::DOM::Element.
    if ($this->_set_XMLDOM($xmldom_element_this) ne $xmldom_element_this) {
	carp("Unable to set $XMLDOM_BASE_CLASS.");
	return(undef);
    }

    # Process any specified attributes.
    while (($attribute_name, $attribute_value) = each(%attributes)) {
	$attribute_name =~ s/-/_/;
	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";
	eval($set_attribute);
	if ($EVAL_ERROR) {
	    carp("Error evaluating '$set_attribute': $EVAL_ERROR!");
	    return(undef);
	}
    }

    # Construct the VOTABLE::DEFINITIONS object from the XML::DOM
    # object.
    if (not $this->_build_from_XMLDOM) {
	carp("Unable to build VOTABLE::$TAG_NAME object from " .
	     "XML::DOM::Element!");
	return(undef);
    }

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------

# Attribute accessor methods

#------------------------------------------------------------------------------

# Element accessor methods

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

    # Link the objects at the VOTABLE level.
    $this->{'COOSYS'} = [@votable_coosys];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If this object already has any COOSYS elements, remove the
    # COOSYS elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $xmldom_element_this->removeChild($xmldom_element);
	}
    }

    # Attach the new objects to the owner document for this object.
    foreach $votable_coosys (@votable_coosys) {
	$xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
	$xmldom_element_coosys->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # Append the new COOSYS elements.
    foreach $votable_coosys (@votable_coosys) {
	$xmldom_element_this->
	    appendChild($votable_coosys->_get_XMLDOM);
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

    # Link the objects at the VOTABLE level.
    $this->{'PARAM'} = [@votable_param];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level.

    # Get the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If this object already has any PARAM elements, remove the
    # PARAM elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $xmldom_element_this->removeChild($xmldom_element);
	}
    }

    # Attach the new objects to the owner document for this object.
    foreach $votable_param (@votable_param) {
	$xmldom_element_param = $votable_param->_get_XMLDOM;
	$xmldom_element_param->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # Append the new PARAM elements.
    foreach $votable_param (@votable_param) {
	$xmldom_element_this->
	    appendChild($votable_param->_get_XMLDOM);
    }

    # Return the new objects.
    return(@votable_param);

}

#------------------------------------------------------------------------------

# PCDATA content accessor methods

#------------------------------------------------------------------------------

# Internal methods

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
    $xmldom_element_this = $this->_get_XMLDOM;

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

#------------------------------------------------------------------------------

# _get_XMLDOM()

# Internal method to get a reference to the underlying
# XML::DOM::Element object.

sub _get_XMLDOM()
{
    my($this) = @_;
    return($this->{$XMLDOM_BASE_CLASS});
}

#------------------------------------------------------------------------------

# _set_XMLDOM()

# Internal method to set the reference to the underlying
# XML::DOM::Element object. Return the reference to the new
# XML::DOM::Element.

sub _set_XMLDOM()
{
    my($this, $xmldom_element) = @_;
    $this->{$XMLDOM_BASE_CLASS} = $xmldom_element;
    return($this->{$XMLDOM_BASE_CLASS});
}

#******************************************************************************
1;
__END__
