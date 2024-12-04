# DESCRIPTION.pm

=pod

=head1 NAME

VOTABLE::DESCRIPTION - VOTABLE DESCRIPTION XML element class

=head1 SYNOPSIS

C<use VOTABLE::DESCRIPTION;>

=head1 DESCRIPTION

This class implements the C<DESCRIPTION> element from the C<VOTABLE>
DTD. This element is used to store a textual description of its parent
element.

The C<DESCRIPTION> element is a Tier 0 element, and is described by
the following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT DESCRIPTION (#PCDATA)>
 
=head2 Methods

=head3 C<new($str_or_ref, %options)>

Create a new C<VOTABLE::DESCRIPTION> object, and return a reference to
it. If the first argument (C<$str_or_ref>) is a string, it is used as
the initial C<PCDATA> content of the C<DESCRIPTION> element. If the
first argument is a reference to a C<XML::DOM::Element> object, that
object is used to initialize the new C<DESCRIPTION> element
(implicitly assuming that the C<XML::DOM::Element> object contains a
valid C<DESCRIPTION> element). The C<%options> hash is used to set the
attributes of the new element. If the first argument is missing or
undefined, or an empty string, create and return an empty
C<VOTABLE::DESCRIPTION> object. Return C<undef> if an error occurs.

=head3 C<get>

Return a string containing the C<PCDATA> content of the C<DESCRIPTION>
element. Return C<undef> if the element has no C<PCDATA> content, or
an error occurs.

=head3 C<set($str)>

Set the C<PCDATA> content of the C<DESCRIPTION> element to the
specified string. Return the string on success, or C<undef> if an
error occurs.

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
C<VOTABLE::DESCRIPTION> object I<always> has an underlying
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

C<VOTABLE>, C<VOTABLE::Document>, C<VOTABLE::FIELD>,
C<VOTABLE::PARAM>, C<VOTABLE::RESOURCE>, C<VOTABLE::TABLE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: DESCRIPTION.pm,v 1.1.1.9 2002/05/21 14:09:37 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: DESCRIPTION.pm,v $
# Revision 1.1.1.9  2002/05/21  14:09:37  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.8  2002/05/21  11:52:45  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.7  2002/05/06  23:32:45  elwinter
# Overhauled.
#
# Revision 1.1.1.6  2002/05/03  14:19:05  elwinter
# Added check on eval status.
#
# Revision 1.1.1.5  2002/05/03  13:53:20  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/04/30  16:17:17  elwinter
# Complete overhaul.
#
# Revision 1.1.1.3  2002/04/29  15:04:38  elwinter
# Removed use of Exporter module.
#
# Revision 1.1.1.2  2002/04/25  15:49:06  elwinter
# Added constructor and accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::DESCRIPTION;

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
our $VERSION = '0.02';

#******************************************************************************

# Specify external modules to use.

# Standard modules.
use Carp;
use English;
use XML::DOM;

# Third-party modules.

# Project modules.

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'DESCRIPTION';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ();

#******************************************************************************

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
# current class (VOTABLE::DESCRIPTION), unless this constructor is
# called for an object that inherits from the current class.

# All remaining arguments are stored in the @options array. The first
# additional argument, if it exists, contains either a string to use
# to initialize the PCDATA content of the new object, or a reference
# to an existing XML::DOM::Element object to use for the new
# object. Any additional items in the @options array are assumed to be
# keyword => value pairs to use to initialize the attributes of the
# new object.

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

    # String with initial text for the PCDATA content of the element.
    my($str);

    # Hash containing keyword-value pairs to initialize attributes.
    my(%attributes);

    # Name of current element tag.
    my($tag_name);

    # Current attribute name and value.
    my($attribute_name, $attribute_value);

    # Reference to new object.
    my($this);

    # XML::DOM::Text object for the PCDATA content.
    my($xmldom_text);

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
 	    ($xmldom_element_this, %attributes) = @options;
 	} else {
 	    ($str, %attributes) = @options;
 	}
    }

    # Make sure the specified element (if any) is the correct type.
    if ($xmldom_element_this) {
	$tag_name = $xmldom_element_this->getTagName;
	if ($tag_name ne $TAG_NAME) {
	    carp("Invalid tag name: $tag_name");
	    return(undef);
	}
    }

    # Make sure only valid attributes were specified.
    foreach $attribute_name (keys(%attributes)) {
	if (not grep(/$attribute_name/, @valid_attribute_names)) {
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

    } elsif ($str) {

	# Create a new XML::DOM::Element object.
	$xmldom_element_this =
	    $xmldom_document_factory->createElement($TAG_NAME);
	if (not $xmldom_element_this) {
	    carp('Unable to create XML::DOM::Element.');
	    return(undef);
	}

	# Create a text node for the content.
	$xmldom_text = $xmldom_document_factory->createTextNode($str);
	if (not $xmldom_element_this) {
	    carp("Unable to create XML::DOM::Text for string '$str'.");
	    return(undef);
	}

	# Add the text node to the element.
	if ($xmldom_element_this->appendChild($xmldom_text) ne $xmldom_text) {
	    carp('Unable to append XML::DOM::Text to XML::DOM::Element.');
	    return(undef);
	}

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

    # Construct the VOTABLE::DESCRIPTION object from the XML::DOM::Element
    # object.
    if (not $this->_build_from_XMLDOM) {
	carp("Unable to build VOTABLE::$TAG_NAME from XML::DOM::Element.");
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

# PCDATA content accessor methods

#------------------------------------------------------------------------------

sub get()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to XML::DOM::Text object containing the PCDATA.
    my($xmldom_text);

    #--------------------------------------------------------------------------

    # Fetch the underlying XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If there are any child nodes, there should be only one, and it
    # should be a text node. If so, fetch the content of the text
    # node. Otherwise, not text has been defined for this element, so
    # return undef.
    if ($xmldom_element_this->hasChildNodes) {
 	$xmldom_text = $xmldom_element_this->getFirstChild;
 	return($xmldom_text->getData);
    } else {
 	return(undef);
    }

}

sub set()
{

    # Save arguments.
    my($this, $str) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to XML::DOM::Text object containing the PCDATA.
    my($xmldom_text);

    #--------------------------------------------------------------------------

    # Fetch the underlying XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If the text node exists, use it. Otherwise, create a new
    # one. Note that this object should have at most one child node,
    # and it can only be a text node.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_text = $xmldom_element_this->getFirstChild;
	$xmldom_text->setData($str);
    } else {
	$xmldom_text = $xmldom_document_factory->createTextNode($str);
	if (not $xmldom_text) {
	    carp("Unable to create XML::DOM::Text for '$str'.");
	    return(undef);
	}
	if ($xmldom_element_this->appendChild($xmldom_text) ne $xmldom_text) {
	    carp('Unable to append XML::DOM::Text.');
	    return(undef);
	}
    }

    # Return the string.
    return($this->get);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Internal methods

# These methods should ONLY be used by this class, and other classes
# within the VOTABLE hierarchy, since these methods assume integrity
# of their arguments, the VOTABLE::COOSYS object and the underlying
# XML::DOM::Element object.

#------------------------------------------------------------------------------

# _build_from_XMLDOM()

# This internal method is used to assemble a VOTABLE::DESCRIPTION
# object from a XML::DOM::Element object. Return 1 on success, or 0 on
# failure.

# Since the DESCRIPTION element is a Tier 0 element, there is nothing
# for this method to do, other than return true (1) to indicate
# success.

sub _build_from_XMLDOM()
{
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
