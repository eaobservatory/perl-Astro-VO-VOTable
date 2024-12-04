# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 4 };
use VOTABLE::DESCRIPTION;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use XML::DOM;

# Subroutine prototypes.
sub test_new();
sub test_get();
sub test_set();

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

#########################

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.

# Test the element accessors.

# Test the PCDATA accessors.
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing

sub test_new()
{
    my($votable_description);
    my($test_str) = 'This is a test.';

    $votable_description = new VOTABLE::DESCRIPTION
	or return(0);
    $votable_description = new VOTABLE::DESCRIPTION $test_str
	or return(0);
    $votable_description = new VOTABLE::DESCRIPTION
	$factory->createElement('DESCRIPTION')
	or return(0);

    return(1);
}

sub test_get()
{
    my($votable_description);
    my($test_text) = 'This is a test.';
    my($test_text2) = 'This is another test.';
    my($textnode);

    $votable_description = new VOTABLE::DESCRIPTION
	or return(0);
    not defined($votable_description->get)
	or return(0);

    $votable_description = new VOTABLE::DESCRIPTION $test_text
	or return(0);
    $votable_description->get eq $test_text
	or return(0);

    $textnode = $factory->createTextNode($test_text2)
	or return(0);
    $textnode->setOwnerDocument($votable_description->
				_get_XMLDOM->getOwnerDocument);
    $votable_description->_get_XMLDOM->appendChild($textnode)
	or return(0);
    $votable_description->get eq ($test_text . $test_text2)
	or return(0);

    return(1);
}

sub test_set()
{
    my($votable_description);
    my($test_text) = 'This is a test.';

    $votable_description = new VOTABLE::DESCRIPTION
 	or return(0);
    $votable_description->set($test_text) eq $test_text
 	or return(0);
    not defined($votable_description->set(undef))
 	or return(0);

    return(1);
}
