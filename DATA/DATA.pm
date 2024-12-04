# DATA.pm

=pod

=head1 NAME

VOTABLE::DATA - VOTABLE DATA XML element class

=head1 SYNOPSIS

C<use VOTABLE::DATA;>

=head1 DESCRIPTION

This class implements the C<DATA> element from the C<VOTABLE>
DTD. This is a wrapper element around the C<BINARY>, C<FITS>, and
C<TABLEDATA> elements, and constitutes the data segment of a C<TABLE>
element.

The C<DATA> element is a Tier 3 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT DATA (TABLEDATA | BINARY | FITS)>

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::DATA> object, based on the supplied
C<XML::DOM::Element> object, using C<%options> to set the attributes
of the new object. If no C<XML::DOM::Element> object is specified, or
is undefined, create and return an empty C<VOTABLE::DATA>
object. Return C<undef> if an error occurs.

=head3 C<get_binary>

Return the C<VOTABLE::BINARY> object for the C<BINARY> element which
is the child of this C<DATA> element. Return C<undef> if no C<BINARY>
element is found, or an error occurs.

=head3 C<set_binary($votable_binary)>

Set the C<BINARY> element for this C<DATA> element using the supplied
C<VOTABLE::BINARY> object. Any existing C<BINARY>, C<FITS>, or
C<TABLEDATA> element in this C<DATA> element is replaced by the new
C<BINARY> element. Return the C<VOTABLE::BINARY> object on success, or
C<undef> if an error occurs.

=head3 C<get_fits>

Return the C<VOTABLE::FITS> object for the C<FITS> element which is
the child of this C<DATA> element. Return C<undef> if no C<FITS>
element is found, or an error occurs.

=head3 C<set_fits($votable_fits)>

Set the C<FITS> element for this C<DATA> element using the supplied
C<VOTABLE::FITS> object. Any existing C<BINARY>, C<FITS>, or
C<TABLEDATA> element in this C<DATA> element is replaced by the new
C<FITS> element. Return the C<VOTABLE::FITS> object on success, or
C<undef> if an error occurs.

=head3 C<get_tabledata>

Return the C<VOTABLE::TABLEDATA> object for the C<TABLEDATA> element
which is the child of this C<DATA> element. Return C<undef> if no
C<TABLEDATA> element is found, or an error occurs.

=head3 C<set_tabledata($votable_tabledata)>

Set the C<TABLEDATA> element for this C<DATA> element using the
supplied C<VOTABLE::TABLEDATA> object. Any existing C<BINARY>,
C<FITS>, or C<TABLEDATA> element in this C<DATA> element is replaced
by the new C<TABLEDATA> element. Return the C<VOTABLE::TABLEDATA>
object on success, or C<undef> if an error occurs.

=head3 C<get_content>

Read the data described by the underlying elements for this C<DATA>
element, and return the content as a string. Return C<undef> if an
error occurs.

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

C<VOTABLE>, C<VOTABLE::BINARY>, C<VOTABLE::FITS>,
C<VOTABLE::TABLE>, C<VOTABLE::TABLEDATA>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: DATA.pm,v 1.1.1.10 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: DATA.pm,v $
# Revision 1.1.1.10  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.9  2002/06/09  19:44:07  elwinter
# Changed reuired Perl version to 5.6.1.
#
# Revision 1.1.1.8  2002/05/23  13:07:10  elwinter
# Added get_content() method.
#
# Revision 1.1.1.7  2002/05/21  14:08:54  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.6  2002/05/21  11:51:25  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.5  2002/05/14  11:48:19  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/06  17:28:56  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  14:29:13  elwinter
# Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::DATA;

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
use VOTABLE::BINARY;
use VOTABLE::FITS;
use VOTABLE::TABLEDATA;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'DATA';

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

    # Construct the VOTABLE::DATA object from the XML::DOM object.
    if (not $this->_build_from_XMLDOM) {
	carp("Unable to build VOTABLE::$TAG_NAME object from " .
	     "XML::DOM::Element!");
	return(undef);
    }

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------

# get_content()

# Read the data from the resource specified by the enclosed elements.

sub get_content()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # String to hold the content of the data.
    my($content);

    #--------------------------------------------------------------------------

    # Only BINARY supported for now.
    if (not exists($this->{'BINARY'})) {
	carp('No BINARY found!');
	return(undef);
    }

    # Read the content.
    $content = $this->{'BINARY'}->get_content;

    # Return the contents.
    return($content);

}

#------------------------------------------------------------------------------

# Attribute accessor methods

#------------------------------------------------------------------------------

# Element accessor methods

#------------------------------------------------------------------------------

sub get_binary()
{
    my($this) = @_;
    if (exists($this->{'BINARY'})) {
	return($this->{'BINARY'});
    } else {
	return(undef);
    }
}

sub set_binary()
{

    # Save arguments.
    my($this, $votable_binary) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the new
    # VOTABLE::BINARY object.
    my($xmldom_element_binary);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the elements at the VOTABLE level.
    $this->{'BINARY'} = $votable_binary;

    #--------------------------------------------------------------------------

    # Link the elements at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new BINARY element.
    $xmldom_element_binary = $votable_binary->_get_XMLDOM;
    if (not $xmldom_element_binary) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this object currently has any BINARY, FITS, or TABLEDATA
    # elements among its children, remove them. Note that it should
    # have only one of any of them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FITS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the BINARY element to this element owner document.
    $xmldom_element_binary->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the BINARY element as the first child node of the DATA
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_binary,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_binary);
    }

    # Return the new element.
    return($votable_binary);

}

sub get_fits()
{
    my($this) = @_;
    if (exists($this->{'FITS'})) {
	return($this->{'FITS'});
    } else {
	return(undef);
    }
}

sub set_fits()
{

    # Save arguments.
    my($this, $votable_fits) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the new
    # VOTABLE::FITS object.
    my($xmldom_element_fits);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the elements at the VOTABLE level.
    $this->{'FITS'} = $votable_fits;

    #--------------------------------------------------------------------------

    # Link the elements at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new FITS element.
    $xmldom_element_fits = $votable_fits->_get_XMLDOM;
    if (not $xmldom_element_fits) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this object currently has any BINARY, FITS, or TABLEDATA
    # elements among its children, remove them. Note that it should
    # have only one of any of them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FITS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the FITS element to this element owner document.
    $xmldom_element_fits->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the FITS element as the first child node of the DATA
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_fits,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_fits);
    }

    # Return the new element.
    return($votable_fits);

}

sub get_tabledata()
{
    my($this) = @_;
    if (exists($this->{'TABLEDATA'})) {
	return($this->{'TABLEDATA'});
    } else {
	return(undef);
    }
}

sub set_tabledata()
{

    # Save arguments.
    my($this, $votable_tabledata) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Element object for the new
    # VOTABLE::TABLEDATA object.
    my($xmldom_element_tabledata);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the elements at the VOTABLE level.
    $this->{'TABLEDATA'} = $votable_tabledata;

    #--------------------------------------------------------------------------

    # Link the elements at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new TABLEDATA element.
    $xmldom_element_tabledata = $votable_tabledata->_get_XMLDOM;
    if (not $xmldom_element_tabledata) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this object currently has any BINARY, FITS, or TABLEDATA
    # elements among its children, remove them. Note that it should
    # have only one of any of them.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('FITS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the TABLEDATA element to this element owner document.
    $xmldom_element_tabledata->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # Attach the TABLEDATA element as the first child node of the DATA
    # element.
    if ($xmldom_element_this->hasChildNodes) {
	$xmldom_element_this->
	    insertBefore($xmldom_element_tabledata,
			 $xmldom_element_this->getFirstChild);
    } else {
	$xmldom_element_this->appendChild($xmldom_element_tabledata);
    }

    # Return the new element.
    return($votable_tabledata);

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

    # Reference to XML::DOM::Element object for current VOTABLE
    # object.
    my($xmldom_element_this);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New elements to add.
    my($votable_binary, $votable_fits, $votable_tabledata);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    #--------------------------------------------------------------------------

    # The DATA element can contain a BINARY element, OR a FITS
    # element, OR a TABLEDATA element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('BINARY', 0)) {

	# Make sure only one element was found.
	if (@xmldom_elements > 1) {
	    carp('Multiple BINARY elements!');
	    return(0);
	}

	# Create a new VOTABLE object for this element.
	$votable_binary = new VOTABLE::BINARY $xmldom_elements[0];
	if (not $votable_binary) {
	    carp('Unable to create VOTABLE::BINARY object!');
	    return(0);
	}
	$this->set_binary($votable_binary);

    } elsif (@xmldom_elements =
	     $xmldom_element_this->getElementsByTagName('FITS', 0)) {

	# Make sure only one element was found.
	if (@xmldom_elements > 1) {
	    carp('Multiple FITS elements!');
	    return(0);
	}

	# Create a new VOTABLE object for this element.
	$votable_fits = new VOTABLE::FITS $xmldom_elements[0];
	if (not $votable_fits) {
	    carp('Unable to create VOTABLE::FITS object!');
	    return(0);
	}
	$this->set_fits($votable_fits);

    } elsif (@xmldom_elements =
	     $xmldom_element_this->getElementsByTagName('TABLEDATA', 0)) {

	# Make sure only one element was found.
	if (@xmldom_elements > 1) {
	    carp('Multiple TABLEDATA elements!');
	    return(0);
	}

	# Create a new VOTABLE object for this element.
	$votable_tabledata = new VOTABLE::TABLEDATA $xmldom_elements[0];
	if (not $votable_tabledata) {
	    carp('Unable to create VOTABLE::TABLEDATA object!');
	    return(0);
	}
	$this->set_tabledata($votable_tabledata);

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
