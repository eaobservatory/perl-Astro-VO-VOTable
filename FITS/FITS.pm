# FITS.pm

=pod

=head1 NAME

VOTABLE::FITS - VOTABLE FITS XML element class

=head1 SYNOPSIS

C<use VOTABLE::FITS;>

=head1 DESCRIPTION

This class implements the C<FITS> element from the C<VOTABLE>
DTD. This element is used to encapsulate FITS-formatted data.

The C<FITS> element is a Tier 1 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT FITS (STREAM)>
 <!ATTLIST FITS
         extnum CDATA #IMPLIED
 >

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::FITS> object, based on the supplied
C<XML::DOM::Element> object, using C<%options> to set the attributes
of the new object. If no C<XML::DOM::Element> object is specified, or
is undefined, create and return an empty C<VOTABLE::FITS>
object. Return undef if an error occurs.

=head3 C<get_extnum>

Return the value of the C<extnum> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_extnum($extnum)>

Set the value of the C<extnum> attribute to the specified
value. Return the new value of the attribute on success, or C<undef>
if an error occurs.

=head3 C<get_stream>

Return the C<VOTABLE::STREAM> object for the C<STREAM> element which
is the child of this C<FITS> element. Return C<undef> if no C<STREAM>
element is found, or an error occurs.

=head3 C<set_stream($votable_stream)>

Set the C<STREAM> element for this C<FITS> element using the supplied
C<VOTABLE::STREAM> object. Any existing C<STREAM> element is first
removed. Return the C<VOTABLE::STREAM> object on success, or C<undef>
if an error occurs.

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

This class does not currently support decoding of the C<FITS STREAM>,
but that capability will be added ASAP.

=item *

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE::FITS> object I<always> has an underlying
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

C<VOTABLE>, C<VOTABLE::DATA>, C<VOTABLE::STREAM>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: FITS.pm,v 1.1.1.8 2002/05/21 14:10:49 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: FITS.pm,v $
# Revision 1.1.1.8  2002/05/21  14:10:49  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.7  2002/05/21  13:43:03  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.6  2002/05/07  15:36:41  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:16:51  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/01  18:13:24  elwinter
# Added accessors for STREAM element.
#
# Revision 1.1.1.3  2002/04/28  14:57:45  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::FITS;

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
use VOTABLE::STREAM;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'FITS';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('extnum');

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

    # Construct the VOTABLE::FITS object from the XML::DOM object.
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

sub get_extnum()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('extnum'));
}

sub set_extnum()
{
    my($this, $extnum) = @_;
    $this->_get_XMLDOM->setAttribute('extnum', $extnum);
    return($this->get_extnum);
}

#------------------------------------------------------------------------------

# Element accessor methods

#------------------------------------------------------------------------------

sub get_stream()
{
    my($this) = @_;
    if (exists($this->{'STREAM'})) {
	return($this->{'STREAM'});
    } else {
	return(undef);
    }
}

sub set_stream()
{

    # Save arguments.
    # $this is a reference to the current object.
    # $votable_stream is a reference to the VOTABLE::STREAM to use for
    # the current VOTABLE::FITS.
    my($this, $votable_stream) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the current
    # VOTABLE::STREAM object.
    my($xmldom_element_stream);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Validate the input.
    if (ref($votable_stream) ne 'VOTABLE::STREAM') {
	carp('Invalid object class: ' . ref($votable_stream));
	return(undef);
    }

    # Link the objects at the VOTABLE level.
    $this->{'STREAM'} = $votable_stream;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this FITS element.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new STREAM element.
    $xmldom_element_stream = $votable_stream->_get_XMLDOM;
    if (not $xmldom_element_stream) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this FITS element already has a STREAM element, remove the
    # STREAM element. There should be only one.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('STREAM', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the STREAM element to the FITS element owner
    # document. THIS IS IMPORTANT!
    $xmldom_element_stream->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the STREAM element as the first child node of the FITS
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_stream,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_stream);
    }

    # Return the STREAM element.
    return($this->get_stream);

}

#------------------------------------------------------------------------------

# PCDATA content accessor methods

#------------------------------------------------------------------------------

# Internal methods

# These methods should ONLY be used by this class, and other classes
# within the VOTABLE hierarchy, since these methods assume integrity
# of their arguments, the VOTABLE::BINARY object and the underlying
# XML::DOM::Element object.

#------------------------------------------------------------------------------

# _build_from_XMLDOM()

# This internal method is used to assemble a VOTABLE::FITS object from
# a XML::DOM::Element object. Return 1 on success, or 0 on failure.

sub _build_from_XMLDOM()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for current VOTABLE
    # object.
    my($xmldom_element_this);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New STREAM element.
    my($votable_stream);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    #--------------------------------------------------------------------------

    # STREAM

    # The current element should contain at most a single STREAM
    # element.
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('STREAM', 0);
    if (@xmldom_elements > 1) {
	carp('Multiple STREAM elements!');
	return(0);
    }
    if (@xmldom_elements) {
	$votable_stream = new VOTABLE::STREAM $xmldom_elements[0];
	if (not $votable_stream) {
	    carp('Unable to create VOTABLE::STREAM!');
	    return(0);
	}
	if ($this->set_stream($votable_stream) ne $votable_stream) {
	    carp('Unable to set VOTABLE::STREAM!');
	    return(0);
	}
    }

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
