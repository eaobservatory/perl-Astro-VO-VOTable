# TABLEDATA.pm

=pod

=head1 NAME

VOTABLE::TABLEDATA - VOTABLE TABLEDATA XML element class

=head1 SYNOPSIS

C<use VOTABLE::TABLEDATA;>

=head1 DESCRIPTION

This class implements the C<TABLEDATA> element from the C<VOTABLE>
DTD. This element is the container for completely self-contained,
XML-formatted data tables.

The C<TABLEDATA> element is a Tier 2 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:

 <!ELEMENT TABLEDATA (TR*)>

=head2 Methods

=head3 C<new($xmldom_element, %options)>

Create and return a new C<VOTABLE::TABLEDATA> object, based on the
supplied C<XML::DOM::Element> object, using C<%options> to set the
attributes of the new object. If no C<XML::DOM::Element> object is
specified, or is undefined, create and return an empty
C<VOTABLE::TABLEDATA> object. Return C<undef> if an error occurs.

=head3 C<get_tr>

Return a list of the C<VOTABLE::TR> objects for the C<TR> elements
which are the children of this C<TABLEDATA> element. Return an empty
list if no C<TR> elements are found, or if an error occurs.

=head3 C<set_tr(@votable_tr)>

Set the C<TR> elements for this C<TABLEDATA> element using the
supplied list of C<VOTABLE::TR> objects. Any previously existing C<TR>
elements are first removed. Return the input list on success, or an
empty list if an error occurs.

=head3 C<append_tr($votable_tr)>

Append the specified C<TR> element to the end of the list of C<TR>
elements for this C<TABLEDATA> element. Return the new C<TR> element
on success, or C<undef> if an error occurs.

=head3 C<get_row($rownum)>

Return the contents of row C<$rownum> as a list. Return an empty list
if an error occurs.

=head3 C<set_row($rownum, @values)>

Set the values of row C<$rownum> using the values in the array
C<@values>. Return the new values on success, or an empty list if an
error occurs.

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

C<VOTABLE>, C<VOTABLE::DATA>, C<VOTABLE::TR>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: TABLEDATA.pm,v 1.1.1.13 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: TABLEDATA.pm,v $
# Revision 1.1.1.13  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.12  2002/06/09  19:53:56  elwinter
# Changed required Perl version to 5.6.1.
#
# Revision 1.1.1.11  2002/06/08  21:13:50  elwinter
# Minor doc bug fix.
#
# Revision 1.1.1.10  2002/05/24  14:42:15  elwinter
# Added set_row() method.
#
# Revision 1.1.1.9  2002/05/23  13:12:53  elwinter
# Added get_row() method.
#
# Revision 1.1.1.8  2002/05/22  12:21:32  elwinter
# Added append_tr() method.
#
# Revision 1.1.1.7  2002/05/21  14:13:34  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.6  2002/05/21  13:49:42  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.5  2002/05/14  17:43:00  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.4  2002/05/09  15:02:06  elwinter
# Overhauled.
#
# Revision 1.1.1.3  2002/05/03  18:12:14  elwinter
# Overhauled.
#
# Revision 1.1.1.2  2002/04/28  19:28:37  elwinter
# Added constructor.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::TABLEDATA;

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
use VOTABLE::TR;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'TABLEDATA';

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

    # Construct the VOTABLE::TABLEDATA object from the XML::DOM
    # object.
    if (not $this->_build_from_XMLDOM) {
	carp("Unable to build VOTABLE::$TAG_NAME object from " .
	     "XML::DOM::Element!");
	return(undef);
    }

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------

# get_row()

# Return the contents of row $rownum as a list, or an empty list if an
# error occurs.

sub get_row()
{

    # Save arguments.
    my($this, $rownum) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Array to hold TR elements.
    my(@votable_tr);

    # Array to hold row contents.
    my(@row);

    #--------------------------------------------------------------------------

    # Fetch the list of TR elements for this element.
    @votable_tr = $this->get_tr;
    if (@votable_tr == 0) {
	carp('No TR elements found!');
	return(());
    }

    # Check that the desired TR exists.
    if (not exists($votable_tr[$rownum])) {
	carp("Row $rownum not found!");
	return(());
    }

    # Convert the TR element to an array of values.
    @row = $votable_tr[$rownum]->as_array;

    # Return the row contents.
    return(@row);

}

#------------------------------------------------------------------------------

# set_row()

# Set the contents of row $rownum using the array @values. Return the
# new values on success, or an empty list if an error occurs.

sub set_row()
{

    # Save arguments.
    my($this, $rownum, @values) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Array to hold TR elements.
    my(@votable_tr);

    #--------------------------------------------------------------------------

    # Fetch the list of TR elements for this element.
    @votable_tr = $this->get_tr;
    if (@votable_tr == 0) {
	carp('No TR elements found!');
	return(());
    }

    # Check that the desired TR exists.
    if (not exists($votable_tr[$rownum])) {
	carp("Row $rownum not found!");
	return(());
    }

    # Set the TR element with the array of values.
    $votable_tr[$rownum]->from_array(@values);

    # Return the row contents.
    return(@values);

}

#------------------------------------------------------------------------------

# Attribute accessor methods

#------------------------------------------------------------------------------

# Element accessor methods

#------------------------------------------------------------------------------

sub get_tr()
{
    my($this) = @_;
    if (exists($this->{'TR'})) {
	return(@{$this->{'TR'}});
    } else {
	return(());
    }
}

sub set_tr()
{

    # Save arguments.
    my($this, @votable_tr) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to current VOTABLE::TR object.
    my($votable_tr);

    # Temporary arrays of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Validate the input.
    foreach $votable_tr (@votable_tr) {
	if (ref($votable_tr) ne 'VOTABLE::TR') {
	    carp('Invalid object class: ' . ref($votable_tr));
	    return(());
	}
    }

    # Link the new elements to this VOTABLE object.
    $this->{'TR'} = [@votable_tr];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Attach each INFO XML::DOM::Element to the
    # XML::DOM::Document. THIS IS IMPORTANT!
    foreach $votable_tr (@votable_tr) {
	$votable_tr->_get_XMLDOM->setOwnerDocument($xmldom_element_this->
						   getOwnerDocument);
    }

    # If any TR elements exist for the this object, delete them. Then
    # add each of the new TR elements.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('TR', 0)) {
	    for ($i = 0; $i < @xmldom_elements; $i++) {
		$xmldom_element_this->removeChild($xmldom_elements[$i]);
	    }
	}
    }
    foreach $votable_tr (@votable_tr) {
	$xmldom_element_this->
	    appendChild($votable_tr->_get_XMLDOM);
    }

    # Return the new objects.
    return($this->get_tr);

}

sub append_tr()
{

    # Save arguments.
    my($this, $votable_tr) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Element object for this object.
    my($xmldom_element_this);

    # Reference to XML::DOM::Element object for the new TR.
    my($xmldom_element_tr);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    push(@{$this->{'TR'}}, $votable_tr);

    #--------------------------------------------------------------------------

    # Get a reference to the XML::DOM::Element object for this object.
    $xmldom_element_this = $this->_get_XMLDOM;

    # Get a reference to the XML::DOM::Element object for the new TR.
    $xmldom_element_tr = $votable_tr->_get_XMLDOM;

    # Attach the TR element to the current document.
    $xmldom_element_tr->setOwnerDocument($xmldom_element_this->
					 getOwnerDocument);

    # Append the TR to the TABLEDATA.
    $xmldom_element_this->appendChild($xmldom_element_tr);

    # Return the new object.
    return($votable_tr);

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

    # Reference to XML::DOM::Element object for current VOTABLE object.
    my($xmldom_element_this);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # New TR element, single and all.
    my($votable_tr, @votable_tr);

    # Temporary reference to current XML::DOM::Element.
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Fetch the current XML::DOM::Element object.
    $xmldom_element_this = $this->{'XML::DOM::Element'};

    #--------------------------------------------------------------------------

    # TR

    # There should be at least one TR, eventually.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('TR', 0)) {
	foreach $xmldom_element (@xmldom_elements) {
	    $votable_tr = new VOTABLE::TR $xmldom_element;
	    push(@votable_tr, $votable_tr);
	}
	$this->set_tr(@votable_tr);
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
