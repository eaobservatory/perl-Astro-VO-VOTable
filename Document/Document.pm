# Document.pm

=pod

=head1 NAME
VOTABLE::Document - VOTABLE XML document class

=head1 SYNOPSIS

=head1 DESCRIPTION

This class (along with the other VOTABLE:: classes) is a wrapper
around the various classes of the XML::DOM library. The intent is to
provide a simpler interface to VOTABLE documents than that available
using XML::DOM alone. To that end, classes are named after their
VOTABLE element counterparts. Hashes are used as interfaces, and when
a hash stores a reference to a XML::DOM object, it uses the
fully-qualified XML::DOM class name as the hash key. This is a verbose
approach, but it helps me keep the two class hierarchies straight.

To further delineate the two class hierarchies, any variable (other
than the traditional $this) that refers to a XML::DOM object has the
'xmldom_' prefix, while variables that refer to VOTABLE objects use
the 'votable_' prefix. Again, this is probably verbosity overkill, but
I'd rather be safe than sorry right now.

A general design principle for this software is that the user should
not be aware of the use of the underlying representation (XML::DOM in
this case), so that it can be changed in the future.

=head1 WARNINGS

This code assumes (perhaps unwisely) that XML::DOM methods and
subroutines never fail, and that the internal structure of VOTABLE and
XML::DOM objects is always consistent. This decision was made to speed
initial development.

=head1 AUTHOR

Eric Winter, NASA GSFC (elwinter@milkyway.gsfc.nasa.gov)

=head1 VERSION

$Id: Document.pm,v 1.1.1.17 2002/05/14 22:56:59 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: Document.pm,v $
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
use 5.006;

# Turn on strict syntax checking.
use strict;

# Use enhanced diagnostic messages.
use diagnostics;

# Use enhanced warnings.
use warnings;

#******************************************************************************

# Set up the inheritance mexhanism.
our @ISA = qw();

# Module version.
our $VERSION = '0.01';

#******************************************************************************

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

#******************************************************************************

# Class constants.

# Name of XML tag for current class.
my($TAG_NAME) = 'VOTABLE';

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

#******************************************************************************

# Class variables.

# Parser to create Document objects.
my($factory_parser) = new XML::DOM::Parser;

#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# new()

# This is the main constructor for the class.

# The first argument ($class) always contains the class to bless the
# new object into. This will usually be 'VOTABLE::Document', unless
# this constructor is called for an object that inherits from the
# VOTABLE::Document class.

# All remaining arguments are stored in the @options array. The first
# additional argument, if it exists, contains either a string
# containing the XML to use when creating the document, a reference to
# an open filehandle for a file containing the XML to parse, or a
# reference to an existing XML::DOM::Document object to use for the
# VOTABLE element. Any additional items in the @options array are
# assumed to be keyword => value pairs to use to initialize the
# attributes of the VOTABLE element.

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
	if (ref($options[0]) eq 'XML::DOM::Document') {
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
    bless $this, $class;

    # Fill in the object.
    if ($xmldom_document_this) {

	# Save the specified XML::DOM::Document.

    } elsif ($fh) {

	# Create the XML::DOM::Document by parsing the contents of the
	# file.
	$xmldom_document_this = $factory_parser->parse($fh);

    } elsif ($str) {

	# Create the XML::DOM::Document by parsing the string.
	$xmldom_document_this = $factory_parser->parse($str);

    } else {

	# Create an empty XML::DOM::Document from a minimal string.
	$xmldom_document_this = $factory_parser->parse(VOTABLE_XML_TEMPLATE);

    }

    # Save the XML::DOM::Document object, regardless of source.
    $this->{'XML::DOM::Document'} = $xmldom_document_this;

    # Process any specified attributes. This code assumes that the
    # name of each attribute can be directly mapped to a subroutine
    # name.
    while (($attribute_name, $attribute_value) = each(%attributes)) {
  	$set_attribute = "\$this->set_${attribute_name}(\$attribute_value)";
 	eval($set_attribute);
  	if ($EVAL_ERROR) {
  	    carp("Error evaluating $TAG_NAME '$set_attribute': $EVAL_ERROR!");
  	    return(undef);
  	}
    }

    # Construct the VOTABLE object from the XML::DOM object.
    if (not $this->_build_from_XMLDOM) {
  	carp('Unable to build $TAG_NAME from XML::DOM::Document!');
  	return(undef);
    }

    #--------------------------------------------------------------------------

    # Return the new object.
    return($this);

}

#------------------------------------------------------------------------------

# new_from_file()

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
	warn('A filename must be specified!');
	return(undef);
    }

    # Create a filehandle for the file.
    $fh = new FileHandle $filename;
    if (not $fh) {
	warn("Unable to create filehandle for file $filename!");
	return(undef);
    }

    # Parse the input and create the object.
    $this = new VOTABLE::Document $fh;
    if (not $this) {
	warn("Unable to create $class from file $filename!");
	return(undef);
    }

    # Close the filehandle and remove it.
    if (not $fh->close) {
	warn("Unable to close file $filename!");
	return(undef);
    }
    undef($fh);

    #--------------------------------------------------------------------------

    # Return the object.
    return($this);

}

#------------------------------------------------------------------------------

# print()

# Print the XML tree for this document.

sub print()
{
    my($this, $fh) = @_;
    $this->{'XML::DOM::Document'}->print($fh);
    return(1);
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

sub get_ID()
{
    my($this) = @_;
    $this->{'XML::DOM::Document'}->getDocumentElement->getAttribute('ID');
}

sub set_ID()
{
    my($this, $id) = @_;
    $this->{'XML::DOM::Document'}->getDocumentElement->setAttribute('ID', $id);
    return($this->get_ID);
}

sub get_version()
{
    my($this) = @_;
    $this->{'XML::DOM::Document'}->getDocumentElement->getAttribute('version');
}

sub set_version()
{
    my($this, $version) = @_;
    $this->{'XML::DOM::Document'}->getDocumentElement->setAttribute('version',
								    $version);
    return($this->get_version);
}

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

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'DESCRIPTION'} = $votable_description;

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Document'}->getDocumentElement;

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_description =
	$votable_description->{'XML::DOM::Element'};
    if (not $xmldom_element_description) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this PARAM element already has a DESCRIPTION element, remove
    # the DESCRIPTION element.
    @xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DESCRIPTION', 0);
    if (@xmldom_elements) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the new object to the owner document for this
    # object. THIS IS IMPORTANT!
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

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'DEFINITIONS'} = $votable_definitions;

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Document'}->getDocumentElement;

    # Get the XML::DOM::Element for the new object.
    $xmldom_element_definitions =
	$votable_definitions->{'XML::DOM::Element'};
    if (not $xmldom_element_definitions) {
	carp('Unable to find XML::DOM::Element!');
	return(undef);
    }

    # If this PARAM element already has a DEFINITIONS element, remove the
    # DEFINITIONS element.
    if (@xmldom_elements =
	$xmldom_element_this->getElementsByTagName('DEFINITIONS', 0)) {
	$xmldom_element_this->removeChild($xmldom_elements[0]);
    }

    # Attach the new object to the owner document for this
    # object. THIS IS IMPORTANT!
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

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'INFO'} = [@votable_info];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Document'}->getDocumentElement;

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
	$xmldom_element_info = $votable_info->{'XML::DOM::Element'};
	$xmldom_element_info->setOwnerDocument($xmldom_element_this
					       ->getOwnerDocument);
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
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info =
			$votable_info->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_info,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info =
			$votable_info->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_info);
		}
	    }

	} elsif (@xmldom_elements = $xmldom_element_this->
	    getElementsByTagName('DESCRIPTION', 0)) {

	    # If this DESCRIPTION element is not the last child,
	    # insert the INFO elements right after it. Otherwise,
	    # append the INFO elements.
	    if ($xmldom_elements[0] ne $xmldom_element_this->getLastChild) {
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info =
			$votable_info->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_info,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_info (@votable_info) {
		    $xmldom_element_info =
			$votable_info->{'XML::DOM::Element'};
		    $xmldom_element_this->appendChild($xmldom_element_info);
		}
	    }

	} else {

	    # No DESCRIPTION or LINK element found, so insert the
	    # INFO elements as the first children.
	    foreach $votable_info (@votable_info) {
		$xmldom_element_info =
		    $votable_info->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_info,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the INFOS become the first
	# children.
	foreach $votable_info (@votable_info) {
	    $xmldom_element_info = $votable_info->{'XML::DOM::Element'}; 
	    $xmldom_element_this->appendChild($xmldom_element_info);
	}

    }

    # Return the new object.
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

    # Link the objects at the VOTABLE level. This is easy, since
    # parent/child links in the VOTABLE class hierarchy are one-way,
    # from parent to child.
    $this->{'RESOURCE'} = [@votable_resource];

    #--------------------------------------------------------------------------

    # Now link the objects at the XML::DOM level. This is more
    # complicated, since the links are bidirectional.

    # Get the XML::DOM::Element for this object.
    $xmldom_element_this = $this->{'XML::DOM::Document'}->getDocumentElement;

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
	$xmldom_element_resource = $votable_resource->{'XML::DOM::Element'};
	$xmldom_element_resource->setOwnerDocument($xmldom_element_this
					       ->getOwnerDocument);
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
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[-1]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
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
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
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
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			insertBefore($xmldom_element_resource,
				     $xmldom_elements[0]->getNextSibling);
		}
	    } else {
		foreach $votable_resource (@votable_resource) {
		    $xmldom_element_resource =
			$votable_resource->{'XML::DOM::Element'};
		    $xmldom_element_this->
			appendChild($xmldom_element_resource);
		}
	    }

	} else {

	    # No DESCRIPTION or LINK element found, so insert the
	    # RESOURCE elements as the first children.
	    foreach $votable_resource (@votable_resource) {
		$xmldom_element_resource =
		    $votable_resource->{'XML::DOM::Element'};
		$xmldom_element_this->
		    insertBefore($xmldom_element_resource,
				 $xmldom_element_this->getFirstChild);
	    }

	}

    } else {

	# No existing children, so the RESOURCES become the first
	# children.
	foreach $votable_resource (@votable_resource) {
	    $xmldom_element_resource =
		$votable_resource->{'XML::DOM::Element'}; 
	    $xmldom_element_this->appendChild($xmldom_element_resource);
	}

    }

    # Return the new object.
    return($this->get_resource);

}

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

# This method does the hard work of mapping a XML::DOM::Document
# object to a VOTABLE::Document object.

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
    $xmldom_document_this = $this->{'XML::DOM::Document'};
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

#******************************************************************************
1;
__END__
