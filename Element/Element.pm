# Element.pm

=pod

=head1 NAME

VOTABLE::Element - VOTABLE XML element class

=head1 SYNOPSIS

C<use VOTABLE::Element>

C<$votable_element = new VOTABLE::Element>

C<$votable_element = new VOTABLE::Element undef, a1 =E<gt> v1, a2 =E<gt> v2, ...>

C<$votable_element = new VOTABLE::Element $xml_string>

C<$votable_element = new VOTABLE::Element $xml_string, a1 =E<gt> v1, a2 =E<gt> v2, ...>

C<$votable_element = new VOTABLE::Element $xmldom_element>

C<$votable_element = new VOTABLE::Element $xmldom_element, a1 =E<gt> v1, a2 =E<gt> v2, ...>

=head1 DESCRIPTION

This class is a VOTABLE-specific wrapper around the
C<XML::DOM::Element> class. It provides the base functionality for all
VOTABLE element classes, and allows access to implementation-specific
details, such as C<the XML::DOM::Element> objects embedded within the
VOTABLE objects. The typical user should never need access to the
implementation-specific details, so these base methods are for use
primarily by other VOTABLE objects. This approach was taken to allow
modification of the underlying XML technology (currently C<XML::DOM>,
but we may use something else later) without changing the user API.

The overall design of the VOTABLE objects is straightforward. Each XML
element in the VOTABLE DTD is represented by a class. Each element
class is a subclass of C<VOTABLE::Element> (this class). Within each
element class, there are attributes and child elements, along with
implementation-specific data, such as references to the underlying
C<XML::DOM> objects.

Attributes are manipulated using C<get_ATTNAME> and C<set_ATTNAME>
methods (accessors), where C<ATTNAME> is replaced by the name of the
attribute in question. The C<set> methods take a single argument (the
value to set the attribute to), and the C<get> methods take no
arguments. Since attributes can only take single values, all
C<set_ATTNAME> methods take single scalars as arguments, and
C<get_ATTNAME> methods return single scalars. All C<set_ATTNAME>
methods return the newly-set value on success, or C<undef> if an error
occurs.

Child elements have similar accessors, of the form C<get_ELNAME> and
C<set_ELNAME>, where C<ELNAME> is replaced by the name of the element
(more precisely, the name of the element I<tag>, such as C<TABLEDATA>
for a C<TABLEDATA> element). Note that these names, and the methods,
are case-sensitive. The type of arguments passed to and returned from
the element accessors is determined by the multiplicity of the child
elements (as defined by the VOTABLE DTD). Elements which can occur 0
or 1 times (those which are unquantified, or quantified with a '?' in
the DTD) are passed and returned as scalars, while elements which can
occur 1 or more times (those quantified with a '+' or '*' in the DTD)
are passed and returned as lists. Like C<set_ATTNAME> accessors,
C<set_ELNAME> accessors return the new value(s) on success. On
failure, scalar-returning methods return C<undef>, while
list-returning methods return an empty list.

=head2 Methods

=head3 C<new($str_or_ref, %options)>

This is the class constructor. C<$str_or_ref>, if defined, contains a
string of XML to use to initialize the new object, or a reference to
an existing C<XML::DOM::Element> object to use to initialize the new
object. If C<$str_or_ref> is undefined, a new, empty
C<XML::DOM::Element> object is created for the new object. The
C<%options> argument contains 0 or more C<key =E<gt> value> pairs to
use when setting the initial values of the element attributes. On
success, this method returns the blessed refrence for the new
object. On failure, this method returns C<undef>.

=head1 WARNINGS

=over 4

=item *

This code (perhaps unwisely) assumes that object internal structure is
always maintained. For example, this code assumes that every
C<VOTABLE::Element> I<always> has an underlying C<XML::DOM::Element>
object. When aberrant cases are encountered, an exception is raised
(using the C<Carp::croak> subroutine).

=item *

Similarly, this code assumes that C<XML::DOM> methods always
succeed. When aberrant cases are encountered, an exception is raised
(using the C<Carp::croak> subroutine).

=item *

Attribute and element names containing embedded hyphens ('-') use
accessors where the hyphen is mapped to an underscore ('_') in the
name of the accessor method. This is a necessity, since the hyphen is
not a valid name character in Perl.

=back

=head1 SEE ALSO

I<perl>, I<XML::DOM>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: Element.pm,v 1.1.1.4 2002/06/09 21:13:08 elwinter Exp $

=cut

#******************************************************************************
#******************************************************************************

# Revision history

# $Log: Element.pm,v $
# Revision 1.1.1.4  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.3  2002/06/09  19:48:33  elwinter
# Changed required Perl version to 5.6.1.
#
# Revision 1.1.1.2  2002/05/17  14:13:12  elwinter
# First complete version.
#

#******************************************************************************
#******************************************************************************

# Begin the package definition.
package VOTABLE::Element;

# Specify the minimum acceptable Perl version.
use 5.6.1;

# Turn on strict syntax checking.
use strict;

# Use enhanced diagnostic messages.
use diagnostics;

# Use enhanced warnings.
use warnings;

#******************************************************************************
#******************************************************************************

# Set up the inheritance mexhanism.
our @ISA = qw();

# Module version.
our $VERSION = '0.03';

#******************************************************************************
#******************************************************************************

# Specify external modules to use.

# Standard modules.
use Carp;
use English;
use XML::DOM;

# Third-party modules.

# Project modules.

#******************************************************************************
#******************************************************************************

# Class constants.

# Name of current package.
my($PACKAGE_NAME) = 'VOTABLE::Element';

# Name of current element (a dummy, in this case).
my($TAG_NAME) = 'ELEMENT';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this object.
my(@valid_attribute_names) = ();

#******************************************************************************
#******************************************************************************

# Class variables.

# Factory parser for parsing arbitrary XML strings.
my($xmldom_parser_factory) = new XML::DOM::Parser;

# Factory document for creating XML::DOM objects.
my($xmldom_document_factory) = new XML::DOM::Document;

#******************************************************************************
#******************************************************************************

# Class methods

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#******************************************************************************
#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Constructors and destructors

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# new()

# This is the main constructor for the class.

# The first argument ($class) always contains the class to bless the
# new object into. This will usually be the name of the current class,
# unless this constructor is called for an object that inherits from
# the current class.

# All remaining arguments are stored in the @options array. The first
# additional argument, if it is defined, contains either a string
# containing the XML to use when creating the new object, or a
# reference to an existing XML::DOM::Element object to use for the new
# object. Any additional items in the @options array are assumed to be
# keyword => value pairs to use to initialize the attributes of the
# new object.

# Note that if you want to specify attribute values to the
# constructor, but do not want to specify a string or object reference
# to use, you must pass undef as the first additional argument.

sub new()
{

    # Save arguments.
    # $class is the class name for the new object.
    # @options contains all of the remaining options used when the
    # constructor is invoked.
    my($class, @options) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Name of current method.
    my($method_name) = 'new';

    # Reference to XML::DOM::Element for the new object.
    my($xmldom_element_this);

    # String with initial text for XML.
    my($str);

    # Hash containing keyword-value pairs to initialize attributes.
    my(%attributes);

    # Current attribute name and value.
    my($attribute_name, $attribute_value);

    # Reference to new object.
    my($this);

    # Code string for run-time evaluation of 'set' accessors.
    my($set_attribute);

    #--------------------------------------------------------------------------

    # Process the options.
    if (@options) {
 	if (ref($options[0])) {
 	    if (ref($options[0]) ne $XMLDOM_BASE_CLASS) {
 		carp("$PACKAGE_NAME::$method_name - Bad input class: ",
 		     ref($options[0]), "!\n");
 		return(undef);
 	    }
 	    ($xmldom_element_this, %attributes) = @options;
 	} else {
 	    ($str, %attributes) = @options;
 	}
    }

    # Make sure only valid attribute names were specified.
    foreach $attribute_name (keys(%attributes)) {
  	if (not grep(/$attribute_name/, @valid_attribute_names)) {
  	    carp("Invalid $PACKAGE_NAME attribute name: $attribute_name!");
  	    return(undef);
  	}
    }

    #--------------------------------------------------------------------------

    # Create the object as an empty hash.
    $this = {};

    # Bless the object into the specified class.
    bless $this => $class;

    # Fill in the object.
    if ($xmldom_element_this) {

	# Save the specified XML::DOM::Element.

    } elsif ($str) {

	# Create the element from the string.
	if (not $xmldom_element_this = $this->_new_from_string($str)) {
	    carp("$PACKAGE_NAME::$method_name - Unable to create new " .
		 "element from '$str'!");
	    return(undef);
	}

    } else {

	# Create an empty XML::DOM::Element.
	if (not $xmldom_element_this = $xmldom_document_factory->
	    createElement($TAG_NAME)) {
	    carp("$PACKAGE_NAME::$method_name - Unable to create " .
		 "$XMLDOM_BASE_CLASS for $TAG_NAME!");
	    return(undef);
	}

    }

    # Save the XML::DOM::Element object, regardless of source.
    $this->{$XMLDOM_BASE_CLASS} = $xmldom_element_this;

    # Process any specified attributes. This code assumes that the
    # name of each attribute can be directly mapped to a subroutine
    # name.
    while (($attribute_name, $attribute_value) = each(%attributes)) {
   	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";
  	eval($set_attribute);
   	if ($EVAL_ERROR) {
   	    carp("$PACKAGE_NAME::$method_name - Error evaluating $TAG_NAME " .
		 "'$set_attribute': $EVAL_ERROR!");
   	    return(undef);
   	}
    }

    # Construct the VOTABLE object from the XML::DOM object.
    if (not $this->_build_from_XMLDOM) {
   	carp("$PACKAGE_NAME::$method_name - Unable to build $TAG_NAME " .
	     "from $XMLDOM_BASE_CLASS!");
   	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the new object.
    return($this);

}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Attribute accessor methods.

# These methods assume they are called for a valid VOTABLE
# object. Therefore, no error checking is done on the object
# internals.

# For each attribute get_xxx() method, simply return the result of the
# getAttribute() method for the corresponding attribute of the
# XML::DOM::Element object.

# For each attribute set_xxx() method, validate the new value if
# possible, then call the setAttribute() method for the
# XML::DOM::Element object. Return the new value with a call to the
# getAttribute() method.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Element accessor methods.

# These methods assume they are called for a valid VOTABLE
# object. Therefore, no error checking is done on the object
# internals.

# For each element get_xxx() method, check to see if the element(s)
# exists. If so, return a reference to the VOTABLE object for the
# element (or a list of VOTABLE object references for multiple
# elements). Note that these methods use exists() to check for the
# element(s), to avoid creation on non-existence (which is what
# defined() would do if we used it instead of exists()). If the child
# is not found, return undef. If an error occurs, carp() a message and
# return undef.

# For each set_xxx() method, check to see if the element(s) currently
# exist. If so, remove them before attaching the new elements. Note
# that the set_xxx() methods must maintain the element order specified
# in the DTD. The current object (always referred to as $this) and its
# children must be linked at two levels - the VOTABLE level, and the
# XML::DOM level. Linking at the VOTABLE level is easy, since links
# are unidirectional, from parent to child. At the XML::DOM level,
# many more steps must be taken to establish the links. Return the
# supplied argument, using the matching get_xxx() method, to ensure
# success. Otherwise, carp() and error message and return undef.

# These methods follow the standard naming convention that variables
# referring to VOTABLE objects have a 'votable_' prefix, and those
# referring to XML::DOM objects have a 'xmldom_' prefix.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# PCDATA content accessor methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Internal methods.

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# _build_from_XMLDOM()

# This method does the hard work of mapping an XML::DOM::Element
# object to a VOTABLE::Element object.

sub _build_from_XMLDOM()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to underlying XML::DOM object for this object.
    my($xmldom_element_this);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM object for this object.
    $xmldom_element_this = $this->{$XMLDOM_BASE_CLASS};

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#------------------------------------------------------------------------------

# _new_from_string()

# Internal utility method to parse an XML string and extract a single
# element from it.

sub _new_from_string()
{

    # Save arguments.
    my($this, $str) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Method name.
    my($method_name) = '_new_from_string';

    # Temporary XML document for parsing input string.
    my($xmldom_document_temp);

    # Reference to XML::DOM::Element object for new element.
    my($xmldom_element_new);

    #--------------------------------------------------------------------------

    # Create the XML::DOM::Document by parsing the string.
    if (not $xmldom_document_temp = $xmldom_parser_factory->parse($str)) {
	carp("$PACKAGE_NAME::$method_name - Unable to parse '$str'!");
	return(undef);
    }

    # Get a reference to the new element. This code assumes that the
    # input string contains a single element.
    if (not $xmldom_element_new = $xmldom_document_temp->getDocumentElement) {
	carp("$PACKAGE_NAME::$method_name - Unable to find " .
	     "$XMLDOM_BASE_CLASS!");
	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the new element.
    return($xmldom_element_new);

}

#******************************************************************************
1;
__END__
