# STREAM.pm

=pod

=head1 NAME

VOTABLE::STREAM - VOTABLE STREAM XML element class

=head1 SYNOPSIS

 use VOTABLE::STREAM;

=head1 DESCRIPTION

This class implements the C<STREAM> element from the C<VOTABLE>
DTD. This element is used to encapsulate streams of arbitrary data,
possibly encoded and/or compressed.

The C<STREAM> element is a Tier 0 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT STREAM (#PCDATA)>
 <!ATTLIST STREAM
         type (locator | other) "locator"
         href CDATA #IMPLIED
         actuate (onLoad | onRequest | other | none) "onRequest"
         encoding (gzip | base64 | dynamic | none) "none"
         expires CDATA #IMPLIED
         rights CDATA #IMPLIED
 >

=head2 Methods

=head3 C<new($str_or_ref, %options)>

Create a new C<VOTABLE::STREAM> object, and return a reference to
it. If the first argument (C<$str_or_ref>) is a string, it is used as
the initial C<#PCDATA> content of the C<STREAM> element. If the first
argument is a reference to a C<XML::DOM::Element> object, that object
is used to initialize the new C<STREAM> element (implicitly assuming
that the C<XML::DOM::Element> object contains a valid C<STREAM>
element). The C<%options> hash is used to set the attributes of the
new element. If the first argument is missing or undefined, or an
empty string, create and return an empty C<VOTABLE::STREAM>
object. Return C<undef> if an error occurs.

=head3 C<get_actuate>

Return the value of the C<actuate> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_actuate($actuate)>

Set the value of the C<actuate> attribute to the specified value. The
new value is checked for correctness against the list of allowed
values. Use C<undef> as the argument to clear any existing value of
the attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_encoding>

Return the value of the C<encoding> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_encoding($encoding)>

Set the value of the C<encoding> attribute to the specified value. The
new value is checked for correctness against the list of allowed
values. Use C<undef> as the argument to clear any existing value of
the attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_expires>

Return the value of the C<expires> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_expires($expires)>

Set the value of the C<expires> attribute to the specified value. Use
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

=head3 C<get_rights>

Return the value of the C<rights> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_rights($rights)>

Set the value of the C<rights> attribute to the specified value. Use
C<undef> as the argument to clear any existing value of the
attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<get_type>

Return the value of the C<type> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_type($type)>

Set the value of the C<type> attribute to the specified value. The new
value is checked for correctness against the list of allowed
values. Use C<undef> as the argument to clear any existing value of
the attribute. Return the new value of the attribute on success, or
C<undef> if an error occurs.

=head3 C<actuate>

Read the content of the stream from the source specified by the
C<href> attribute, and store it internally. Return true (C<1>) on
success, and false (C<0>) if an error occurs.

=head3 C<get_content($offset, $length)>

Return a portion of the content string starting at C<$offset> bytes
and continuing for C<$length> bytes. If C<$offset> and C<$length> are
not specified, return the entire content as a single byte string. If
C<$offset> is specified but C<$length> is not, return the content from
C<$offset> to the end of the string. Otherwise, the C<$offset> and
C<$length> arguments are treated the same as the corresponding
arguments to the C<substr> subroutine. If required, the stream content
is actuated (by calling the C<actuate> method) prior to extracting the
content. Return the content as a string, or C<undef> if an error
occurs.

=head3 C<set_content($bytes, $offset, $length)>

Set the specified portion of the content of the C<STREAM>, starting at
C<$offset> and continuing for C<$length> bytes, to the specified byte
string. If C<$offset> and C<$length> are not specified, the current
content is replaced by the specified byte string. If C<$offset> is
specified but C<$length> is not specified, C<$length> defaults to the
length of C<$bytes>. Otherwise, C<$offset> and C<$length> behave as
the corresponding arguments to C<substr>. Return the new string on
success, or C<undef> on error.

=head3 C<serialize>

Write the current content string to the location specified by the
C<href> attribute, using the current value of the C<encoding>
attribute. Return true (C<1>) on success, or false (C<0>) on error.

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

A C<STREAM> which refers to an external data source (such as a binary
file) nust use the C<locator> value for the C<type> attribute. The
value of C<other> for the C<type> attribute is not yet supported.

=item *

The C<href> attribute currently supports only the C<file> protocol,
i.e. files on the local machine. Therefore, values for the C<href>
attribute must be of the form C<file://path/to/the/file>.

=item *

All actuation (reading of data from its source) is invoked
automatically by the code as needed (for now). In other words, the
value of the C<actuate> attribute is ignored for now, but it acts as
if the value C<onRequest> was in effect.

=item *

The C<encoding> attribute currently supports only the value C<none>.

=item *

The C<expires> and C<rights> attributes are currently ignored.

=item *

This class currently makes no use of the C<#PCDATA> content of the
element. In the future, the C<#PCDATA> content may be used to store
embedded data.

=item *

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE> object I<always> has an underlying C<XML::DOM::Element>
object. As long as the internal structure is manipulated only by the
publicly-available methods, this should be an adequate assumption. If
a method detects an aberrant case, a warning message is printed (using
the C<Carp::carp> subroutine), and the method fails.

=item *

This code also assumes that all internal methods always succeed.

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

C<VOTABLE>, C<VOTABLE::BINARY>, C<VOTABLE::FITS>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: STREAM.pm,v 1.1.1.15 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: STREAM.pm,v $
# Revision 1.1.1.15  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.14  2002/06/05  00:04:34  elwinter
# Overhaul to reflect improved understanding of XML::DOM module.
#
# Revision 1.1.1.13  2002/05/29  12:52:29  elwinter
# Added serialize() method.
#
# Revision 1.1.1.12  2002/05/29  12:05:09  elwinter
# Overhauled actuate(), get_content(), and set_content() methods.
#
# Revision 1.1.1.11  2002/05/28  15:04:42  elwinter
# Added get_content() as synonym for actuate().
#
# Revision 1.1.1.10  2002/05/28  14:24:38  elwinter
# Added set_content().
#
# Revision 1.1.1.9  2002/05/23  13:10:03  elwinter
# Updated actuate() method.
#
# Revision 1.1.1.8  2002/05/22  15:05:00  elwinter
# Added actuate() method.
#
# Revision 1.1.1.7  2002/05/21  14:13:06  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.6  2002/05/21  13:48:42  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.5  2002/05/07  13:46:36  elwinter
# Overhauled.
#
# Revision 1.1.1.4  2002/05/03  16:10:14  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/04/30  14:24:16  elwinter
# Complete overhaul.
#
# Revision 1.1.1.2  2002/04/28  19:21:01  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::STREAM;

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

# Standard modules.
use Carp;
use English;
use XML::DOM;

# Third-party modules.

# Project modules.

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'STREAM';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE) = 'XML::DOM::Element';

# Name of XML::DOM text class.
my($XMLDOM_TEXT) = 'XML::DOM::Text';

# List of valid attributes for this element.
my(@VALID_ATTRIBUTE_NAMES) = ('actuate', 'encoding', 'expires', 'href',
			      'rights', 'type');

# List of valid values for the 'actuate' attribute.
my(@VALID_ACTUATES) = ('none', 'onLoad', 'onRequest', 'other');

# Default value for 'actuate' attribute.
use constant DEFAULT_ACTUATE => 'onRequest';

# List of valid values for the 'encoding' attribute.
my(@VALID_ENCODINGS) = ('base64', 'dynamic', 'gzip', 'none');

# Default value for 'encoding' attribute.
use constant DEFAULT_ENCODING => 'none';

# List of valid values for the 'type' attribute.
my(@VALID_TYPES) = ('locator', 'other');

# Default value for 'type' attribute.
use constant DEFAULT_TYPE => 'locator';

#------------------------------------------------------------------------------

# Class variables.

# This object is used to access the factory methods in the
# XML::DOM::Document class.
my($xmldom_document_factory);

#******************************************************************************

# Method definitions

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

# actuate()

# This method "actuates" the STREAM by reading in the contents from an
# external source, specified by the value of the 'href'
# attribute. Return true (1) on success, or false (0) on error. This
# method should only be called for STREAM objects that need to be
# actuated.

sub actuate()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Value of 'encoding' attribute for this STREAM.
    my($encoding);

    # Value of 'type' attribute for this STREAM.
    my($type);

    # Current value of href attribute.
    my($href);

    # Protocol portion of the href.
    my($protocol);

    # Path to referenced resource.
    my($resource);

    #--------------------------------------------------------------------------

    # Make sure all attributes are OK.

    # Check for a supported value of the 'encoding' attribute
    # ('none').
    $encoding = $this->get_encoding;
    if (defined($encoding) and $encoding ne 'none') {
	carp("Unsupported encoding: $encoding.");
	return(0);
    }

    # Check for a supported value of the 'type' attribute ('locator').
    $type = $this->get_type;
    if (defined($type) and $type ne 'locator') {
	carp("Unsupported type: $type.");
	return(0);
    }

    # Ignore the 'expires' and 'rights' attributes for now.

    # Fetch the external data reference.
    $href = $this->get_href;
    if (not defined($href)) {
 	carp('No href attribute defined, only href supported right now.');
 	return(0);
    }

    #--------------------------------------------------------------------------

    # Parse the href.
    ($protocol, $resource) = ($href =~ /(\w+)\:\/\/(.+)/);

    # Make sure a valid protocol ('file') was found.
    if (not defined($protocol)) {
	carp('No href protocol.');
	return(0);
    }
    if ($protocol ne 'file') {
	carp("Unsupported href protocol: $protocol.");
	return(0);
    }

    # Make sure a resource was found.
    if (not defined($resource)) {
	carp('No href resource.');
	return(0);
    }

    # Open the file.
    if (not open(EXTERNAL_STREAM, $resource)) {
	carp("Unable to open $resource.");
	return(0);
    }

    # Read and cache the content as a single byte string.
    local($RS) = undef; # Auto-restore old value on exit.
    $this->{'content'} = <EXTERNAL_STREAM>;

    # Close the file.
    if (not close(EXTERNAL_STREAM)) {
	carp("Unable to close $resource.");
	return(undef);
    }

    # Return normally.
    return(1);

}

#------------------------------------------------------------------------------

# get_content()

# This method returns a portion of the content of the STREAM, starting
# at byte $offset and continuing for $length bytes. Return the result
# as a single new string, or undef if an error occurs. The values of
# $offset and $length are (mostly) treated the same as the
# corresponding arguments to substr().

sub get_content()
{

    # Save arguments.
    my($this, $offset, $length) = @_;

    #--------------------------------------------------------------------------

    # Actuate the stream if required. If no actuation is needed, set
    # the content to an empty string.
    if (defined($this->get_href) and not exists($this->{'content'})) {
	if (not $this->actuate) {
	    carp('Unable to actuate.');
	    return(undef);
	}
    }

    # Return the appropriate content segment.
    if (defined($offset) and defined($length)) {
	return(substr($this->{'content'}, $offset, $length));
    } elsif (defined($offset)) {
	return(substr($this->{'content'}, $offset));
    } elsif (defined($length)) {
	return(substr($this->{'content'}, 0, $length));
    } else {
	return($this->{'content'});
    }

}

#------------------------------------------------------------------------------

# set_content()

# Set the content of the STREAM to the specified byte string. Set the
# bytes starting at position $offset, for length $length. If $offset
# is undefined, default to 0. If $length is undefined, default to the
# length of $bytes. Otherwise, the $offset and $length arguments are
# (mostly) handleed the same as the corresponding arguments to
# substr(). Return the new string on success, or undef if an error
# occurs.

sub set_content()
{

    # Save arguments.
    my($this, $bytes, $offset, $length) = @_;

    #--------------------------------------------------------------------------

    # Actuate the stream if required. If no actuation is needed, set
    # the content to an empty string.
    if (not exists($this->{'content'})) {
	if (defined($this->get_href) and not $this->actuate) {
	    carp('Unable to actuate.');
	    return(undef);
	}
    }

    # Set the appropriate content segment.
    if (defined($offset) and defined($length)) {
	substr($this->{'content'}, $offset, $length) = $bytes;
    } elsif (defined($offset)) {
	substr($this->{'content'}, $offset) = $bytes;
    } elsif (defined($length)) {
	substr($this->{'content'}, 0, $length) = $bytes;
    } else {
	$this->{'content'} = $bytes;
    }

    # Return the new content.
    return($this->get_content($offset, $length));

}

#------------------------------------------------------------------------------

# serialize()

# Write the content to the current href using the current encoding.

sub serialize()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Value of 'encoding' attribute for this object.
    my($encoding);

    # Value of 'type' attribute for this object.
    my($type);

    # Value of 'href' attribute for this object.
    my($href);

    # Protocol and resource portions of href attribute value.
    my($protocol, $resource);

    #--------------------------------------------------------------------------

    # Make sure a valid encoding is specified.
    $encoding = $this->get_encoding;
    if (defined($encoding) and $encoding ne 'none') {
	carp("Unsupported encoding: $encoding.");
	return(0);
    }

    # Make sure a valid stream type was specified.
    $type = $this->get_type;
    if (defined($type) and $type ne 'locator') {
	carp("Unsupported type: $type.");
	return(0);
    }

    # Ignore the 'expires' and 'rights' attributes for now.

    # Make sure a valid href is specified.
    $href = $this->get_href;
    if (not defined($href)) {
 	carp('No href attribute defined, only href supported right now.');
 	return(0);
    }

    #--------------------------------------------------------------------------

    # Parse the href.
    ($protocol, $resource) = ($href =~ /(\w+)\:\/\/(.+)/);

    # Make sure a valid href protocol was specified.
    if (not defined($protocol)) {
	carp('No href protocol.');
	return(0);
    }
    if ($protocol ne 'file') {
	carp("Unsupported href protocol: $protocol.");
	return(0);
    }

    # Make sure a valid href resource was specified.
    if (not defined($resource)) {
	carp('No href resource.');
	return(0);
    }

    # Open the resource.
    if (not open(EXTERNAL_STREAM, '>', $resource)) {
	carp("Unable to open $resource.");
	return(0);
    }

    # Write the content.
    print EXTERNAL_STREAM $this->get_content;

    # Close the resource.
    if (not close(EXTERNAL_STREAM)) {
	carp("Unable to close $resource.");
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

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

sub get_actuate()
{
    my($this) = @_;
    my($actuate);
    $actuate = $this->_get_XMLDOM->getAttribute('actuate');
    $actuate = DEFAULT_ACTUATE if (length($actuate) == 0);
    return($actuate);
}

sub set_actuate()
{
    my($this, $actuate) = @_;
    if (defined($actuate)) {
	if (not grep(/$actuate/, @VALID_ACTUATES)) {
	    carp("Invalid $TAG_NAME 'actuate' attribute value: $actuate!");
	    return(undef);
	}
	$this->_get_XMLDOM->setAttribute('actuate', $actuate);
    } else {
	$this->_get_XMLDOM->removeAttribute('actuate');
    }
    return($this->get_actuate);
}

sub get_encoding()
{
    my($this) = @_;
    my($encoding);
    $encoding = $this->_get_XMLDOM->getAttribute('encoding');
    $encoding = DEFAULT_ENCODING if (length($encoding) == 0);
    return($encoding);
}

sub set_encoding()
{
    my($this, $encoding) = @_;
    if (defined($encoding)) {
	if (not grep(/$encoding/, @VALID_ENCODINGS)) {
	    carp("Invalid $TAG_NAME 'encoding' attribute value: $encoding!");
	    return(undef);
	}
	$this->_get_XMLDOM->setAttribute('encoding', $encoding);
    } else {
	$this->_get_XMLDOM->removeAttribute('encoding');
    }
    return($this->get_encoding);
}

sub get_expires()
{
    my($this) = @_;
    my($expires);
    $expires = $this->_get_XMLDOM->getAttribute('expires');
    $expires = undef if (length($expires) == 0);
    return($expires);
}

sub set_expires()
{
    my($this, $expires) = @_;
    if (defined($expires)) {
	$this->_get_XMLDOM->setAttribute('expires', $expires);
    } else {
	$this->_get_XMLDOM->removeAttribute('expires');
    }
    return($this->get_expires);
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

sub get_rights()
{
    my($this) = @_;
    my($rights);
    $rights = $this->_get_XMLDOM->getAttribute('rights');
    $rights = undef if (length($rights) == 0);
    return($rights);
}

sub set_rights()
{
    my($this, $rights) = @_;
    if (defined($rights)) {
	$this->_get_XMLDOM->setAttribute('rights', $rights);
    } else {
	$this->_get_XMLDOM->removeAttribute('rights');
    }
    return($this->get_rights);
}

sub get_type()
{
    my($this) = @_;
    my($type);
    $type = $this->_get_XMLDOM->getAttribute('type');
    $type = DEFAULT_TYPE if (length($type) == 0);
    return($type);
}

sub set_type()
{
    my($this, $type) = @_;
    if (defined($type)) {
	if (not grep(/$type/, @VALID_TYPES)) {
	    carp("Invalid $TAG_NAME 'type' attribute value: $type!");
	    return(undef);
	}
	$this->_get_XMLDOM->setAttribute('type', $type);
    } else {
	$this->_get_XMLDOM->removeAttribute('type');
    }
    return($this->get_type);
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
# of their arguments, the VOTABLE object, and the underlying XML::DOM
# objects.

#------------------------------------------------------------------------------

# _build_from_XMLDOM()

# This internal method is used to assemble a VOTABLE::STREAM object
# from a XML::DOM::Element object. Return 1 on success, or 0 on
# failure.

# Since the STREAM element is a Tier 0 element, there is nothing for
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
