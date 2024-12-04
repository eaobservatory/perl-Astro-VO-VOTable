# Document.pm

=pod

=head1 NAME

VOTABLE::Document - VOTABLE XML document class

=head1 SYNOPSIS

C<use VOTABLE::Document>;

=head1 DESCRIPTION

This class implements the C<VOTABLE> element from the C<VOTABLE>
DTD. This element is the document element for C<VOTABLE> documents.

The C<VOTABLE> element is a Tier 6 element, and is described by the
following excerpt from the C<VOTABLE> 1.0 DTD:
<
 !ELEMENT VOTABLE (DESCRIPTION?, DEFINITIONS?, INFO*, RESOURCE*)>
 <!ATTLIST VOTABLE
         ID ID #IMPLIED
         version CDATA #IMPLIED
 >

=head2 Methods

=head3 C<new($str_or_ref, %options)>

Create a new C<VOTABLE::Document> object, and return a reference to
it. If the first argument (C<$str_or_ref>) is a string, it is used as
the XML content of the document. If the first argument is a reference
to an open FileHandle object, it is used as the source of the XML
stream used to create the document. If the first argument is a
reference to a C<XML::DOM::Document> object, that object is used to
initialize the new C<VOTABLE> element (implicitly assuming that the
C<XML::DOM::Document> object contains a valid C<VOTABLE> element). The
C<%options> hash is used to set the attributes of the new element. If
the first argument is missing or undefined, or an empty string, create
and return an empty C<VOTABLE::Document> object. Return C<undef> if an
error occurs.

=head3 C<new_from_filename($filename, %options)>

This is the alternate class constructor. The first argument is
interpreted as the name of a file from which to read the
XML. C<%options> is used to set the attributes of the new
element. Return C<undef> if an error occurs.

=head3 C<get_ID>

Return the value of the C<ID> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_ID($id)>

Set the value of the C<ID> attribute to the specified value. Return
the new value of the attribute on success, or C<undef> on error.

=head3 C<get_version>

Return the value of the C<version> attribute. Return C<undef> if the
attribute has not been set, or an error occurs.

=head3 C<set_version($version)>

Set the value of the C<version> attribute to the specified
value. Return the new value of the attribute on success, or C<undef>
on error.

=head3 C<get_description>

Return the C<VOTABLE::DESCRIPTION> object for this
C<VOTABLE::Document>. If no description is found, or an error occurs,
return C<undef>.

=head3 C<set_description($votable_description)>

Set the C<DESCRIPTION> element for this object to the supplied
C<VOTABLE::DESCRIPTION> object. Return the C<VOTABLE::DESCRIPTION>
object on success, or C<undef> if an error occurs.

=head3 C<get_definitions>

Return a the C<VOTABLE::DEFINITIONS> object for this
C<VOTABLE::Document>. If no C<DEFINITIONS> element is found, or an
error occurs, return C<undef>.

=head3 C<set_definitions($votable_definitions)>

Set the C<DEFINITIONS> element for this object to the supplied
C<VOTABLE::DEFINITIONS> object. Return the C<VOTABLE::DEFINITIONS>
object on success, or C<undef> if an error occurs.

=head3 C<get_info>

Return a list of the C<VOTABLE::INFO> objects representing the C<INFO>
elements for this object. If no C<INFO> elements are found, or an
error occurs, return an empty list.

=head3 C<set_info(@votable_info)>

Set the C<INFO> elements for this object to the supplied list of
C<VOTABLE::INFO> objects. Return the input list on success, or an
empty list on error.

=head3 C<get_resource>

Return a list of the C<VOTABLE::RESOURCE> objects representing the
C<RESOURCE> elements for this object. If no C<RESOURCE> elements are
found, or an error occurs, return an empty list.

=head3 C<set_resource(@votable_resource)>

Set the C<RESOURCE> elements for this object to the supplied list of
C<VOTABLE::RESOURCE> objects. Return the input list on success, or an
empty list on error.

=head2 Notes on class internals

=over 4

=item *

WARNING: The information in this section is for code maintainers only.

=item *

This class (along with the other VOTABLE classes) makes extensive use
of internal methods. The internal method names always start with a
leading underscore (C<_>), and should only be used by other methods in
the class, or subclasses.

=item *

To further delineate the C<VOTABLE> and C<XML::DOM> class hierarchies,
any variable (other than the traditional C<$this>) that refers to a
C<XML::DOM> object has the C<xmldom_> prefix, while variables that
refer to C<VOTABLE> objects use the C<votable_> prefix. Again, this is
probably verbosity overkill, but I'd rather be safe than sorry right
now.

=item *

A general design principle for this software is that the user should
not be aware of the use of the underlying representation (C<XML::DOM>
in this case), so that it can be changed in the future.

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

This code assumes (perhaps unwisely) that C<XML::DOM> methods and
subroutines never fail, and that the internal structure of C<VOTABLE>
and C<XML::DOM> objects is always consistent. This decision was made
to speed initial development.

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

C<VOTABLE>, C<VOTABLE::DEFINITIONS>, C<VOTABLE::DESCRIPTION>,
C<VOTABLE::INFO>, C<VOTABLE::RESOURCE>

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: Document.pm,v 1.1.1.22 2002/06/09 21:13:08 elwinter Exp $

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: Document.pm,v $
# Revision 1.1.1.22  2002/06/09  21:13:08  elwinter
# Sert version to 0.03.
#
# Revision 1.1.1.21  2002/06/09  19:47:30  elwinter
# Changed required Perl version to 5.6.1.
#
# Revision 1.1.1.20  2002/06/08  20:41:42  elwinter
# Fixed bug in element insertion order.
#
# Revision 1.1.1.19  2002/05/21  14:09:55  elwinter
# Incremented $VERSION to 0.02.
#
# Revision 1.1.1.18  2002/05/21  13:40:59  elwinter
# Overhauled and updated documentation.
#
# Revision 1.1.1.17  2002/05/14  22:56:59  elwinter
# Added print method.
#
# Revision 1.1.1.16  2002/05/14  17:32:57  elwinter
# Changed undef list returns to empty lists.
#
# Revision 1.1.1.15  2002/05/14  15:56:37  elwinter
# Changed nextSibling to getNextSibling (doh!).
#
# Revision 1.1.1.14  2002/05/14  15:53:38  elwinter
# Fixed nextNext typos.
#
# Revision 1.1.1.13  2002/05/14  15:16:10  elwinter
# Overhauled.
#
# Revision 1.1.1.12  2002/05/06  17:45:22  elwinter
# Overhauled.
#
# Revision 1.1.1.11  2002/05/02  13:42:53  elwinter
# Overhauled element accessors.
#
# Revision 1.1.1.10  2002/04/29  15:46:24  elwinter
# Added code for RESOURCE elements.
#
# Revision 1.1.1.9  2002/04/29  15:05:15  elwinter
# Added support for multiple INFO elements.
#
# Revision 1.1.1.8  2002/04/28  21:07:23  elwinter
# Added code to support DEFINITIONS element.
#
# Revision 1.1.1.7  2002/04/28  12:38:53  elwinter
# Added use directives for DEFINITIONS, INFO, and RESOURCE elements.
#
# Revision 1.1.1.6  2002/04/27  13:34:06  elwinter
# Added convenience methods get_description_text() and set_description_text().
#
# Revision 1.1.1.5  2002/04/27  12:12:15  elwinter
# Complete overhaul to ensure proper mapping from XML::DOM to VOTABLE objects.
#
# Revision 1.1.1.4  2002/04/25  15:46:37  elwinter
# Rearranged code. Added factory parser for document creation.
#
# Revision 1.1.1.3  2002/04/25  13:36:01  elwinter
# Added code for accessor methods for ID and version attributes.
#
# Revision 1.1.1.2  2002/04/25  13:19:19  elwinter
# Added new() and new_from_filename() methods.
#

#******************************************************************************

# Begin the package definition.
package VOTABLE::Document;

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
use VOTABLE::DEFINITIONS;
use VOTABLE::DESCRIPTION;
use VOTABLE::INFO;
use VOTABLE::RESOURCE;

#------------------------------------------------------------------------------

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'VOTABLE';

# Name of underlying XML::DOM object class.
my($XMLDOM_BASE_CLASS) = 'XML::DOM::Document';

# List of valid attributes for this element.
my(@valid_attribute_names) = ('ID', 'version');

# This is the XML string to use when creating a new, empty XML::DOM
# object for a VOTABLE::Document object.
use constant VOTABLE_XML_TEMPLATE => << '_EOS_'
<?xml version="1.0"?>
<!DOCTYPE  VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
</VOTABLE>
_EOS_
    ;

#------------------------------------------------------------------------------

# Class variables.

# Parser to create Document objects.
my($xmldom_parser_factory) = new XML::DOM::Parser;

#******************************************************************************

# Class methods

#------------------------------------------------------------------------------

# INIT()

# This subroutine is run just before the main program starts. It is
# used to initialize the package as a whole.

sub INIT()
{

    # Create the factory parser.
    $xmldom_parser_factory = new XML::DOM::Parser;
    if (not $xmldom_parser_factory) {
	croak('Unable to create factory parser!');
    }

}

sub new()
{

    # Save arguments.
    # $class is the class name for the new object.
    # @options contains all of the remaining options used when the
    # constructor is invoked.
    my($class, @options) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Document for the VOTABLE element.
    my($xmldom_document_this);

    # Reference to open filehandle to read XML from.
    my($fh);

    # String with initial text for XML.
    my($str);

    # Hash containing keyword-value pairs to initialize attributes.
    my(%attributes);

    # Current attribute name and value.
    my($attribute_name, $attribute_value);

    # Reference to new object.
    my($this);

    # Code string for eval.
    my($set_attribute);

    #--------------------------------------------------------------------------

    # Process the options.
    if (@options) {
	if (ref($options[0]) eq $XMLDOM_BASE_CLASS) {
	    ($xmldom_document_this, %attributes) = @options;
	} elsif (ref($options[0]) eq 'FileHandle') {
	    ($fh, %attributes) = @options;
	} else {
	    ($str, %attributes) = @options;
	}
    }

    # Make sure only valid attributes were specified.
    foreach $attribute_name (keys(%attributes)) {
 	if (not grep(/$attribute_name/, @valid_attribute_names)) {
 	    carp("Invalid $TAG_NAME attribute name: $attribute_name!");
 	    return(undef);
 	}
    }

    #--------------------------------------------------------------------------

    # Create the object as an empty hash.
    $this = {};

    # Bless the object.
    bless $this => $class;

    # Fill in the object.
    if ($xmldom_document_this) {

	# Save the specified XML::DOM::Document.

    } elsif ($fh) {

	# Create the XML::DOM::Document by parsing the contents of the
	# file.
	$xmldom_document_this = $xmldom_parser_factory->parse($fh);

    } elsif ($str) {

	# Create the XML::DOM::Document by parsing the string.
	$xmldom_document_this = $xmldom_parser_factory->parse($str);

    } else {

	# Create an empty XML::DOM::Document from a minimal string.
	$xmldom_document_this =
	    $xmldom_parser_factory->parse(VOTABLE_XML_TEMPLATE);

    }

    # Save the XML::DOM::Document object, regardless of source.
    if ($this->_set_XMLDOM($xmldom_document_this) ne $xmldom_document_this) {
	carp("Unable to set $XMLDOM_BASE_CLASS!");
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

    # Construct the VOTABLE object from the XML::DOM object.
    if (not $this->_build_from_XMLDOM) {
  	carp('Unable to build VOTABLE::$TAG_NAME from XML::DOM::Document!');
  	return(undef);
    }

    # Return the new object.
    return($this);

}

#------------------------------------------------------------------------------

# new_from_filename()

# This is an alternate constructor that uses a filename as the input
# source.

sub new_from_filename()
{

    # Save arguments.
    # $class is the class name for the new object. This should be the
    # string 'VOTABLE::Document', unless this method is called from a
    # class that inherits from VOTABLE::Document.
    # $filename is the name of the file to containing the XML.
    my($class, $filename) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to new object.
    my($this);

    # Filehandle object for input.
    my($fh);

    #--------------------------------------------------------------------------

    # A filename must be supplied.
    if (not $filename) {
	carp('A filename must be specified!');
	return(undef);
    }

    # Create a filehandle for the file.
    $fh = new FileHandle $filename;
    if (not $fh) {
	carp("Unable to create filehandle for file $filename!");
	return(undef);
    }

    # Parse the input and create the object.
    $this = new VOTABLE::Document $fh;
    if (not $this) {
	carp("Unable to create $class from file $filename!");
	return(undef);
    }

    # Close the filehandle and remove it.
    if (not $fh->close) {
	carp("Unable to close file $filename!");
	return(undef);
    }
    undef($fh);

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------

# print()

# Print the XML tree for this document.

sub print()
{
    my($this, $fh) = @_;
    $this->_get_XMLDOM->print($fh);
    return(1);
}

#------------------------------------------------------------------------------

# Attribute accessor methods

#------------------------------------------------------------------------------

sub get_ID()
{
    my($this) = @_;
    $this->_get_XMLDOM->getDocumentElement->getAttribute('ID');
}

sub set_ID()
{
    my($this, $id) = @_;
    $this->_get_XMLDOM->getDocumentElement->setAttribute('ID', $id);
    return($this->get_ID);
}

sub get_version()
{
    my($this) = @_;
    $this->_get_XMLDOM->getDocumentElement->getAttribute('version');
}

sub set_version()
{
    my($this, $version) = @_;
    $this->_get_XMLDOM->getDocumentElement->setAttribute('version', $version);
    return($this->get_version);
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
    $xmldom_element_this = $this->_get_XMLDOM->getDocumentElement;

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_description = $votable_description->_get_XMLDOM;
    if (not $xmldom_element_description) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this VOTABLE element already has a DESCRIPTION element,
    # remove the DESCRIPTION element.
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

sub get_definitions()
{
    my($this) = @_;
    if (exists($this->{'DEFINITIONS'})) {
	return($this->{'DEFINITIONS'});
    } else {
	return(undef);
    }
}

sub set_definitions()
{

    # Save arguments.
    my($this, $votable_definitions) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Temporary reference to the XML::DOM::Element for this object.
    my($xmldom_element_this);

    # Reference to the XML::DOM::Document object for the current
    # VOTABLE::DEFINITIONS object.
    my($xmldom_element_definitions);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'DEFINITIONS'} = $votable_definitions;

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM->getDocumentElement;

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_definitions = $votable_definitions->_get_XMLDOM;
    if (not $xmldom_element_definitions) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this VOTABLE element already has a DEFINITIONS element,
    # remove the DEFINITIONS element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DEFINITIONS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the new object to the owner document for this object.
    $xmldom_element_definitions->
	setOwnerDocument($xmldom_element_this->getOwnerDocument);

    # If any child nodes exist for the this object, insert the new
    # DEFINITIONS element as the first child element of this object after
    # any DESCRIPTION. Otherwise, just add the DEFINITIONS element as the
    # first child.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the DEFINITIONS element right after it. Otherwise,
	    # append the DEFINITIONS element.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		$xmldom_element_this->
		    insertBefore($xmldom_element_definitions,
				 $xmldom_elements[0]->getNextSibling);
	    } else {
		$xmldom_element_this->appendChild($xmldom_element_definitions);
	    }

	} else {

	    # No DESCRIPTION element found, so insert the DEFINITIONS
	    # element as the first child.
	    $xmldom_element_this->
		insertBefore($xmldom_element_definitions,
			     $xmldom_element_this->getFirstChild);

	}

    } else {

	# No existing children, so this DEFINITIONS becomes the first
	# child.
	$xmldom_element_this->appendChild($xmldom_element_definitions);

    }

    # Return the new object.
    return($this->get_definitions);

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

    # Single VOTABLE::INFO object.
    my($votable_info);

    # Reference to the XML::DOM::Document object for the current
    # VOTABLE::INFO object.
    my($xmldom_element_info);

    # Temporary array of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'INFO'} = [@votable_info];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM->getDocumentElement;

    # If any INFO elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('INFO', 0)) {
	    foreach $xmldom_element (@xmldom_elements) {
		$xmldom_element_this->removeChild($xmldom_element);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::INFOs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this object.
    foreach $votable_info (@votable_info) {
	$xmldom_element_info = $votable_info->_get_XMLDOM;
	$xmldom_element_info->setOwnerDocument($xmldom_element_this->
					       getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # INFO elements as the first child elements of this object after
    # any DEFINITIONS or DESCRIPTION. Otherwise, just add the INFO
    # elements as the first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements = $xmldom_element_this->
	    getElementsByTagName('DEFINITIONS', 0)) {

	    # If this DEFINITIONS element is not the last child,
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

	} elsif (@xmldom_elements = $xmldom_element_this->
	    getElementsByTagName('DESCRIPTION', 0)) {

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

	    # No DESCRIPTION or DEFINITIONS element found, so insert
	    # the INFO elements as the first children.
	    foreach $votable_info (reverse(@votable_info)) {
		$xmldom_element_info = $votable_info->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_info,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the INFO become the first children.
	foreach $votable_info (@votable_info) {
	    $xmldom_element_info = $votable_info->_get_XMLDOM; 
	    $xmldom_element_this->appendChild($xmldom_element_info);
	}

    }

    # Return the new objects.
    return($this->get_info);

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

    # Single VOTABLE::RESOURCE object.
    my($votable_resource);

    # Reference to the XML::DOM::Document object for the current
    # VOTABLE::RESOURCE object.
    my($xmldom_element_resource);

    # Temporary array of XML::DOM::Element objects, and a single.
    my(@xmldom_elements);
    my($xmldom_element);

    #--------------------------------------------------------------------------

    # Link the objects at the VOTABLE level.
    $this->{'RESOURCE'} = [@votable_resource];

    #--------------------------------------------------------------------------

    # Link the objects at the XML::DOM level.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->_get_XMLDOM->getDocumentElement;

    # If any RESOURCE elements exist for the this object, delete them.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements =
	    $xmldom_element_this->getElementsByTagName('RESOURCE', 0)) {
	    foreach $xmldom_element (@xmldom_elements) {
		$xmldom_element_this->removeChild($xmldom_element);
	    }
	}
    }

    # Set the owner XML::DOM::Document of the XML::DOM::Element of the
    # new VOTABLE::RESOURCEs to the owner XML::DOM::Document of the
    # XML::DOM::Element of this object.
    foreach $votable_resource (@votable_resource) {
	$xmldom_element_resource = $votable_resource->_get_XMLDOM;
	$xmldom_element_resource->setOwnerDocument($xmldom_element_this->
						   getOwnerDocument);
    }

    # If any child nodes exist for the this object, insert the new
    # RESOURCE elements as the first child elements of this object
    # after the last INFO, or any DEFINITIONS or
    # DESCRIPTION. Otherwise, just add the RESOURCE elements as the
    # first children.
    if ($xmldom_element_this->hasChildNodes) {
	if (@xmldom_elements = $xmldom_element_this->
	    getElementsByTagName('INFO', 0)) {

	    # If this INFO element is not the last child,
	    # insert the RESOURCE elements right after it. Otherwise,
	    # append the RESOURCE elements.
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

	} elsif (@xmldom_elements = $xmldom_element_this->
	    getElementsByTagName('DEFINITIONS', 0)) {

	    # If this DEFINITIONS element is not the last child,
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

	} elsif (@xmldom_elements = $xmldom_element_this->
	    getElementsByTagName('DESCRIPTION', 0)) {

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

	    # No DESCRIPTION, DEFINITIONS, or INFO elements found, so
	    # insert the RESOURCE elements as the first children.
	    foreach $votable_resource (reverse(@votable_resource)) {
		$xmldom_element_resource =
		    $votable_resource->_get_XMLDOM;
		$xmldom_element_this->
		    insertBefore($xmldom_element_resource,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the RESOURCEs become the first
	# children.
	foreach $votable_resource (@votable_resource) {
	    $xmldom_element_resource =
		$votable_resource->_get_XMLDOM ; 
	    $xmldom_element_this->appendChild($xmldom_element_resource);
	}

    }

    # Return the new object.
    return($this->get_resource);

}

#------------------------------------------------------------------------------

# PCDATA content accessor methods

#------------------------------------------------------------------------------

# Internal methods

#------------------------------------------------------------------------------

# _build_from_XMLDOM()

sub _build_from_XMLDOM()
{

    # Save arguments.
    my($this) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to XML::DOM::Document object for this object.
    my($xmldom_document_this);

    # Reference to the XML::DOM::Element object underlying the
    # XML::DOM::Document object for this object.
    my($xmldom_document_element_this);

    # Temporary array of XML::DOM::Element objects.
    my(@xmldom_elements);

    # Reference to new VOTABLE::DESCRIPTION object.
    my($votable_description);

    # Reference to new VOTABLE::DEFINITIONS object.
    my($votable_definitions);

    # Single new, and array of new VOTABLE::INFO objects.
    my($votable_info);
    my(@votable_info);

    # Single new, and array of new VOTABLE::RESOURCE objects.
    my($votable_resource);
    my(@votable_resource);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Get references to the XML::DOM::Document object for this object,
    # and the underlying XML::DOM::Element object.
    $xmldom_document_this = $this->_get_XMLDOM;
    $xmldom_document_element_this = $xmldom_document_this->getDocumentElement;

    # Return if the document is empty.
    return if (not $xmldom_document_element_this->hasChildNodes);

    #--------------------------------------------------------------------------

    # DESCRIPTION

    # Get a list of all DESCRIPTION elements.
    if (@xmldom_elements = $xmldom_document_element_this->
	getElementsByTagName('DESCRIPTION', 0)) {
 	$votable_description = new VOTABLE::DESCRIPTION $xmldom_elements[0];
 	$this->set_description($votable_description);
    }

    #--------------------------------------------------------------------------

    # DEFINITIONS

    # Get a list of all DEFINITIONS elements.
    if (@xmldom_elements = $xmldom_document_element_this->
 	getElementsByTagName('DEFINITIONS', 0)) {
 	$votable_definitions = new VOTABLE::DEFINITIONS $xmldom_elements[0];
 	$this->set_definitions($votable_definitions);
    }

    #--------------------------------------------------------------------------

    # INFO

    # Get a list of all INFO elements.
    if (@xmldom_elements = $xmldom_document_element_this->
 	getElementsByTagName('INFO', 0)) {
 	for ($i = 0; $i < @xmldom_elements; $i++) {
 	    $votable_info = new VOTABLE::INFO $xmldom_elements[$i];
 	    push(@votable_info, $votable_info);
 	}
 	$this->set_info(@votable_info);
    }

    #--------------------------------------------------------------------------

    # RESOURCE

    # Get a list of all RESOURCE elements.
    if (@xmldom_elements = $xmldom_document_element_this->
 	getElementsByTagName('RESOURCE', 0)) {
 	for ($i = 0; $i < @xmldom_elements; $i++) {
 	    $votable_resource = new VOTABLE::RESOURCE $xmldom_elements[$i];
 	    push(@votable_resource, $votable_resource);
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
# XML::DOM::Document object.

sub _get_XMLDOM()
{
    my($this) = @_;
    return($this->{$XMLDOM_BASE_CLASS});
}

#------------------------------------------------------------------------------

# _set_XMLDOM()

# Internal method to set the reference to the underlying
# XML::DOM::Document object. Return the reference to the new
# XML::DOM::Document.

sub _set_XMLDOM()
{
    my($this, $xmldom_document) = @_;
    $this->{$XMLDOM_BASE_CLASS} = $xmldom_document;
    return($this->{$XMLDOM_BASE_CLASS});
}

#******************************************************************************
1;
__END__
