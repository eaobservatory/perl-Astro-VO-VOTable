# TABLE.pm

=pod

=head1 NAME

VOTABLE::TABLE - VOTABLE TABLE XML element class

=head1 SYNOPSIS

C<use VOTABLE::TABLE;>

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

Set the value of the C<ID> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_name>

Return the value of the C<name> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_name($name)>

Set the value of the C<name> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_ref>

Return the value of the C<ref> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ref($ref)>

Set the value of the C<ref> attribute to the specified value. Return
the new value of the attribute on success,or C<undef> if an error
occurs.

=head3 C<get_description>

Return the C<VOTABLE::DESCRIPTION> object for the C<DESCRIPTION>
element child of this C<TABLE> object. Return C<undef> if no
C<DESCRIPTION> element is found, or if an error occurs.

=head3 C<set_description($votable_description)>

Set the C<VOTABLE::DESCRIPTION> object for the C<DESCRIPTION> child
element of this C<TABLE> element to the specified object. Any existing
C<DESCRIPTION> child element is first removed. Return the new
C<DESCRIPTION> object on success, or C<undef> if an error occurs.

=head3 C<get_field>

Return a list of the C<VOTABLE::FIELD> objects for the C<FIELD>
elements which are the children of this C<TABLE> element. Return an
empty list if no C<FIELD> elements are found, or if an error occurs.

=head3 C<set_field(@votable_field)>

Set the C<FIELD> elements for this C<TABLE> element using the supplied
list of C<VOTABLE::FIELD> objects. Any previously existing C<FIELD>
elements are first removed. Return the input list on success, or an
empty list if an error occurs.

=head3 C<get_link>

Return a list of the C<VOTABLE::LINK> objects for the C<LINK> elements
which are the children of this C<TABLE> element. Return an empty list
if no C<LINK> elements are found, or if an error occurs.

=head3 C<set_link(@votable_link)>

Set the C<LINK> elements for this C<TABLE> element using the supplied
list of C<VOTABLE::LINK> objects. Any previously existing C<LINK>
elements are first removed. Return the input list on success, or an
empty list if an error occurs.

=head3 C<get_data>

Return the C<VOTABLE::DATA> object for the C<DATA> element child of
this C<TABLE> object. Return C<undef> if no C<DATA> element is found,
or if an error occurs.

=head3 C<set_data($votable_data)>

Set the C<VOTABLE::DATA> object for the C<DATA> child element of this
C<TABLE> element to the specified object. Any existing C<DATA> child
element is first removed. Return the new C<DATA> object on success, or
C<undef> if an error occurs.

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

C<VOTABLE>, C<VOTABLE::DATA>, C<VOTABLE::DESCRIPTION>,
C<VOTABLE::FIELD>, C<VOTABLE::LINK>, C<VOTABLE::RESOURCE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: TABLE.pm,v 1.1.1.9 2002/05/21 14:13:20 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: TABLE.pm,v $
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
use VOTABLE::DATA;
use VOTABLE::DESCRIPTION;
use VOTABLE::FIELD;
use VOTABLE::LINK;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'TABLE';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'name', 'ref');

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

    # Construct the VOTABLE::TABLE object from the XML::DOM object.
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
    $this->_get_XMLDOM->getAttribute('ID');
}

sub set_ID()
{
    my($this, $id) = @_;
    $this->_get_XMLDOM->setAttribute('ID', $id);
    return($this->get_ID);
}

sub get_name()
{
    my($this) = @_;
    $this->_get_XMLDOM->getAttribute('name');
}

sub set_name()
{
    my($this, $name) = @_;
    $this->_get_XMLDOM->setAttribute('name', $name);
    return($this->get_name);
}

sub get_ref()
{
    my($this) = @_;
    $this->_get_XMLDOM->getAttribute('ref');
}

sub set_ref()
{
    my($this, $ref) = @_;
    $this->_get_XMLDOM->setAttribute('ref', $ref);
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
    $this->{'DESCRIPTION'} = $votable_description;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_description =
	$votable_description->_get_XMLDOM;
    if (not $xmldom_element_description) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this TABLE element already has a DESCRIPTION element, remove
    # the DESCRIPTION element.
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0);
    if (@xmldom_elements) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the new object to the owner document for this object.
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
    # $this is a reference to the current object.
    # @votable_link is a list of references to the VOTABLE::LINKs to
    # add to this object.
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
    $this->{'LINK'} = [@votable_link];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any LINK elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {
	    foreach $xmldom_element (@xmldom_elements) {
		$xmldom_element_this->removeChild($xmldom_element);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::LINKs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this object.
    foreach $votable_link (@votable_link) {
	$xmldom_element_link = $votable_link->_get_XMLDOM;
	$xmldom_element_link->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # LINK elements as the first child elements of this object after
    # any DESCRIPTION. Otherwise, just add the LINK elements as the
    # first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the LINK elements right after it. Otherwise,
	    # append the LINK elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link = $votable_link->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_link,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_link (@votable_link) {
		    $xmldom_element_link = $votable_link->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_link);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the LINK
	    # elements as the first children.
	    foreach $votable_link (@votable_link) {
		$xmldom_element_link = $votable_link->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_link,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the LINKS become the first
	# children.
	foreach $votable_link (@votable_link) {
	    $xmldom_element_link = $votable_link->_get_XMLDOM; 
	    $xmldom_element_this->appendChild($xmldom_element_link);
	}

    }

    # Return the new objects.
    return($this->get_link);

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
    # $this is a reference to the current object.
    # @votable_field is a list of references to the VOTABLE::FIELDs to
    # add to this object.
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
    $this->{'FIELD'} = [@votable_field];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any FIELD elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('FIELD', 0)) {
	    foreach $xmldom_element (@xmldom_elements) {
		$xmldom_element_this->removeChild($xmldom_element);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::FIELDs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this object.
    foreach $votable_field (@votable_field) {
	$xmldom_element_field = $votable_field->_get_XMLDOM;
	$xmldom_element_field->setOwnerDocument($xmldom_element_this->
						getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # FIELD elements as the first child elements of this object after
    # any LINK, then any DESCRIPTION. Otherwise, just add the FIELD
    # elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {

	    # If this LINK element is not the last child, insert the
	    # FIELD elements right after it. Otherwise, append the
	    # FIELD elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_field (@votable_field) {
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

	} elsif (@xmldom_elements = $xmldom_element_this->
		 getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the FIELD elements right after it. Otherwise,
	    # append the FIELD elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_field (@votable_field) {
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

	} else {

	    # No DESCRIPTION or LINK element found, so insert the
	    # FIELD elements as the first children.
	    foreach $votable_field (@votable_field) {
		$xmldom_element_field = $votable_field->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_field,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the FIELDS become the first
	# children.
	foreach $votable_field (@votable_field) {
	    $xmldom_element_field = $votable_field->_get_XMLDOM; 
	    $xmldom_element_this->appendChild($xmldom_element_field);
	}

    }

    # Return the new objects.
    return($this->get_field);

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
    # $this is a reference to the current object.
    # @votable_data is a list of references to the VOTABLE::DATAs to
    # add to this object.
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
    $this->{'DATA'} = $votable_data;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this PARAM.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get the underlying XML::DOM::Element for this DATA.
    $xmldom_element_data = $votable_data->_get_XMLDOM;

    # If any DATA elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DATA', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::DATA to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::TABLE.
    $xmldom_element_data->setOwnerDocument($xmldom_element_this->
					   getOwnerDocument);

    # Append the DATA to the TABLE.
    $xmldom_element_this->appendChild($votable_data->_get_XMLDOM);

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
