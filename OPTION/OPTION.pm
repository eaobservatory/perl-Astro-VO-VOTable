# OPTION.pm

=pod

=head1 NAME

VOTABLE::OPTION - VOTABLE OPTION XML element class

=head1 SYNOPSIS

C<use VOTABLE::OPTION;>

=head1 DESCRIPTION

This class implements the C<OPTION> element from the C<VOTABLE>
DTD. This element is used to enumerate multiple possible values for an
item.

The C<OPTION> element is a Tier 1 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT OPTION (OPTION*)>
 <!ATTLIST OPTION
         name CDATA #IMPLIED
         value CDATA #REQUIRED
 >

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::OPTION> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::OPTION> object. Return undef if an error occurs.

=head3 C<get_name>

Return the value of the C<name> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_name($name)>

Set the value of the C<name> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
occurs.

=head3 C<get_value>

Return the value of the C<value> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_value($value)>

Set the value of the C<value> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> if an error
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
C<VOTABLE::OPTION> object I<always> has an underlying
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

C<VOTABLE>, C<VOTABLE::VALUES>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: OPTION.pm,v 1.1.1.8 2002/05/21 14:12:00 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: OPTION.pm,v $
# Revision 1.1.1.8  2002/05/21  14:12:00  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.7  2002/05/21  13:46:28  elwinter
# kefile.PL
#   drwxr-xr-x   3 elwinter users       4096 May 21 00:18 OP
#
# Revision 1.1.1.6  2002/05/14  17:45:52  elwinter
# Chanegd undef list returns to empty lists.
#
# Revision 1.1.1.5  2002/05/08  12:59:29  elwinter
# Fixed bug for string argument to constructor.
#
# Revision 1.1.1.4  2002/05/07  16:09:44  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/05/06  17:22:21  elwinter
# Overhauled.
#
# Revision 1.1.1.2  2002/04/28  15:19:46  elwinter
# Added constructor and attribute accessors.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::OPTION;

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

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'OPTION';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Element';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('name', 'value');

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

    # Construct the VOTABLE::OPTION object from the XML::DOM object.
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

sub get_name()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('name'));
}

sub set_name()
{
    my($this, $name) = @_;
    $this->_get_XMLDOM->setAttribute('name', $name);
    return($this->get_name);
}

sub get_value()
{
    my($this) = @_;
    return($this->_get_XMLDOM->getAttribute('value'));
}

sub set_value()
{
    my($this, $value) = @_;
    $this->_get_XMLDOM->setAttribute('value', $value);
    return($this->get_value);
}

#------------------------------------------------------------------------------

# Element accessor methods

#------------------------------------------------------------------------------

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
    my($this, @votable_option) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to current VOTABLE::OPTION object.
    my($votable_option);

    # Temporary arrays of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Validate the input.
    foreach $votable_option (@votable_option) {
	if (ref($votable_option) ne 'VOTABLE::OPTION') {
	    carp('Invalid object class: ' . ref($votable_option));
	    return(());
	}
    }

    # Link the new elements to this VOTABLE object.
    $this->{'OPTION'} = [@votable_option];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Attach each OPTION XML::DOM::Element to the
    # XML::DOM::Document. THIS IS IMPORTANT!
    foreach $votable_option (@votable_option) {
	$votable_option->_get_XMLDOM->
	    setOwnerDocument($xmldom_element_this->getOwnerDocument);
    }

    # If any OPTION elements exist for the this object, delete
    # them. Then add each of the new OPTION elements.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('OPTION', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }
    foreach $votable_option (@votable_option) {
	$xmldom_element_this->
	    appendChild($votable_option->_get_XMLDOM);
    }

    # Return the new objects.
    return($this->get_option);

}

#------------------------------------------------------------------------------

# PCDATA accessor methods

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

    # New OPTION elements, single and all.
    my($votable_option, @votable_option);

    # Temporary reference to current XML::DOM::Element.
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $xmldom_element_this = $this->_get_XMLDOM;

    #--------------------------------------------------------------------------

    # OPTION

    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('OPTION', 0);
    foreach $xmldom_element (@xmldom_elements) {
	$votable_option = new VOTABLE::OPTION $xmldom_element;
	push(@votable_option, $votable_option);
    }
    $this->set_option(@votable_option);

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
