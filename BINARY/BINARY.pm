# BINARY.pm

=pod

=head1 NAME

VOTABLE::BINARY - VOTABLE BINARY XML element class

=head1 SYNOPSIS

 use VOTABLE::BINARY;

=head1 DESCRIPTION

This class implements the C<BINARY> element from the C<VOTABLE>
DTD. This element encapsulates a stream of binary data (non-FITS).

The C<BINARY> element is a Tier 1 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT BINARY (STREAM)>

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::BINARY> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::BINARY> object. Return undef if an error occurs.

=head3 C<get_stream>

Return the C<VOTABLE::STREAM> object for the C<STREAM> element which
is the child of this C<BINARY> element. Return C<undef> if no
C<STREAM> element is found, or an error occurs.

=head3 C<set_stream($votable_stream)>

Set the C<STREAM> element for this C<BINARY> element using the
supplied C<VOTABLE::STREAM> object. Return the C<VOTABLE::STREAM>
object on success, or C<undef> if an error occurs.

=head3 C<get_content($offset, $length)>

Return a portion of the content string starting at C<$offset> bytes
and continuing for C<$length> bytes. If C<$offset> and C<$length> are
not specified, return the entire content as a single byte string. If
C<$offset> is specified but C<$length> is not, return the content from
C<$offset> to the end of the string. Otherwise, the C<$offset> and
C<$length> arguments are treated the same as the corresponding
arguments to the C<substr> subroutine. Return the content as a string,
or C<undef> if an error occurs.

=head3 C<set_content($bytes, $offset, $length)>

Set the specified portion of the content, starting at C<$offset> and
continuing for C<$length> bytes, to the specified byte string. If
C<$offset> and C<$length> are not specified, the current content is
replaced by the specified byte string. If C<$offset> is specified but
C<$length> is not specified, C<$length> defaults to the length of
C<$bytes>. Otherwise, C<$offset> and C<$length> behave as the
corresponding arguments to C<substr>. Return the new string on
success, or C<undef> on error.

=head2 Notes on class internals

=over 4

=item *

Method names that begin with a leading underscore ('C<_>') are for
internal use only, and should I<not> be used outside of the C<VOTABLE>
class hierarchy.

=item *

The names of the C<get_XXX> and C<set_XXX> accessors for attributes
and elements are derived directly from the names of the attributes or
elements, with the attribute or element name replacing
C<XXX>. Attribute and element names containing embedded hyphens
('C<->') use accessors where the hyphen is mapped to an underscore
('C<_>') in the name of the accessor method. This is a necessity,
since the hyphen is not a valid name character in Perl.

=back

=head1 WARNINGS

=over 4

=item *

This class does not currently support decoding of the C<BINARY
STREAM>, but that capability will be added ASAP.

=item *

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE> object I<always> has an underlying C<XML::DOM::Element>
object. As long as the internal structure is manipulated only by the
publicly-available methods, this should be an adequate assumption. If
a method detects an aberrant case, a warning message is printed (using
the C<Carp::carp> subroutine), and the method fails.

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

$Id: BINARY.pm,v 1.1.1.13 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: BINARY.pm,v $
# Revision 1.1.1.13  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.12  2002/06/08  20:30:41  elwinter
# Minor tweaks to documentation and code arrangement.
#
# Revision 1.1.1.11  2002/05/29  12:24:12  elwinter
# Overhauled get_content(), added set_content().
#
# Revision 1.1.1.10  2002/05/28  15:07:34  elwinter
# get_content() now returns a string reference.
#
# Revision 1.1.1.9  2002/05/23  13:06:11  elwinter
# Added get_content() method.
#
# Revision 1.1.1.8  2002/05/21  14:07:47  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.7  2002/05/21  11:45:06  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.6  2002/05/07  15:26:22  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:13:39  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/01  18:03:50  elwinter
# Added STREAM accessors.
#
# Revision 1.1.1.3  2002/04/28  14:22:02  elwinter
# Rearranged. Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::BINARY;

# Specify the minimum acceptable Perl version.
use 5.6.1;

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
our $VERSION = '0.03';

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
my($TAG_NAME) = 'BINARY';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@VALID_ATTRIBUTE_NAMES) = ();

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
	    if (ref($options[0]) ne $XMLDOM_BASE) {
 		carp('Bad input class: ', ref($options[0]));
 		return(undef);
 	    }
	    if ($xmldom_element_this) {
		$tag_name = $xmldom_element_this->getTagName;
		if ($tag_name ne $TAG_NAME) {
		    carp("Invalid tag name: $tag_name");
		    return(undef);
		}
	    }
	}
	($xmldom_element_this, %attributes) = @options;
    }

    # Make sure only valid attributes were specified.
    foreach $attribute_name (keys(%attributes)) {
	if (not grep(/$attribute_name/, @VALID_ATTRIBUTE_NAMES)) {
	    carp("Invalid attribute name: $attribute_name");
	    return(undef);
	}
    }

    #--------------------------------------------------------------------------

    # Create the object as an empty hash.
    $this = {};

    # Bless the object.
    bless $this => $class;

    # Fill in the object.
    if ($xmldom_element_this) {

	# Save the specified XML::DOM::Element.

    } else {

	# Create a new XML::DOM::Element object.
	$xmldom_element_this =
	    $xmldom_document_factory->createElement($TAG_NAME);
	if (not $xmldom_element_this) {
	    carp('Unable to create $XMLDOM_BASE.');
	    return(undef);
	}

    }

    # Save the new XML::DOM::Element.
    if ($this->_set_XMLDOM($xmldom_element_this) ne $xmldom_element_this) {
	carp("Unable to set $XMLDOM_BASE.");
	return(undef);
    }

    # Process any specified attributes.
    while (($attribute_name, $attribute_value) = each(%attributes)) {

	# Map the attribute name to a valid Perl name.
	$attribute_name =~ s/-/_/;

	# Create a string of code to evaluate to set the attribute
	# value.
	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";

	# Evalute the attribute-setting code and check for errors.
	eval($set_attribute);
	if ($EVAL_ERROR) {
	    carp("Error evaluating '$set_attribute': $EVAL_ERROR");
	    return(undef);
	}

    }

    # Construct the VOTABLE object from the XML::DOM object.
    if (not $this->_build_from_XMLDOM) {
	carp("Unable to build VOTABLE::$TAG_NAME object from $XMLDOM_BASE.");
	return(undef);
    }

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------

# get_content()

# Fetch the specified portion of the content.

sub get_content()
{

    # Save arguments.
    my($this, $offset, $length) = @_;

    #--------------------------------------------------------------------------

    # Return the content.
    return($this->get_stream->get_content($offset, $length));

}

#------------------------------------------------------------------------------

# set_content()

# Set the specified portion of the content.

sub set_content()
{

    # Save arguments.
    my($this, $bytes, $offset, $length) = @_;

    #--------------------------------------------------------------------------

    # Return the content.
    return($this->get_stream->set_content($bytes, $offset, $length));

}

#------------------------------------------------------------------------------

# Attribute accessor methods

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
    # the current VOTABLE::BINARY.
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

    # Get the XML::DOM::Element for this BINARY element.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new STREAM element.
    $xmldom_element_stream = $votable_stream->_get_XMLDOM;
    if (not $xmldom_element_stream) {
	carp('Unable to find XML::DOM::Element.');
	return(undef);
    }

    # If this BINARY element already has a STREAM element, remove the
    # STREAM element. There should be only one.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('STREAM', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the STREAM element to the BINARY element owner
    # document. THIS IS IMPORTANT!
    $xmldom_element_stream->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the STREAM element as the first child node of the BINARY
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

# Internal methods.

# These methods should ONLY be used by this class, and other classes
# within the VOTABLE hierarchy, since these methods assume integrity
# of their arguments, the VOTABLE::BINARY object and the underlying
# XML::DOM::Element object.

#------------------------------------------------------------------------------

# _build_from_XMLDOM()

# This internal method is used to assemble a VOTABLE::BINARY object
# from a XML::DOM::Element object. Return 1 on success, or 0 on
# failure.

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
	carp('Multiple STREAM elements.');
	return(0);
    }
    if (@xmldom_elements) {
	$votable_stream = new VOTABLE::STREAM $xmldom_elements[0];
	if (not $votable_stream) {
	    carp('Unable to create VOTABLE::STREAM.');
	    return(0);
	}
	if ($this->set_stream($votable_stream) ne $votable_stream) {
	    carp('Unable to set VOTABLE::STREAM.');
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
    return($this->{$XMLDOM_BASE});
}

#------------------------------------------------------------------------------

# _set_XMLDOM()

# Internal method to set the reference to the underlying
# XML::DOM::Element object. Return the reference to the new
# XML::DOM::Element.

sub _set_XMLDOM()
{
    my($this, $xmldom_element) = @_;
    $this->{$XMLDOM_BASE} = $xmldom_element;
    return($this->{$XMLDOM_BASE});
}

#******************************************************************************
1;
__END__
