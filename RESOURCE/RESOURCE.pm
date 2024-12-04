# RESOURCE.pm

=pod

=head1 NAME

VOTABLE::RESOURCE - VOTABLE RESOURCE XML element class

=head1 SYNOPSIS

C<use VOTABLE::RESOURCE;>

=head1 DESCRIPTION

This class implements the C<RESOURCE> element from the C<VOTABLE>
DTD. This element is the high-level container for data resources
within the VOTABLE framework.

The C<RESOURCE> element is a Tier 5 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT RESOURCE (DESCRIPTION?, INFO*, COOSYS*, PARAM*, LINK*, 
      TABLE*, RESOURCE*)>
 <!ATTLIST RESOURCE
         name CDATA #IMPLIED
         ID ID #IMPLIED
         type (results | meta) "results"
 >

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::RESOURCE> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::RESOURCE> object. Return C<undef> if an error occurs.

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

=head3 C<get_type>

Return the value of the C<type> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_type($type)>

Set the value of the C<type> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_description>

Return the C<VOTABLE::DESCRIPTION> object for the C<DESCRIPTION>
element child of this C<RESOURCE> object. Return C<undef> if no
C<DESCRIPTION> element is found, or if an error occurs.

=head3 C<set_description($votable_description)>

Set the C<VOTABLE::DESCRIPTION> object for the C<DESCRIPTION> child
element of this C<RESOURCE> element to the specified object. Any
existing C<DESCRIPTION> child element is first removed. Return the new
C<DESCRIPTION> object on success, or C<undef> if an error occurs.

=head3 C<get_info>

Return a list of the C<VOTABLE::INFO> objects for the C<INFO> elements
which are the children of this C<RESOURCE> element. Return an empty
list if no C<INFO> elements are found, or if an error occurs.

=head3 C<set_info(@votable_info)>

Set the C<INFO> elements for this C<RESOURCE> element using the
supplied list of C<VOTABLE::INFO> objects. Any previously existing
C<INFO> elements are first removed. Return the input list on success,
or an empty list if an error occurs.

=head3 C<get_coosys>

Return a list of the C<VOTABLE::COOSYS> objects for the C<COOSYS>
elements which are the children of this C<RESOURCE> element. Return an
empty list if no C<COOSYS> elements are found, or if an error occurs.

=head3 C<set_coosys(@votable_coosys)>

Set the C<COOSYS> elements for this C<RESOURCE> element using the
supplied list of C<VOTABLE::COOSYS> objects. Any previously existing
C<COOSYS> elements are first removed. Return the input list on
success, or an empty list if an error occurs.

=head3 C<get_param>

Return a list of the C<VOTABLE::PARAM> objects for the C<PARAM>
elements which are the children of this C<RESOURCE> element. Return an
empty list if no C<PARAM> elements are found, or if an error occurs.

=head3 C<set_param(@votable_param)>

Set the C<PARAM> elements for this C<RESOURCE> element using the
supplied list of C<VOTABLE::PARAM> objects. Any previously existing
C<PARAM> elements are first removed. Return the input list on success,
or an empty list if an error occurs.

=head3 C<get_link>

Return a list of the C<VOTABLE::LINK> objects for the C<LINK> elements
which are the children of this C<RESOURCE> element. Return an empty
list if no C<LINK> elements are found, or if an error occurs.

=head3 C<set_link(@votable_link)>

Set the C<LINK> elements for this C<RESOURCE> element using the
supplied list of C<VOTABLE::LINK> objects. Any previously existing
C<LINK> elements are first removed. Return the input list on success,
or an empty list if an error occurs.

=head3 C<get_table>

Return a list of the C<VOTABLE::TABLE> objects for the C<TABLE>
elements which are the children of this C<RESOURCE> element. Return an
empty list if no C<TABLE> elements are found, or if an error occurs.

=head3 C<set_table(@votable_table)>

Set the C<TABLE> elements for this C<RESOURCE> element using the
supplied list of C<VOTABLE::TABLE> objects. Any previously existing
C<TABLE> elements are first removed. Return the input list on success,
or an empty list if an error occurs.

=head3 C<get_resource>

Return a list of the C<VOTABLE::RESOURCE> objects for the C<RESOURCE>
elements which are the children of this C<RESOURCE> element. Return an
empty list if no C<RESOURCE> elements are found, or if an error
occurs.

=head3 C<set_resource(@votable_resource)>

Set the C<RESOURCE> elements for this C<RESOURCE> element using the
supplied list of C<VOTABLE::RESOURCE> objects. Any previously existing
C<RESOURCE> elements are first removed. Return the input list on
success, or an empty list if an error occurs.

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

C<VOTABLE>, C<VOTABLE::COOSYS>, C<VOTABLE::DESCRIPTION>,
C<VOTABLE::INFO>, C<VOTABLE::LINK>, C<VOTABLE::PARAM>,
C<VOTABLE::TABLE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: RESOURCE.pm,v 1.1.1.14 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: RESOURCE.pm,v $
# Revision 1.1.1.14  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.13  2002/06/09  19:52:55  elwinter
# Changed required Perl version to 5.6.1.
#
# Revision 1.1.1.12  2002/06/08  20:56:40  elwinter
# Fixed bugs in element insertion order.
#
# Revision 1.1.1.11  2002/05/21  14:12:47  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.10  2002/05/21  13:48:17  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.9  2002/05/14  17:35:33  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.8  2002/05/14  17:19:00  elwinter
# Fixed nextSibling.
#
# Revision 1.1.1.7  2002/05/14  17:09:02  elwinter
# Filled in _build_from_XMLDOM().
#
# Revision 1.1.1.6  2002/05/14  14:12:07  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  17:44:15  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/04/29  15:45:50  elwinter
# Added use of factory document.
#
# Revision 1.1.1.3  2002/04/28  14:04:49  elwinter
# Rearranged. Added code for constructor and accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::RESOURCE;

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
use VOTABLE::COOSYS;
use VOTABLE::DESCRIPTION;
use VOTABLE::INFO;
use VOTABLE::LINK;
use VOTABLE::PARAM;
use VOTABLE::TABLE;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'RESOURCE';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'name', 'type');

# List of valid values for the 'type' attribute.
my(@valid_types) = ('meta', 'results');

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

    # Construct the VOTABLE::RESOURCE object from the XML::DOM object.
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

sub get_type()
{
    my($this) = @_;
    $this->_get_XMLDOM->getAttribute('type');
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
    $xmldom_element_description = $votable_description->_get_XMLDOM;
    if (not $xmldom_element_description) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this RESOURCE element already has a DESCRIPTION element, remove
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

sub get_info()
{
    my($this) = @_;
    if (exists($this->{'INFO'})) {
	return(@{$this->{'INFO'}});
    } else {
	return(());
    }
}

sub set_info()
{

    # Save arguments.
    my($this, @votable_info) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::INFO object and its underlying
    # XML::DOM::Element object.
    my($votable_info);
    my($xmldom_element_info);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'INFO'} = [@votable_info];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any INFO elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::INFOs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_info; $i++) {
	$xmldom_element_info = $votable_info[$i]->_get_XMLDOM;
	$xmldom_element_info->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # INFO elements as the first child elements of this object after
    # any DESCRIPTION. Otherwise, just add the INFO elements as the
    # first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the INFO elements right after it. Otherwise,
	    # append the INFO elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_info (reverse(@votable_info)) {
		    $xmldom_element_info = $votable_info->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_info,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info = $votable_info->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_info);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the INFO
	    # elements as the first children.
	    foreach $votable_info (reverse(@votable_info)) {
		$xmldom_element_info = $votable_info->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_info,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these INFO becomes the first
	# children.
	foreach $votable_info (@votable_info) {
	    $xmldom_element_info = $votable_info->_get_XMLDOM;
	    $xmldom_element_this->appendChild($xmldom_element_info);
	}

    }

    # Return the new objects.
    return($this->get_info);

}

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

    # Reference to the current VOTABLE::COOSYS object and its underlying
    # XML::DOM::Element object.
    my($votable_coosys);
    my($xmldom_element_coosys);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'COOSYS'} = [@votable_coosys];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any COOSYS elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::COOSYSs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_coosys; $i++) {
	$xmldom_element_coosys = $votable_coosys[$i]->_get_XMLDOM;
	$xmldom_element_coosys->setOwnerDocument($xmldom_element_this->
						 getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # COOSYS elements as the first child elements of this object after
    # the last INFO, or any DESCRIPTION. Otherwise, just add the
    # COOSYS elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the COOSYS elements right after it. Otherwise, append
	    # the COOSYS elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_coosys (reverse(@votable_coosys)) {
		    $xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_coosys,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_coosys (@votable_coosys) {
		    $xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_coosys);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the COOSYS elements right after it. Otherwise,
	    # append the COOSYS elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_coosys (reverse(@votable_coosys)) {
		    $xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_coosys,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_coosys (@votable_coosys) {
		    $xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_coosys);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the COOSYS
	    # elements as the first children.
	    foreach $votable_coosys (reverse(@votable_coosys)) {
		$xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_coosys,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these COOSYS becomes the first
	# children.
	foreach $votable_coosys (@votable_coosys) {
	    $xmldom_element_coosys = $votable_coosys->_get_XMLDOM;
	    $xmldom_element_this->appendChild($xmldom_element_coosys);
	}

    }

    # Return the new objects.
    return($this->get_coosys);

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

    # Reference to the current VOTABLE::PARAM object and its underlying
    # XML::DOM::Element object.
    my($votable_param);
    my($xmldom_element_param);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'PARAM'} = [@votable_param];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any PARAM elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::PARAMs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_param; $i++) {
	$xmldom_element_param = $votable_param[$i]->_get_XMLDOM;
	$xmldom_element_param->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # PARAM elements as the first child elements of this object after
    # the last COOSYS, the last INFO, or any DESCRIPTION. Otherwise,
    # just add the PARAM elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the PARAM elements right after it. Otherwise, append
	    # the PARAM elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_param (reverse(@votable_param)) {
		    $xmldom_element_param = $votable_param->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_param,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param = $votable_param->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_param);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the PARAM elements right after it. Otherwise, append
	    # the PARAM elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_param (reverse(@votable_param)) {
		    $xmldom_element_param = $votable_param->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_param,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param = $votable_param->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_param);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the PARAM elements right after it. Otherwise,
	    # append the PARAM elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_param (reverse(@votable_param)) {
		    $xmldom_element_param = $votable_param->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_param,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_param (@votable_param) {
		    $xmldom_element_param = $votable_param->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_param);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the PARAM
	    # elements as the first children.
	    foreach $votable_param (reverse(@votable_param)) {
		$xmldom_element_param = $votable_param->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_param,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these PARAM becomes the first
	# children.
	foreach $votable_param (@votable_param) {
	    $xmldom_element_param = $votable_param->_get_XMLDOM;
	    $xmldom_element_this->appendChild($xmldom_element_param);
	}

    }

    # Return the new objects.
    return($this->get_param);

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

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::LINK object and its underlying
    # XML::DOM::Element object.
    my($votable_link);
    my($xmldom_element_link);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

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
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::LINKs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_link; $i++) {
	$xmldom_element_link = $votable_link[$i]->_get_XMLDOM;
	$xmldom_element_link->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # LINK elements as the first child elements of this object after
    # the last PARAM, the last COOSYS, the last INFO, or any
    # DESCRIPTION. Otherwise, just add the LINK elements as the first
    # children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {

	    # If the last PARAM element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append
	    # the LINK elements.
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
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append
	    # the LINK elements.
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
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the LINK elements right after it. Otherwise, append
	    # the LINK elements.
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
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the LINK elements right after it. Otherwise,
	    # append the LINK elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_link (reverse(@votable_link)) {
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
	    foreach $votable_link (reverse(@votable_link)) {
		$xmldom_element_link = $votable_link->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_link,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these LINK becomes the first
	# children.
	foreach $votable_link (@votable_link) {
	    $xmldom_element_link = $votable_link->_get_XMLDOM;
	    $xmldom_element_this->appendChild($xmldom_element_link);
	}

    }

    # Return the new objects.
    return($this->get_link);

}

sub get_table()
{
    my($this) = @_;
    if (exists($this->{'TABLE'})) {
	return(@{$this->{'TABLE'}});
    } else {
	return(());
    }
}

sub set_table()
{

    # Save arguments.
    my($this, @votable_table) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::TABLE object and its underlying
    # XML::DOM::Element object.
    my($votable_table);
    my($xmldom_element_table);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'TABLE'} = [@votable_table];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any TABLE elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('TABLE', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::TABLEs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_table; $i++) {
	$xmldom_element_table = $votable_table[$i]->_get_XMLDOM;
	$xmldom_element_table->setOwnerDocument($xmldom_element_this->
						getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # TABLE elements as the first child elements of this object after
    # the last LINK, the last PARAM, the last COOSYS, the last INFO,
    # or any DESCRIPTION. Otherwise, just add the TABLE elements as
    # the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {

	    # If the last LINK element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (reverse(@votable_table)) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {

	    # If the last PARAM element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (reverse(@votable_table)) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (reverse(@votable_table)) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the TABLE elements right after it. Otherwise, append
	    # the TABLE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (reverse(@votable_table)) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the TABLE elements right after it. Otherwise,
	    # append the TABLE elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_table (reverse(@votable_table)) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_table,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_table (@votable_table) {
		    $xmldom_element_table = $votable_table->_get_XMLDOM;
		    $xmldom_element_this->appendChild($xmldom_element_table);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the TABLE
	    # elements as the first children.
	    foreach $votable_table (reverse(@votable_table)) {
		$xmldom_element_table = $votable_table->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_table,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these TABLE becomes the first
	# children.
	foreach $votable_table (@votable_table) {
	    $xmldom_element_table = $votable_table->_get_XMLDOM;
	    $xmldom_element_this->appendChild($xmldom_element_table);
	}

    }

    # Return the new objects.
    return($this->get_table);

}

sub get_resource()
{
    my($this) = @_;
    if (exists($this->{'RESOURCE'})) {
	return(@{$this->{'RESOURCE'}});
    } else {
	return(());
    }
}

sub set_resource()
{

    # Save arguments.
    my($this, @votable_resource) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the current VOTABLE::RESOURCE object and its underlying
    # XML::DOM::Element object.
    my($votable_resource);
    my($xmldom_element_resource);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'RESOURCE'} = [@votable_resource];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # If any RESOURCE elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('RESOURCE', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::RESOURCEs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this VOTABLE::RESOURCE.
    for ($i = 0; $i < @votable_resource; $i++) {
	$xmldom_element_resource = $votable_resource[$i]->_get_XMLDOM;
	$xmldom_element_resource->setOwnerDocument($xmldom_element_this->
						   getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # RESOURCE elements as the first child elements of this object
    # after the last TABLE, the last LINK, the last PARAM, the last
    # COOSYS, the last INFO, or any DESCRIPTION. Otherwise, just add
    # the RESOURCE elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('TABLE', 0)) {

	    # If the last TABLE element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (reverse(@votable_resource)) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('LINK', 0)) {

	    # If the last LINK element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (reverse(@votable_resource)) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('PARAM', 0)) {

	    # If the last PARAM element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (reverse(@votable_resource)) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('COOSYS', 0)) {

	    # If the last COOSYS element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (reverse(@votable_resource)) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {

	    # If the last INFO element is not the last child, insert
	    # the RESOURCE elements right after it. Otherwise, append
	    # the RESOURCE elements.
	    if ($xmldom_elements[-1] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (reverse(@votable_resource)) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} elsif (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the RESOURCE elements right after it. Otherwise,
	    # append the RESOURCE elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_resource (reverse(@votable_resource)) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} else {

	    # No DESCRIPTION element found, so insert the RESOURCE
	    # elements as the first children.
	    foreach $votable_resource (reverse(@votable_resource)) {
		$xmldom_element_resource = $votable_resource->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_resource,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so these RESOURCE becomes the first
	# children.
	foreach $votable_resource (@votable_resource) {
	    $xmldom_element_resource = $votable_resource->_get_XMLDOM;
	    $xmldom_element_this->appendChild($xmldom_element_resource);
	}

    }

    # Return the new objects.
    return($this->get_resource);

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

    # References to elements.
    my($votable_description);
    my(@votable_info);
    my(@votable_coosys);
    my(@votable_param);
    my(@votable_link);
    my(@votable_table);
    my(@votable_resource);

    # Temporary XML::DOM::Elements.
    my(@xmldom_elements, $xmldom_element);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    #--------------------------------------------------------------------------

    # DESCRIPTION
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {
	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
	$this->set_description($votable_description);
    }

    #--------------------------------------------------------------------------

    # INFO
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('INFO', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_info[$i] = new VOTABLE::INFO $xmldom_elements[$i];
	}
	$this->set_info(@votable_info);
    }

    #--------------------------------------------------------------------------

    # COOSYS
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('COOSYS', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_coosys[$i] = new VOTABLE::COOSYS $xmldom_elements[$i];
	}
	$this->set_coosys(@votable_coosys);
    }

    #--------------------------------------------------------------------------

    # PARAM
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('PARAM', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_param[$i] = new VOTABLE::PARAM $xmldom_elements[$i];
	}
	$this->set_param(@votable_param);
    }

    #--------------------------------------------------------------------------

    # LINK
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('LINK', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_link[$i] = new VOTABLE::LINK $xmldom_elements[$i];
	}
	$this->set_link(@votable_link);
    }

    #--------------------------------------------------------------------------

    # TABLE
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TABLE', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_table[$i] = new VOTABLE::TABLE $xmldom_elements[$i];
	}
	$this->set_table(@votable_table);
    }

    #--------------------------------------------------------------------------

    # RESOURCE
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('RESOURCE', 0)) {
	for ($i = 0; $i < @xmldom_elements; $i++) {
	    $votable_resource[$i] = new VOTABLE::RESOURCE $xmldom_elements[$i];
	}
	$this->set_resource(@votable_resource);
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
