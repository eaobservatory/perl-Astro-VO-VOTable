# COOSYS.pm

=pod

=head1 NAME

VOTABLE::COOSYS - VOTABLE COOSYS XML element class

=head1 SYNOPSIS

 use VOTABLE::COOSYS;

=head1 DESCRIPTION

This class implements the C<COOSYS> element from the C<VOTABLE>
DTD. This element is used to store coordinate system information
(hence the element tag name). Other elements of a C<VOTABLE> document,
such as C<FIELD> elements for coordinates, typically reference a
C<COOSYS> element (using the value of the C<ID> attribute of the
C<COOSYS> element) to indicate the coordinate system which should be
used to interpret the coordinates.

The C<COOSYS> element is a Tier 0 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT COOSYS (#PCDATA)>
 <!ATTLIST COOSYS
         ID ID #IMPLIED
         equinox CDATA #IMPLIED
         epoch CDATA #IMPLIED
         system (eq_FK4 | eq_FK5 | ICRS | ecl_FK4 | ecl_FK5 | galactic
                | supergalactic | xy | barycentric | geo_app) "eq_FK5"
 >

=head2 Methods

=head3 C<new($str_or_ref, %options)>

Create a new C<VOTABLE::COOSYS> object, and return a reference to
it. If the first argument (C<$str_or_ref>) is a string, it is used as
the initial C<#PCDATA> content of the C<COOSYS> element. If the first
argument is a reference to a C<XML::DOM::Element> object, that object
is used to initialize the new C<COOSYS> element (implicitly assuming
that the C<XML::DOM::Element> object contains a valid C<COOSYS>
element). The C<%options> hash is used to set the attributes of the
new element. If the first argument is missing or undefined, or an
empty string, create and return an empty C<VOTABLE::COOSYS>
object. Return C<undef> if an error occurs.

=head3 C<get_ID>

Return the value of the C<ID> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ID($id)>

Set the value of the C<ID> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_epoch>

Return the value of the C<epoch> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_epoch($epoch)>

Set the value of the C<epoch> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_equinox>

Return the value of the C<equinox> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_equinox($equinox)>

Set the value of the C<equinox> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_system>

Return the value of the C<system> attribute. Return the default value
(C<eq_FK5>) if the attribute has not been set. Return C<undef> if an
error occurs.

=head3 C<set_system($system)>

Set the value of the C<system> attribute to the specified value. The
new value is checked for correctness against the list of allowed
values. Use C<undef> as the argument to clear any existing value of
the attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get>

Return a string containing the C<#PCDATA> content of the C<COOSYS>
element. Return C<undef> if the element has no C<#PCDATA> content, or
an error occurs.

=head3 C<set($str)>

Set the C<#PCDATA> content of the C<COOSYS> element to the specified
string. Use C<undef> as the argument to clear any existing value of
the text. Return the string on success, or C<undef> if an error
occurs.

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
C<VOTABLE> object I<always> has an underlying C<XML::DOM::Element>
object. As long as the internal structure is manipulated only by the
publicly-available methods, this should be a safe assumption. If a
method detects an aberrant case, a warning message is printed (using
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

C<VOTABLE>, C<VOTABLE::DEFINITIONS>, C<VOTABLE::RESOURCE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: COOSYS.pm,v 1.1.1.11 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: COOSYS.pm,v $
# Revision 1.1.1.11  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.10  2002/06/04  23:59:33  elwinter
# Documentation tweaks.
#
# Revision 1.1.1.9  2002/06/04  11:52:15  elwinter
# Complete overhaul. Fixed many latent bugs caused by misunderstanding of the
# internals of XML::DOM modules.
#
# Revision 1.1.1.8  2002/05/21  14:08:05  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.7  2002/05/21  11:46:58  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.6  2002/05/07  13:50:42  elwinter
# Overhauled.
#
# Revision 1.1.1.5  2002/05/06  18:24:58  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/03  16:17:58  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/30  13:39:38  elwinter
# Complete overhaul.
#
# Revision 1.1.1.2  2002/04/28  14:25:11  elwinter
# Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::COOSYS;

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

# Module version.
our $VERSION = '0.03';

#------------------------------------------------------------------------------

# Specify external modules to use.

# Standard modules
use Carp;
use English;
use XML::DOM;

# Third-party modules

# Project modules

#------------------------------------------------------------------------------

# Class constants

# Name of XML tag for current class.
my($TAG_NAME) = 'COOSYS';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE) = 'XML::DOM::Element';

# Name of XML::DOM text class.
my($XMLDOM_TEXT) = 'XML::DOM::Text';

# List of valid attributes for this element.
my(@VALID_ATTRIBUTE_NAMES) = ('ID', 'epoch', 'equinox', 'system');

# List of valid values for the 'system' attribute.
my(@VALID_SYSTEMS) = ('ICRS', 'barycentric', 'ecl_FK4', 'ecl_FK5', 'eq_FK4',
		      'eq_FK5', 'galactic', 'geo_app', 'supergalactic', 'xy');

# Default value for the 'system' attribute.
use constant DEFAULT_SYSTEM => 'eq_FK5';

#------------------------------------------------------------------------------

# Class variables

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
# additional argument, if it exists, contains either a string to use
# to initialize the #PCDATA content of the new object, or a reference
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

    # Local variables

    # Reference to XML::DOM::Element object for the new object.
    my($xmldom_element_this);

    # String with initial text for the #PCDATA content of the element.
    my($str);

    # Hash containing keyword-value pairs to initialize attributes.
    my(%attributes);

    # Name of current element tag.
    my($tag_name);

    # Current attribute name and value.
    my($attribute_name, $attribute_value);

    # Reference to new object.
    my($this);

    # XML::DOM::Text object for the #PCDATA content.
    my($xmldom_text);

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
 	    ($xmldom_element_this, %attributes) = @options;
	    if ($xmldom_element_this) {
		$tag_name = $xmldom_element_this->getTagName;
		if ($tag_name ne $TAG_NAME) {
		    carp("Invalid tag name: $tag_name");
		    return(undef);
		}
	    }
 	} else {
 	    ($str, %attributes) = @options;
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

    } elsif (defined($str)) {

	# Create a new XML::DOM::Element object.
	$xmldom_element_this =
	    $xmldom_document_factory->createElement($TAG_NAME);
	if (not $xmldom_element_this) {
	    carp("Unable to create $XMLDOM_BASE.");
	    return(undef);
	}

	# Create a text node for the content.
	$xmldom_text = $xmldom_document_factory->createTextNode($str);
	if (not $xmldom_element_this) {
	    carp("Unable to create $XMLDOM_TEXT for string '$str'.");
	    return(undef);
	}

	# Add the text node to the element.
	if ($xmldom_element_this->appendChild($xmldom_text) ne $xmldom_text) {
	    carp("Unable to append $XMLDOM_TEXT to $XMLDOM_BASE.");
	    return(undef);
	}

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

	# Map the attribute name to a valid Perl name.
	$attribute_name =~ s/-/_/;

	# Create a string of code to evaluate to set the attribute
	# value.
	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";

	# Evalute the attribute-setting code and check for errors.
	eval($set_attribute);
	if ($EVAL_ERROR) {
	    carp("Error evaluating '$set_attribute': $EVAL_ERROR!");
	    return(undef);
	}

    }

    # Construct the VOTABLE object from the XML::DOM::Element object.
    if (not $this->_build_from_XMLDOM) {
	carp("Unable to build VOTABLE::$TAG_NAME from $XMLDOM_BASE.");
	return(undef);
    }

    # Return the object.
    return($this);

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

sub get_epoch()
{
    my($this) = @_;
    my($epoch);
    $epoch = $this->_get_XMLDOM->getAttribute('epoch');
    $epoch = undef if (length($epoch) == 0);
    return($epoch);
}

sub set_epoch()
{
    my($this, $epoch) = @_;
    if (defined($epoch)) {
	$this->_get_XMLDOM->setAttribute('epoch', $epoch);
    } else {
	$this->_get_XMLDOM->removeAttribute('epoch');
    }
    return($this->get_epoch);
}

sub get_equinox()
{
    my($this) = @_;
    my($equinox);
    $equinox = $this->_get_XMLDOM->getAttribute('equinox');
    $equinox = undef if (length($equinox) == 0);
    return($equinox);
}

sub set_equinox()
{
    my($this, $equinox) = @_;
    if (defined($equinox)) {
	$this->_get_XMLDOM->setAttribute('equinox', $equinox);
    } else {
	$this->_get_XMLDOM->removeAttribute('equinox');
    }
    return($this->get_equinox);
}

sub get_system()
{
    my($this) = @_;
    my($system);
    $system = $this->_get_XMLDOM->getAttribute('system');
    $system = DEFAULT_SYSTEM if (length($system) == 0);
    return($system);
}

sub set_system()
{
    my($this, $system) = @_;
    if (defined($system)) {
	if (not grep(/$system/, @VALID_SYSTEMS)) {
	    carp("Invalid $TAG_NAME 'system' attribute value: $system!");
	    return(undef);
	}
	$this->_get_XMLDOM->setAttribute('system', $system);
    } else {
	$this->_get_XMLDOM->removeAttribute('system');
    }
    return($this->get_system);
}

#------------------------------------------------------------------------------

# Element accessor methods

#------------------------------------------------------------------------------

# #PCDATA content accessor methods

#------------------------------------------------------------------------------

sub get()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # String to hold the returned text.
    my($str);

    # Array of child nodes.
    my(@xmldom_nodes);

    #--------------------------------------------------------------------------

    # Fetch the underlying XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # This object can have 0 or more text nodes representing the
    # #PCDATA content. Multiple nodes may be used to allow for embedded
    # comments. To return the entire #PCDATA content, the contents of
    # each of these text nodes must be merged and returned
    # together. If no text nodes are found, return undef. Note that if
    # there are child elements but none of them are text nodes, undef
    # is still returned.
    @xmldom_nodes = $xmldom_element_this->getChildNodes;
    local($_);
    map({$str .= $_->getData if ($_->getNodeName eq '#text')} @xmldom_nodes);

    # Return the string.
    return($str);

}

sub set()
{

    # Save arguments.
    my($this, $str) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # List of child nodes.
    my(@xmldom_nodes);

    # Current node.
    my($xmldom_node);

    # Array of child nodes to remove.
    my(@xmldom_nodes_to_remove);

    # XML::DOM text node for new data.
    my($xmldom_text);

    #--------------------------------------------------------------------------

    # Fetch the underlying XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Make a list of the existing text nodes.
    @xmldom_nodes = $xmldom_element_this->getChildNodes;
    foreach $xmldom_node (@xmldom_nodes) {
	push(@xmldom_nodes_to_remove, $xmldom_node)
	    if $xmldom_node->getNodeName eq '#text';
    }

    # Remove the existing text nodes.
    foreach $xmldom_node (@xmldom_nodes_to_remove) {
	if ($xmldom_element_this->removeChild($xmldom_node) ne $xmldom_node) {
	    carp('Unable to remove child node.');
	    return(undef);
	}
    }

    # Create the new node if needed, and add it.
    if (defined($str)) {
	$xmldom_text = $xmldom_document_factory->createTextNode($str);
	if (not $xmldom_text) {
	    carp("Unable to create $XMLDOM_TEXT.");
	    return(undef);
	}
	$xmldom_text->setOwnerDocument($xmldom_element_this->getOwnerDocument);
	$xmldom_element_this->appendChild($xmldom_text);
    }

    # Return the new content.
    return($this->get);

}

#------------------------------------------------------------------------------

# Internal methods

# These methods should ONLY be used by this class, and other classes
# within the VOTABLE hierarchy, since these methods assume integrity
# of their arguments, the VOTABLE objects, and the underlying XML::DOM
# objects.

#------------------------------------------------------------------------------

# _build_from_XMLDOM()

# This internal method is used to assemble a VOTABLE object from a
# XML::DOM::Element object. Return 1 on success, or 0 on failure.

# Since the COOSYS element is a Tier 0 element, there is nothing for
# this method to do, other than return true (1) to indicate success.

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
