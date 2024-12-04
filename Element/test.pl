# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 3 };
use VOTABLE::Element;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#******************************************************************************

# External modules

# Standard modules
use XML::DOM;

# Third-party modules

# Project modules

#******************************************************************************

# Constants

#******************************************************************************

# Global variables

# Reference to XML::DOM::Document object to use as an element factory.
my($xmldom_document_factory);

#******************************************************************************

# Subroutine prototypes
sub test_new();

#******************************************************************************

# Create the factory document.
ok(defined($xmldom_document_factory = new XML::DOM::Document), 1);

# Test the constructor.
ok(test_new, 1);

#******************************************************************************

sub test_new()
{
    my($votable_element);
    my($str) = '<TEST/>';
    my($test_element_tag_name) = 'TEST';
    my($xmldom_element);
    $votable_element = new VOTABLE::Element or return(0);
    $votable_element = new VOTABLE::Element $str or return(0);
    $xmldom_element =
	$xmldom_document_factory->createElement($test_element_tag_name)
	or return(0);
    $votable_element = new VOTABLE::Element $xmldom_element or return(0);
    return(1);
}
