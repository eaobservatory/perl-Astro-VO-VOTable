# TABLE.pm

=pod

=head1 NAME

VOTABLE::TABLE - VOTABLE TABLE XML element class

=head1 SYNOPSIS

 use VOTABLE::TABLE;

=head1 DESCRIPTION

This class implements the C<TABLE> element from the C<VOTABLE>
DTD. This is the primary element used for storing tables of data.

The C<TABLE> element is a Tier 4 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT TABLE (DESCRIPTION?, FIELD*, LINK*, DATA?)>
 <!ATTLIST TABLE
         ID ID #IMPLIED
         name CDATA #IMPLIED
         ref IDREF #IMPLIED
 >

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::TABLE> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::TABLE> object. Return C<undef> if an error occurs.

=head3 C<get_ID>

Return the value of the C<ID> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ID($id)>

Set the value of the C<ID> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_name>

Return the value of the C<name> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_name($name)>

Set the value of the C<name> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_ref>

Return the value of the C<ref> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ref($ref)>

Set the value of the C<ref> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success,or
C<undef> if an error occurs.

=head3 C<get_description>

Return the C<VOTABLE::DESCRIPTION> object for the C<DESCRIPTION>
element child of this C<TABLE> object. Return C<undef> if no
C<DESCRIPTION> element is found, or if an error occurs.

=head3 C<set_description($votable_description)>

Set the C<VOTABLE::DESCRIPTION> object for the C<DESCRIPTION> child
element of this C<TABLE> element to the specified object. Use C<undef>
as the argument to clear any existing instance of the element. Any
existing C<DESCRIPTION> child element is first removed. Return the new
C<DESCRIPTION> object on success, or C<undef> if an error occurs.

=head3 C<get_field>

Return a list of the C<VOTABLE::FIELD> objects for the C<FIELD>
elements which are the children of this C<TABLE> element. Return an
empty list if no C<FIELD> elements are found, or if an error occurs.

=head3 C<set_field(@votable_field)>

Set the C<FIELD> elements for this C<TABLE> element using the supplied
list of C<VOTABLE::FIELD> objects. Use an empty list as the argument
to clear any existing instances of the elements. Any previously
existing C<FIELD> elements are first removed. C<FIELD> elements are
stored in the C<TABLE> element in the same order as provided in the
C<@votable_field> array (this is important for tables with binary
data). Return the input list on success, or an empty list if an error
occurs.

=head3 C<get_link>

Return a list of the C<VOTABLE::LINK> objects for the C<LINK> elements
which are the children of this C<TABLE> element. Return an empty list
if no C<LINK> elements are found, or if an error occurs.

=head3 C<set_link(@votable_link)>

Set the C<LINK> elements for this C<TABLE> element using the supplied
list of C<VOTABLE::LINK> objects. Use an empty list as the argument to
clear any existing instances of the elements. Any previously existing
C<LINK> elements are first removed. Return the input list on success,
or an empty list if an error occurs.

=head3 C<get_data>

Return the C<VOTABLE::DATA> object for the C<DATA> element child of
this C<TABLE> object. Return C<undef> if no C<DATA> element is found,
or if an error occurs.

=head3 C<set_data($votable_data)>

Set the C<VOTABLE::DATA> object for the C<DATA> child element of this
C<TABLE> element to the specified object. Use C<undef> as the argument
to clear any existing instance of the element. Any existing C<DATA>
child element is first removed. Return the new C<DATA> object on
success, or C<undef> if an error occurs.

=head3 C<get_row($rownum)>

Return row C<$rownum> of the data, as an array of values. The array
elements should be interpreted in the same order as the C<FIELD>
elements in the C<TABLE>. Return an empty list if an error occurs.

=head3 C<set_row($rownum, @values)>

Set the contents of row C<$rownum> to the values provided in the
C<@values> array. Use an empty list as the argument to clear the
row. Return the new values on success, or an empty list on error.

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

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE> object I<always> has an underlying C<XML::DOM> object. As
long as the internal structure is manipulated only by the
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

C<VOTABLE>, C<VOTABLE::DATA>, C<VOTABLE::DESCRIPTION>,
C<VOTABLE::FIELD>, C<VOTABLE::LINK>, C<VOTABLE::RESOURCE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: TABLE.pm,v 1.1.1.21 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: TABLE.pm,v $
# Revision 1.1.1.21  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.20  2002/06/08  21:00:31  elwinter
# Fixed bugs in element insertion order.
#
# Revision 1.1.1.19  2002/06/06  19:23:24  elwinter
# Fixed bug in FIELD element insertion order.
#
# Revision 1.1.1.18  2002/06/05  13:49:16  elwinter
# Fixed bugs in binary handling and element ordering.
#
# Revision 1.1.1.17  2002/05/28  16:04:42  elwinter
# Added BINARY version of set_row().
#
# Revision 1.1.1.16  2002/05/28  15:15:11  elwinter
# Changed _get_binary_row() to use bytes reference.
#
# Revision 1.1.1.15  2002/05/24  15:08:23  elwinter
# Added TABLEDATA version of set_row().
#
# Revision 1.1.1.14  2002/05/23  20:27:18  elwinter
# Removed debugging code.
#
# Revision 1.1.1.13  2002/05/23  20:16:28  elwinter
# Added support for string length specified by arraysize attribute of FIELD
# elements.
# .,
#
# Revision 1.1.1.12  2002/05/23  19:35:57  elwinter
# Removed some debugging code.
#
# Revision 1.1.1.11  2002/05/23  19:34:19  elwinter
# Added support for simple BINARY elements in the DATA element.
#
# Revision 1.1.1.10  2002/05/23  13:12:04  elwinter
# Added get_row() method.
#
# Revision 1.1.1.9  2002/05/21  14:13:20  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.8  2002/05/21  13:49:09  elwinter
# Overhauled and updated documentation.
#
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
use 5.6.1;

# Turn on strict syntax checking.
use strict;

# Use enhanced diagnostic messages.
use diagnostics;

# Use enhanced warnings.
use warnings;

#------------------------------------------------------------------------------

# Set up the inheritance mechanism.
our @ISA = qw();

# Module version
our $VERSION = '0.03';

#------------------------------------------------------------------------------

# Specify external modules to use.

# Standard modules
use Carp;
use English;
use XML::DOM;

# Third-party modules

# Project modules
use VOTABLE::DATA;
use VOTABLE::DESCRIPTION;
use VOTABLE::FIELD;
use VOTABLE::LINK;

#------------------------------------------------------------------------------

# Class constants

# Name of XML tag for current class.
my($TAG_NAME) = 'TABLE';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@VALID_ATTRIBUTE_NAMES) = ('ID', 'name', 'ref');

# Hash to map VOTABLE datatype attributes (from FIELD elements) to
# equivalent format codes for the Perl subroutines pack() and
# unpack(), and the corresponding byte sizes.
my(%TYPE_MAP) =
    (
     boolean      => {code => 'a', size => 1},
     char         => {code => 'a', size => 1},
     double       => {code => 'd', size => 8},
     float        => {code => 'f', size => 4},
     int          => {code => 'l', size => 4},
     long         => {code => 'q', size => 8},
     short        => {code => 's', size => 2},
     unsignedByte => {code => 'C', size => 1},
     );

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
	    if (ref($options[0]) ne $XMLDOM_BASE) {
 		carp('Bad input class: ', ref($options[0]));
 		return(undef);
 	    }
	}
	($xmldom_element_this, %attributes) = @options;
	if ($xmldom_element_this) {
	    $tag_name = $xmldom_element_this->getTagName;
	    if ($tag_name ne $TAG_NAME) {
		carp("Invalid tag name: $tag_name");
		return(undef);
	    }
	}
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
	    carp("Unable to create $XMLDOM_BASE.");
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
	$attribute_name =~ s/-/_/;
	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";
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

# get_row()

# Fetch a single row from the data table and return an array
# containing its values.

sub get_row()
{

    # Save arguments.
    my($this, $rownum) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to underlying VOTABLE::DATA object.
    my($votable_data);

    # Row of results.
    my(@row);

    #--------------------------------------------------------------------------

    # Get the DATA, return if no data for this table yet.
    $votable_data = $this->get_data;
    if (not $votable_data) {
	carp('No DATA for TABLE.');
	return(());
    }

    # Extract the row based on the underlying data format.
    if ($votable_data->get_tabledata) {
	@row = $this->_get_tabledata_row($rownum);
    } elsif ($votable_data->get_binary) {
	@row = $this->_get_binary_row($rownum);
    } elsif ($votable_data->get_fits) {
	carp('Not supported yet!');
	return(());
    } else {
	carp('No data found!');
	return(());
    }

    # Return the row.
    return(@row);

}

#------------------------------------------------------------------------------

# set_row()

# Set a single row from the data table and return an array containing
# its values.

sub set_row()
{

    # Save arguments.
    my($this, $rownum, @values) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to underlying VOTABLE::DATA object.
    my($votable_data);

    #--------------------------------------------------------------------------

    # Get the DATA, return if no data for this table yet.
    $votable_data = $this->get_data;
    if (not $votable_data) {
	carp('No DATA for TABLE.');
	return(());
    }

    # Set the row based on the underlying data format.
    if ($votable_data->get_tabledata) {
	$this->_set_tabledata_row($rownum, @values);
    } elsif ($votable_data->get_binary) {
	$this->_set_binary_row($rownum, @values);
    } elsif ($votable_data->get_fits) {
	carp('Not supported yet!');
	return(());
    } else {
	carp('No data found!');
	return(());
    }

    # Return the row.
    return($this->get_row($rownum));

}

#------------------------------------------------------------------------------

# Attribute accessor methods

# Attribute values are stored in the underlying XML::DOM::Element
# object, and are accessed using the XML::DOM::Element getAttribute()
# and setAttribute() methods. The getAttribute() method returns an
# empty string ('') when the attribute has no value, so the return
# value must be checked for that, and set to undef if it is empty. The
# setAttribute() method will use the removeAttribute() method to clear
# the existing value if undef is passed as the new value of an
# attribute.

#------------------------------------------------------------------------------

sub get_ID()
{
    my($this) = @_;
    my($id);
    $id = $this->_get_XMLDOM->getAttribute('ID');
    $id = undef if (length($id) == 0);
    return($id);
}

sub set_ID()
{
    my($this, $id) = @_;
    if (defined($id)) {
	$this->_get_XMLDOM->setAttribute('ID', $id);
    } else {
	$this->_get_XMLDOM->removeAttribute('ID');
    }
    return($this->get_ID);
}

sub get_name()
{
    my($this) = @_;
    my($name);
    $name = $this->_get_XMLDOM->getAttribute('name');
    $name = undef if (length($name) == 0);
    return($name);
}

sub set_name()
{
    my($this, $name) = @_;
    if (defined($name)) {
	$this->_get_XMLDOM->setAttribute('name', $name);
    } else {
	$this->_get_XMLDOM->removeAttribute('name');
    }
    return($this->get_name);
}

sub get_ref()
{
    my($this) = @_;
    my($ref);
    $ref = $this->_get_XMLDOM->getAttribute('ref');
    $ref = undef if (length($ref) == 0);
    return($ref);
}

sub set_ref()
{
    my($this, $ref) = @_;
    if (defined($ref)) {
	$this->_get_XMLDOM->setAttribute('ref', $ref);
    } else {
	$this->_get_XMLDOM->removeAttribute('ref');
    }
    return($this->get_ref);
}

#------------------------------------------------------------------------------

# Element accessor methods

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

    # Link the objects at the VOTABLE level.
    if ($votable_description) {
	$this->{'DESCRIPTION'} = $votable_description;
    } else {
	delete($this->{'DESCRIPTION'});
    }

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If this TABLE element already has a DESCRIPTION element, remove
    # the DESCRIPTION element (assumed to be only 1).
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0);
    if (@xmldom_elements) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Connect the new element, if needed.
    if ($xmldom_element_description) {

	# Get the XML::DOM::Element for the new object.
	$xmldom_element_description = $votable_description->_get_XMLDOM;
	if (not $xmldom_element_description) {
	    carp("Unable to find $XMLDOM_BASE.");
	    return(undef);
	}

	# Attach the new object to the owner document for this object.
	$xmldom_element_description->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);

	# Add the DESCRIPTION element as the first child.
	if ($xmldom_element_this->hasChildNodes) {
	    $xmldom_element_this->
		insertBefore($xmldom_element_description,
			     $xmldom_element_this->getFirstChild);
	} else {
	    $xmldom_element_this->appendChild($xmldom_element_description);
	}

    }

    # Return the new object.
    return($this->get_description);

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

    # Link the objects at the VOTABLE level.
    if (@votable_field) {
	$this->{'FIELD'} = [@votable_field];
    } else {
	delete($this->{'FIELD'});
    }

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any FIELD elements exist for the this object, delete them.
    @xmldom_elements = $xmldom_element_this->getElementsByTagName('FIELD', 0);
    foreach $xmldom_element (@xmldom_elements) {
	$xmldom_element_this->removeChild($xmldom_element);
    }

    # Connect the new elements if needed.
    if (@votable_field) {

	# Attach the new objects to the owner document for this
	# object.
	foreach $votable_field (@votable_field) {
	    $xmldom_element_field = $votable_field->_get_XMLDOM;
	    $xmldom_element_field->
		setOwnerDocument($xmldom_element_this->getOwnerDocument);
	}

	# Insert the new FIELD elements as the first child elements of
	# this object after any DESCRIPTION. Otherwise, just add the
	# FIELD elements as the first children.
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the FIELD elements right after it. Otherwise,
	    # append the FIELD elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_field (reverse(@votable_field)) {
		    $xmldom_element_field = $votable_field->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_field,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_field (@votable_field) {
		    $xmldom_element_field = $votable_field->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_field);
		}
	    }

	} elsif ($xmldom_element_this->hasChildNodes) {

	    # No DESCRIPTION element found, so insert the FIELD
	    # elements as the first children.
	    foreach $votable_field (reverse(@votable_field)) {
		$xmldom_element_field = $votable_field->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_field,
				 $xmldom_element_this->getFirstChild);
	    }

	} else {

	    # No existing children, so the FIELDS become the first
	    # children.
	    foreach $votable_field (@votable_field) {
		$xmldom_element_field = $votable_field->_get_XMLDOM; 
		$xmldom_element_this->appendChild($xmldom_element_field);
	    }

	}

    }

    # Return the new objects.
    return($this->get_field);

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
    if (@votable_link) {
	$this->{'LINK'} = [@votable_link];
    } else {
	delete($this->{'LINK'});
    }

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any LINK elements exist for the this object, delete them.
    @xmldom_elements = $xmldom_element_this->getElementsByTagName('LINK', 0);
    foreach $xmldom_element (@xmldom_elements) {
	$xmldom_element_this->removeChild($xmldom_element);
    }

    # Connect the new elements if needed.
    if (@votable_link) {

	# Attach the new objects to the owner document for this
	# object.
	foreach $votable_link (@votable_link) {
	    $xmldom_element_link = $votable_link->_get_XMLDOM;
	    $xmldom_element_link->
		setOwnerDocument($xmldom_element_this->getOwnerDocument);
	}

	# Insert the new LINK elements as the first child elements of
	# this object after any DESCRIPTION or FIELD. Otherwise, just
	# add the LINK elements as the first children.
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('FIELD', 0)) {

	    # If the last FIELD element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append the
	    # LINK elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (reverse(@votable_link)) {
		    $xmldom_element_link = $votable_link->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link = $votable_link->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} elsif (@xmldom_elements =
		 $xmldom_element_this->
		 getElementsByTagName('DESCRIPTION', 0)) {

	    # If the DESCRIPTION element is not the last child, insert
	    # the new LINK elements right after it. Otherwise, append
	    # the new elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (reverse(@votable_link)) {
		    $xmldom_element_link = $votable_link->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link = $votable_link->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} elsif ($xmldom_element_this->hasChildNodes) {

	    # No DESCRIPTION or FIELD elements found, so insert the
	    # LINK elements as the first children.
	    foreach $votable_link (reverse(@votable_link)) {
		$xmldom_element_link = $votable_link->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_link,
				 $xmldom_element_this->getFirstChild);
	    }

	} else {

	    # No existing children, so the LINKS become the first
	    # children.
	    foreach $votable_link (@votable_link) {
		$xmldom_element_link = $votable_link->_get_XMLDOM; 
		$xmldom_element_this->appendChild($xmldom_element_link);
	    }

	}

    }

    # Return the new objects.
    return($this->get_link);

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
    if ($votable_data) {
	$this->{'DATA'} = $votable_data;
    } else {
	delete($this->{'DATA'});
    }

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this PARAM.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any DATA elements exist for the this object, delete them.
    @xmldom_elements = $xmldom_element_this->getElementsByTagName('DATA', 0);
    if (@xmldom_elements) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $xmldom_element_this->removeChild($xmldom_elements[$i]);
	}
    }

    # Connect the objects if needed.
    if ($votable_data) {

	# Get the underlying XML::DOM::Element for this DATA.
	$xmldom_element_data = $votable_data->_get_XMLDOM;

	# Attach to the current owner document.
	$xmldom_element_data->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);

	# Append the DATA to the TABLE.
	$xmldom_element_this->appendChild($votable_data->_get_XMLDOM);

    }

    # Return the new objects.
    return($this->get_data);

}

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

    # Reference to new VOTABLE::DESCRIPTION object.
    my($votable_description);

    # Reference to one and all VOTABLE::LINK objects.
    my($votable_link);
    my(@votable_link);

    # Reference to one and all VOTABLE::FIELD objects.
    my($votable_field);
    my(@votable_field);

    # Reference to new VOTABLE::DATA object.
    my($votable_data);

    # Array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    #--------------------------------------------------------------------------

    # DESCRIPTION

    # Get a list of all DESCRIPTION elements.
    if (@xmldom_elements = $xmldom_element_this->
	getElementsByTagName('DESCRIPTION', 0)) {
	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
	$this->set_description($votable_description);
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

    # DATA

    # Get a list of all DATA elements.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DATA', 0)) {
	$votable_data = new VOTABLE::DATA $xmldom_elements[0];
	$this->set_data($votable_data);
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

#------------------------------------------------------------------------------

# _get_tabledata_row()

# Fetch the specified row of the table assuming it is held in a
# TABLEDATA element. Return the results as an array, or an empty list
# if an error occurs.

sub _get_tabledata_row()
{

    # Save arguments.
    my($this, $rownum) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to DATA element for this TABLE.
    my($votable_data);

    # Reference to TABLEDATA element for this DATA.
    my($votable_tabledata);

    # Array to hold row contents.
    my(@row);

    #--------------------------------------------------------------------------

    # Get the DATA, return if no data for this table yet.
    $votable_data = $this->get_data;

    # Get the TABLEDATA.
    $votable_tabledata = $votable_data->get_tabledata;

    # Get the row values as an array.
    @row = $votable_tabledata->get_row($rownum);

    # Return the row.
    return(@row);

}

#------------------------------------------------------------------------------

# _set_tabledata_row()

# Set the specified row of the table assuming it is held in a
# TABLEDATA element. Return the results as an array, or an empty list
# if an error occurs.

sub _set_tabledata_row()
{

    # Save arguments.
    my($this, $rownum, @values) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to DATA element for this TABLE.
    my($votable_data);

    # Reference to TABLEDATA element for this DATA.
    my($votable_tabledata);

    #--------------------------------------------------------------------------

    # Get the DATA, return if no data for this table yet.
    $votable_data = $this->get_data;

    # Get the TABLEDATA.
    $votable_tabledata = $votable_data->get_tabledata;

    # Set the row values.
    $votable_tabledata->set_row($rownum, @values);

    # Return the row.
    return(@values);

}

#------------------------------------------------------------------------------

# _get_binary_row()

# Fetch the specified row of the table assuming it is held in a BINARY
# element. Return the results as an array, or an empty list if an
# error occurs.

sub _get_binary_row()
{

    # Save arguments.
    my($this, $rownum) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to DATA element for this TABLE.
    my($votable_data);

    # Reference to BINARY element for this DATA.
    my($votable_binary);

    # String of bytes for the BINARY.
    my($bytes);

    # List of FIELD elements for this TABLE.
    my(@votable_field);

    # Array to hold row contents.
    my(@row);

    # Format string for record, usable in pack() and unpack().
    my($record_format);

    # Record size (bytes).
    my($record_size);

    # VOTABLE datatype of current field.
    my($datatype);

    # VOTABLE arraysize of current field.
    my($arraysize);

    # Byte offset of current record in byte stream.
    my($offset);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get the DATA, return if no data for this table yet.
    $votable_data = $this->get_data;

    # Get the BINARY.
    $votable_binary = $votable_data->get_binary;

    # Get the string of bytes.
    $bytes = $votable_binary->get_content;

    # Get a list of fields for this table.
    @votable_field = $this->get_field;

    # Compute the record format and size for this table.
    $record_format = '';
    $record_size = 0;
    for ($i = 0; $i < @votable_field; $i++) {
	$datatype = $votable_field[$i]->get_datatype;
	$arraysize = $votable_field[$i]->get_arraysize;
	if ($arraysize) {
	    $record_format .= $TYPE_MAP{$datatype}{code} . $arraysize;
	    $record_size += $TYPE_MAP{$datatype}{size} * $arraysize;
	} else {
	    $record_format .= $TYPE_MAP{$datatype}{code};
	    $record_size += $TYPE_MAP{$datatype}{size};
	}
    }

    # Compute the offset for the desired record.
    $offset = $rownum * $record_size;

    # Extract the record.
    @row = unpack("x$offset $record_format", $bytes);

    # Return the row.
    return(@row);

}

#------------------------------------------------------------------------------

# _set_binary_row()

# Set the specified row of the table assuming it is held in a BINARY
# element. Return the results as an array, or an empty list if an
# error occurs.

sub _set_binary_row()
{

    # Save arguments.
    my($this, $rownum, @values) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to DATA element for this TABLE.
    my($votable_data);

    # Reference to BINARY element for this DATA.
    my($votable_binary);

    # String of bytes for the BINARY.
    my($bytes);

    # List of FIELD elements for this TABLE.
    my(@votable_field);

    # Array to hold row contents.
    my(@row);

    # Format string for record, usable in pack() and unpack().
    my($record_format);

    # Record size (bytes).
    my($record_size);

    # VOTABLE datatype of current field.
    my($datatype);

    # VOTABLE arraysize of current field.
    my($arraysize);

    # Byte offset of current record in byte stream.
    my($offset);

    # Byte string for current row.
    my($row_bytes);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get the DATA, return if no data for this table yet.
    $votable_data = $this->get_data;

    # Get the BINARY.
    $votable_binary = $votable_data->get_binary;

    # Get the reference to the string of bytes.
    $bytes = $votable_binary->get_content;

    # Get a list of fields for this table.
    @votable_field = $this->get_field;

    # Compute the record format and size for this table.
    $record_format = '';
    $record_size = 0;
    for ($i = 0; $i < @votable_field; $i++) {
	$datatype = $votable_field[$i]->get_datatype;
	$arraysize = $votable_field[$i]->get_arraysize;
	if ($arraysize) {
	    $record_format .= $TYPE_MAP{$datatype}{code} . $arraysize;
	    $record_size += $TYPE_MAP{$datatype}{size} * $arraysize;
	} else {
	    $record_format .= $TYPE_MAP{$datatype}{code};
	    $record_size += $TYPE_MAP{$datatype}{size};
	}
    }

    # Compute the offset for the desired record.
    $offset = $rownum * $record_size;

    # Compute the byte string for the current row.
    $row_bytes = pack($record_format, @values);

    # Update the record.
    substr($bytes, $offset) = $row_bytes;
    $votable_binary->set_content($bytes);

    # Return the row.
    return(@row);

}

#******************************************************************************
1;
__END__
