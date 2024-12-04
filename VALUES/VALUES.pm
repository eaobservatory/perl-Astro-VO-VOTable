# VALUES.pm

=pod

=head1 NAME

VOTABLE::VALUES - VOTABLE VALUES XML element class

=head1 SYNOPSIS

C<use VOTABLE::VALUES;>

=head1 DESCRIPTION

This class implements the C<VALUES> element from the C<VOTABLE>
DTD. This element is used to store descriptive values about other data
items, such as minimum and maximum allowed values, and options for
enumerated values.

The C<VALUES> element is a Tier 2 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT VALUES (MIN?, MAX?, OPTION*)>
 <!ATTLIST VALUES
         ID ID #IMPLIED
         type (legal | actual) "legal"
         null CDATA #IMPLIED
         invalid (yes | no) "no"
 >

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::VALUES> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::VALUES> object. Return C<undef> if an error occurs.

=head3 C<get_ID>

Return the value of the C<ID> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ID($id)>

Set the value of the C<ID> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_invalid>

Return the value of the C<invalid> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_invalid($invalid)>

Set the value of the C<invalid> attribute to the specified
value. Return the new value of the attribute on success, or C<undef>
if an error occurs.

=head3 C<get_null>

Return the value of the C<null> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_null($null)>

Set the value of the C<null> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_type>

Return the value of the C<type> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_type($type)>

Set the value of the C<type> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_max>

Return the C<VOTABLE::MAX> object for the C<MAX> element child of this
C<VALUES> object. Return C<undef> if no C<MAX> element is found, or if
an error occurs.

=head3 C<set_max($votable_max)>

Set the C<VOTABLE::MAX> object for the C<MAX> child element of this
C<VALUES> element to the specified object. Any existing C<MAX> child
element is first removed. Return the new C<MAX> object on success, or
C<undef> if an error occurs.

=head3 C<get_min>

Return the C<VOTABLE::MIN> object for the C<MIN> element child of this
C<VALUES> object. Return C<undef> if no C<MIN> element is found, or if
an error occurs.

=head3 C<set_min($votable_min)>

Set the C<VOTABLE::MIN> object for the C<MIN> child element of this
C<VALUES> element to the specified objects. Any existing C<MIN> child
element is first removed. Return the new C<MIN> object on success, or
C<undef> if an error occurs.

=head3 C<get_option>

Return a list of the C<VOTABLE::OPTION> objects for the C<OPTION>
element children of this C<VALUES> object. Return an empty list if no
C<OPTION> elements are found, or if an error occurs.

=head3 C<set_option(@votable_option)>

Set the C<VOTABLE::OPTION> objects for the C<OPTION> child elements of
this C<VALUES> element to the specified objects. Any existing
C<OPTION> child elements are first removed. Return the new C<OPTION>
objects on success, or an empty list if an error occurs.

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

C<VOTABLE>, C<VOTABLE::FIELD>, C<VOTABLE::MAX>, C<VOTABLE::MIN>,
C<VOTABLE::OPTION>, C<VOTABLE::PARAM>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: VALUES.pm,v 1.1.1.14 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: VALUES.pm,v $
# Revision 1.1.1.14  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.13  2002/06/09  19:55:36  elwinter
# Changed required Perl version to 5.6.1.
#
# Revision 1.1.1.12  2002/06/08  21:05:55  elwinter
# Fixed bug in element insertion order.
#
# Revision 1.1.1.11  2002/05/21  14:14:37  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.10  2002/05/21  13:51:32  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.9  2002/05/14  17:44:35  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.8  2002/05/14  17:15:18  elwinter
# Fixed nextNext.
#
# Revision 1.1.1.7  2002/05/09  14:36:52  elwinter
# Fixed code in _build_from_XMLDOM().
#
# Revision 1.1.1.6  2002/05/08  13:01:08  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:34:11  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/06  17:31:54  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/28  19:40:18  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::VALUES;

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
use VOTABLE::MAX;
use VOTABLE::MIN;
use VOTABLE::OPTION;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'VALUES';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'invalid', 'null', 'type');

# List of valid values for the 'invalid' attribute.
my(@valid_invalids) = ('no', 'yes');

# List of valid values for the 'type' attribute.
my(@valid_types) = ('actual', 'legal');

#------------------------------------------------------------------------------

# Class variables.

# This object is used to access the factory methods in the
# XML::DOM::Document class. Assume it does not fail (for now).
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

    # Construct the VOTABLE::VALUES object from the XML::DOM object.
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

sub get_ID()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('ID'));
}

sub set_ID()
{
    my($this, $id) = @_;
    $this->_get_XMLDOM->setAttribute('ID', $id);
    return($this->get_ID);
}

sub get_invalid()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('invalid'));
}

sub set_invalid()
{
    my($this, $invalid) = @_;
    if (not grep(/$invalid/, @valid_invalids)) {
	carp("Invalid $TAG_NAME 'invalid' attribute value: $invalid!");
	return(undef);
    }
    $this->_get_XMLDOM->setAttribute('invalid', $invalid);
    return($this->get_invalid);
}

sub get_null()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('null'));
}

sub set_null()
{
    my($this, $null) = @_;
    $this->_get_XMLDOM->setAttribute('null', $null);
    return($this->get_null);
}

sub get_type()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('type'));
}

sub set_type()
{
    my($this, $type) = @_;
    if (not grep(/$type/, @valid_types)) {
	carp("Invalid $TAG_NAME 'type' attribute value: $type!");
	return(undef);
    }
    $this->_get_XMLDOM->setAttribute('type', $type);
    return($this->get_type);
}

#------------------------------------------------------------------------------

# Element accessor methods

#------------------------------------------------------------------------------

sub get_max()
{
    my($this) = @_;
    if (exists($this->{'MAX'})) {
	return($this->{'MAX'});
    } else {
	return(undef);
    }
}

sub set_max()
{

    # Save arguments.
    # $this is a reference to the current object.
    # $votable_max is a reference to the VOTABLE::MAX object to add to
    # the current object.
    my($this, $votable_max) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::VALUES.
    my($xmldom_element_this);

    # Reference to XML::DOM::Element object for the new VOTABLE::MAX
    # object.
    my($xmldom_element_max);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Make sure a valid VOTABLE::MAX was supplied.
    if (not $votable_max) {
	carp('Undefined VOTABLE::MAX!');
	return(undef);
    }
    if (ref($votable_max) ne 'VOTABLE::MAX') {
	carp('Not a VOTABLE::MAX!');
	return(undef);
    }

    # Link the objects at the VOTABLE level.
    $this->{'MAX'} = $votable_max;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this VALUES.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new MAX.
    $xmldom_element_max = $votable_max->_get_XMLDOM;
    if (not $xmldom_element_max) {
	carp('Unable to find XML::DOM::Element for VOTABLE::MAX!');
	return(undef);
    }

    # Delete any existing MAX.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('MAX', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::MAX to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::VALUES.
    $xmldom_element_max->setOwnerDocument($xmldom_element_this->
					  getOwnerDocument);

    # If any children exist for this VOTABLE::VALUES, insert the new
    # MAX as the first child _after_ any existing MIN. Otherwise, just
    # add the MAX as the first child.
    if ($xmldom_element_this->hasChildNodes) {

	# Check to see if there are any MIN elements.
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('MIN', 0)) {

	    # If this MIN element is not the last child, insert the
	    # MAX element right after it. Otherwise, append the MAX
	    # element.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		$xmldom_element_this->
		    insertBefore($xmldom_element_max,
				 $xmldom_elements[0]->getNextSibling);
	    } else {
		$xmldom_element_this->appendChild($xmldom_element_max);
	    }

	} else {

	    # No MIN element found, so insert the MAX element as the
	    # first child.
	    $xmldom_element_this->
		insertBefore($xmldom_element_max,
			     $xmldom_element_this->getFirstChild);

	}

    } else {

	# No existing children, so this MAX becomes the first child.
	$xmldom_element_this->appendChild($xmldom_element_max);

    }

    # Return the new object.
    return($this->get_max);

}

sub get_min()
{
    my($this) = @_;
    if (exists($this->{'MIN'})) {
	return($this->{'MIN'});
    } else {
	return(undef);
    }
}

sub set_min()
{

    # Save arguments.
    # $this is a reference to the current object.
    # $votable_min is a reference to the VOTABLE::MIN object to add to
    # the current object.
    my($this, $votable_min) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::VALUES.
    my($xmldom_element_this);

    # Reference to XML::DOM::Element object for the new VOTABLE::MIN
    # object.
    my($xmldom_element_min);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Make sure a valid VOTABLE::MIN was supplied.
    if (not $votable_min) {
	carp('Undefined VOTABLE::MIN!');
	return(undef);
    }
    if (ref($votable_min) ne 'VOTABLE::MIN') {
	carp('Not a VOTABLE::MIN!');
	return(undef);
    }

    # Link the objects at the VOTABLE level.
    $this->{'MIN'} = $votable_min;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this VALUES.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new MIN.
    $xmldom_element_min = $votable_min->_get_XMLDOM;
    if (not $xmldom_element_min) {
	carp('Unable to find XML::DOM::Element for VOTABLE::MIN!');
	return(undef);
    }

    # Delete any existing MIN.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('MIN', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::MIN to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::VALUES.
    $xmldom_element_min->setOwnerDocument($xmldom_element_this->
					  getOwnerDocument);

    # If any children exist for this VOTABLE::VALUES, insert the new
    # MIN as the first child. Otherwise, just add the MIN as the first
    # child.
    if ($xmldom_element_this->hasChildNodes) {

	# Insert MIN as the first child.
	$xmldom_element_this->
	    insertBefore($xmldom_element_min,
			 $xmldom_element_this->getFirstChild);

    } else {

	# No existing children, so this MIN becomes the first child.
	$xmldom_element_this->appendChild($xmldom_element_min);

    }

    # Return the new object.
    return($this->get_min);

}

sub get_option()
{
    my($this) = @_;
    if (exists($this->{'OPTION'})) {
	return(@{$this->{'OPTION'}});
    } else {
	return(());
    }
}

sub set_option()
{

    # Save arguments.
    # $this is a reference to the current object.
    # @votable_option is a list of references to the VOTABLE::OPTIONs
    # to add to the current VALUES.
    my($this, @votable_option) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to the XML::DOM::Element object for this
    # VOTABLE::VALUES.
    my($xmldom_element_this);

    # Reference to a single new VOTABLE::OPTION.
    my($votable_option);

    # Reference to XML::DOM::Element object for the current
    # VOTABLE::OPTION object.
    my($xmldom_element_option);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Make sure a valid list of VOTABLE::OPTIONs was supplied.
    if (not @votable_option) {
	carp('Empty VOTABLE::OPTION list!');
	return(());
    }
    foreach $votable_option (@votable_option) {
	if (not $votable_option) {
	    carp('Undefined VOTABLE::OPTION!');
	    return(());
	}
	if (ref($votable_option) ne 'VOTABLE::OPTION') {
	    carp('Not a VOTABLE::OPTION!');
	    return(());
	}
    }

    # Link the objects at the VOTABLE level.
    $this->{'OPTION'} = [@votable_option];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this VALUES.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any OPTION elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('OPTION', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::OPTIONs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::VALUES.
    for ($i = 0; $i <= $#votable_option; $i++) {
	$xmldom_element_option = $votable_option[$i]->_get_XMLDOM;
	$xmldom_element_option->setOwnerDocument($xmldom_element_this->
						 getOwnerDocument);
    }

    # If any children exist for this VOTABLE::VALUES, insert the new
    # OPTIONs as the first children _after_ any existing MAX. If there
    # are no MAX elements, check for MIN elements and handle them
    # similarly. Otherwise, just add the OPTIONs as the first
    # children.
    if ($xmldom_element_this->hasChildNodes) {

	# Check to see if there are any MAX elements, then MIN
	# elements.
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('MAX', 0)) {

	    # If this MAX element is not the last child, insert the
	    # OPTION elements right after it. Otherwise, append the
	    # OPTION elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_option (reverse(@votable_option)) {
		    $xmldom_element_this->
			insertBefore($votable_option->_get_XMLDOM,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_option (@votable_option) {
		    $xmldom_element_this->
			appendChild($votable_option->_get_XMLDOM);
		}
	    }

	} elsif (@xmldom_elements =
		 $xmldom_element_this->getElementsByTagName('MIN', 0)) {

	    # If this MIN element is not the last child, insert the
	    # OPTION elements right after it. Otherwise, append the
	    # OPTION elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_option (reverse(@votable_option)) {
		    $xmldom_element_this->
			insertBefore($votable_option->_get_XMLDOM,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_option (@votable_option) {
		    $xmldom_element_this->
			appendChild($votable_option->_get_XMLDOM);
		}
	    }

	} else {

	    # No MIN or MAX elements, so insert as the first children.
	    foreach $votable_option (reverse(@votable_option)) {
		$xmldom_element_this->
		    insertBefore($votable_option->_get_XMLDOM,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No children, so these OPTIONs are the first.
	foreach $votable_option (@votable_option) {
	    $xmldom_element_this->appendChild($votable_option->_get_XMLDOM);
	}

    }

    # Return the new objects.
    return($this->get_option);

}

#------------------------------------------------------------------------------

# PCDATA content accessor methods

#------------------------------------------------------------------------------

# Internal methods.

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

    # Single XML::DOM::Element.
    my($xmldom_element);

    # References to new VOTABLE objects.
    my($votable_min);
    my($votable_max);
    my($votable_option);

    # Array of new VOTABLE::OPTIONs.
    my(@votable_option);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    #--------------------------------------------------------------------------

    # MIN

    # The current element should contain at most a single MIN element.
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('MIN', 0);
    if (@xmldom_elements > 1) {
	carp('Multiple MIN elements!');
	return(0);
    }
    if (@xmldom_elements) {
	$votable_min = new VOTABLE::MIN $xmldom_elements[0];
	$this->set_min($votable_min);
    }

    #--------------------------------------------------------------------------

    # MAX

    # The current element should contain at most a single MAX element.
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('MAX', 0);
    if (@xmldom_elements > 1) {
	carp('Multiple MAX elements!');
	return(0);
    }
    if (@xmldom_elements) {
	$votable_max = new VOTABLE::MAX $xmldom_elements[0];
	$this->set_max($votable_max);
    }

    #--------------------------------------------------------------------------

    # OPTION

    # Any number of OPTIONs are allowed.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('OPTION', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $votable_option = new VOTABLE::OPTION $xmldom_element;
	    push(@votable_option, $votable_option);
	}
	$this->set_option(@votable_option);
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
