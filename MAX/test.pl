# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use VOTABLE::MAX;
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
sub test_get_inclusive();
sub test_set_inclusive();
sub test_get_value();
sub test_set_value();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_inclusive, 1);
ok(test_set_inclusive, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);

# Test the element accessors.

# Test the PCDATA accessors.
ok(test_get(), 1);
ok(test_set(), 1);

#########################

# Supporting subroutines for testing

sub test_new()
{
    my($votable_max);
    my($test_max) = '100';
    my($test_inclusive) = 'no';

    $votable_max = new VOTABLE::MAX
	or return(0);
    $votable_max = new VOTABLE::MAX $test_max
	or return(0);
    $votable_max = new VOTABLE::MAX $test_max, inclusive => $test_inclusive
	or return(0);
    $votable_max = new VOTABLE::MAX $factory->createElement('MAX')
	or return(0);

    return(1);
}

sub test_get_inclusive()
{
    my($votable_max);
    my($test_inclusive) = 'no';

    $votable_max = new VOTABLE::MAX
	or return(0);
    not defined($votable_max->get_inclusive)
	or return(0);

    $votable_max = new VOTABLE::MAX '', inclusive => $test_inclusive
	or return(0);
    $votable_max->get_inclusive eq $test_inclusive
	or return(0);

    return(1);
}

sub test_set_inclusive()
{
    my($votable_max);
    my($test_inclusive) = 'no';

    $votable_max = new VOTABLE::MAX
	or return(0);
    $votable_max->set_inclusive($test_inclusive) eq $test_inclusive
	or return(0);
    not defined($votable_max->set_inclusive(undef))
	or return(0);

    return(1);
}

sub test_get_value()
{
    my($votable_max);
    my($test_value) = '100';

    $votable_max = new VOTABLE::MAX
	or return(0);
    not defined($votable_max->get_value)
	or return(0);

    $votable_max = new VOTABLE::MAX '', value => $test_value
	or return(0);
    $votable_max->get_value eq $test_value
	or return(0);

    return(1);
}

sub test_set_value()
{
    my($votable_max);
    my($test_value) = '100';

    $votable_max = new VOTABLE::MAX
	or return(0);
    $votable_max->set_value($test_value) eq $test_value
	or return(0);
    not defined($votable_max->set_value(undef))
	or return(0);

    return(1);
}

sub test_get()
{
    my($votable_max);
    my($test_text) = 'This is a test.';
    my($test_text2) = 'This is another test.';
    my($textnode);

    $votable_max = new VOTABLE::MAX
	or return(0);
    not defined($votable_max->get)
	or return(0);

    $votable_max = new VOTABLE::MAX $test_text
	or return(0);
    $votable_max->get eq $test_text
	or return(0);

    $textnode = $factory->createTextNode($test_text2)
	or return(0);
    $textnode->setOwnerDocument($votable_max->
				_get_XMLDOM->getOwnerDocument);
    $votable_max->_get_XMLDOM->appendChild($textnode)
	or return(0);
    $votable_max->get eq ($test_text . $test_text2)
	or return(0);

    return(1);
}

sub test_set()
{
    my($votable_max);
    my($test_text) = 'This is a test.';

    $votable_max = new VOTABLE::MAX
 	or return(0);
    $votable_max->set($test_text) eq $test_text
 	or return(0);
    not defined($votable_max->set(undef))
 	or return(0);

    return(1);
}
