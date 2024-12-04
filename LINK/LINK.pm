# LINK.pm

=pod

=head1 NAME

VOTABLE::LINK - VOTABLE LINK XML element class

=head1 SYNOPSIS

 use VOTABLE::LINK;

=head1 DESCRIPTION

This class implements the C<LINK> element from the C<VOTABLE>
DTD. This element is used to store traditional C<HTTP> hyperlinks to
supporting information (using the C<href> attribute), or a more
general-purpose link (using the C<gref> attribute).

The C<LINK> element is a Tier 0 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT LINK (#PCDATA)>
 <!ATTLIST LINK
         ID ID #IMPLIED
         content-role (query | hints | doc) #IMPLIED
         content-type CDATA #IMPLIED
         title CDATA #IMPLIED
         value CDATA #IMPLIED
         href CDATA #IMPLIED
         gref CDATA #IMPLIED
         action CDATA #IMPLIED
 >

=head2 Methods

=head3 C<new($str_or_ref, %options)>

Create a new C<VOTABLE::LINK> object, and return a reference to it. If
the first argument (C<$str_or_ref>) is a string, it is used as the
initial C<#PCDATA> content of the C<LINK> element. If the first
argument is a reference to a C<XML::DOM::Element> object, that object
is used to initialize the new C<LINK> element (implicitly assuming
that the C<XML::DOM::Element> object contains a valid C<LINK>
element). The C<%options> hash is used to set the attributes of the
new element. If the first argument is missing or undefined, or an
empty string, create and return an empty C<VOTABLE::LINK>
object. Return C<undef> if an error occurs.

=head3 C<get_ID>

Return the value of the C<ID> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ID($id)>

Set the value of the C<ID> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_action>

Return the value of the C<action> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_action($action)>

Set the value of the C<action> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_content_role>

Return the value of the C<content-role attribute>. Return C<undef> if
the attribute has not been set, or an error occurs.

=head3 C<set_content_role($content_role)>

Set the value of the C<content-role> attribute to the specified
value. Use C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_content_type>

Return the value of the C<content-type> attribute. Return C<undef> if
the attribute has not been set, or an error occurs.

=head3 C<set_content_type($content_type)>

Set the value of the C<content-type> attribute to the specified
value. Use C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_gref>

Return the value of the C<gref> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_gref($gref)>

Set the value of the C<gref> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_href>

Return the value of the C<href> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_href($href)>

Set the value of the C<href> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_title>

Return the value of the C<title> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_title($title)>

Set the value of the C<title> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_value>

Return the value of the C<value> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_value($value)>

Set the value of the C<value> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get>

Return a string containing the C<#PCDATA> content of the C<LINK>
element. Return C<undef> if the element has no C<#PCDATA> content, or
an error occurs.

=head3 C<set($str)>

Set the C<#PCDATA> content of the C<LINK> element to the specified
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
publicly-available methods, this should be an safe assumption. If a
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

C<VOTABLE>, C<VOTABLE::FIELD>, C<VOTABLE::PARAM>,
C<VOTABLE::RESOURCE>, C<VOTABLE::TABLE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: LINK.pm,v 1.1.1.9 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: LINK.pm,v $
# Revision 1.1.1.9  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.8  2002/06/05  00:02:23  elwinter
# Overhaul to reflect improved understanding of XML::DOM module.
#
# Revision 1.1.1.7  2002/05/21  14:11:17  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.6  2002/05/21  13:43:58  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.5  2002/05/07  13:37:09  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/03  15:35:21  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/05/01  16:14:10  elwinter
# Overhauled.
#
# Revision 1.1.1.2  2002/04/28  15:06:58  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::LINK;

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

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'LINK';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE) = 'XML::DOM::Element';

# Name of XML::DOM text class.
my($XMLDOM_TEXT) = 'XML::DOM::Text';

# List of valid attributes for this element.
my(@VALID_ATTRIBUTE_NAMES) = ('ID', 'action', 'content-role', 'content-type',
			      'gref', 'href', 'title', 'value');

# List of valid values for the 'content-role' attribute.
my(@VALID_CONTENT_ROLES) = ('doc', 'hints', 'query');

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

sub get_action()
{
    my($this) = @_;
    my($action);
    $action = $this->_get_XMLDOM->getAttribute('action');
    $action = undef if (length($action) == 0);
    return($action);
}

sub set_action()
{
    my($this, $action) = @_;
    if (defined($action)) {
	$this->_get_XMLDOM->setAttribute('action', $action);
    } else {
	$this->_get_XMLDOM->removeAttribute('action');
    }
    return($this->get_action);
}

sub get_content_role()
{
    my($this) = @_;
    my($content_role);
    $content_role = $this->_get_XMLDOM->getAttribute('content-role');
    $content_role = undef if (length($content_role) == 0);
    return($content_role);
}

sub set_content_role()
{
    my($this, $content_role) = @_;
    if (defined($content_role)) {
	if (not grep(/$content_role/, @VALID_CONTENT_ROLES)) {
	    carp("Invalid $TAG_NAME 'content-role' attribute value: " .
		 "$content_role!");
	    return(undef);
	}
	$this->_get_XMLDOM->setAttribute('content-role', $content_role);
    } else {
	$this->_get_XMLDOM->removeAttribute('content-role');
    }
    return($this->get_content_role);
}

sub get_content_type()
{
    my($this) = @_;
    my($content_type);
    $content_type = $this->_get_XMLDOM->getAttribute('content-type');
    $content_type = undef if (length($content_type) == 0);
    return($content_type);
}

sub set_content_type()
{
    my($this, $content_type) = @_;
    if (defined($content_type)) {
	$this->_get_XMLDOM->setAttribute('content-type', $content_type);
    } else {
	$this->_get_XMLDOM->removeAttribute('content-type');
    }
    return($this->get_content_type);
}

sub get_gref()
{
    my($this) = @_;
    my($gref);
    $gref = $this->_get_XMLDOM->getAttribute('gref');
    $gref = undef if (length($gref) == 0);
    return($gref);
}

sub set_gref()
{
    my($this, $gref) = @_;
    if (defined($gref)) {
	$this->_get_XMLDOM->setAttribute('gref', $gref);
    } else {
	$this->_get_XMLDOM->removeAttribute('gref');
    }
    return($this->get_gref);
}

sub get_href()
{
    my($this) = @_;
    my($href);
    $href = $this->_get_XMLDOM->getAttribute('href');
    $href = undef if (length($href) == 0);
    return($href);
}

sub set_href()
{
    my($this, $href) = @_;
    if (defined($href)) {
	$this->_get_XMLDOM->setAttribute('href', $href);
    } else {
	$this->_get_XMLDOM->removeAttribute('href');
    }
    return($this->get_href);
}

sub get_title()
{
    my($this) = @_;
    my($title);
    $title = $this->_get_XMLDOM->getAttribute('title');
    $title = undef if (length($title) == 0);
    return($title);
}

sub set_title()
{
    my($this, $title) = @_;
    if (defined($title)) {
	$this->_get_XMLDOM->setAttribute('title', $title);
    } else {
	$this->_get_XMLDOM->removeAttribute('title');
    }
    return($this->get_title);
}

sub get_value()
{
    my($this) = @_;
    my($value);
    $value = $this->_get_XMLDOM->getAttribute('value');
    $value = undef if (length($value) == 0);
    return($value);
}

sub set_value()
{
    my($this, $value) = @_;
    if (defined($value)) {
	$this->_get_XMLDOM->setAttribute('value', $value);
    } else {
	$this->_get_XMLDOM->removeAttribute('value');
    }
    return($this->get_value);
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

# Since the LINK element is a Tier 0 element, there is nothing for
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
