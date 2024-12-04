# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 10 };
use VOTABLE::INFO;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use XML::DOM;

# Subroutine prototypes.
sub test_new();
sub test_get_ID();
sub test_set_ID();
sub test_get_name();
sub test_set_name();
sub test_get_value();
sub test_set_value();
sub test_get();
sub test_set();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);

# Test the element accessors.

# Test the PCDATA accessors.
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing

sub test_new()
{
    my($votable_info);
    my($test_str) = 'This is a test.';
    my($test_ID) = '1';

    $votable_info = new VOTABLE::INFO
	or return(0);
    $votable_info = new VOTABLE::INFO $test_str
	or return(0);
    $votable_info = new VOTABLE::INFO $test_str , ID => $test_ID
	or return(0);
    $votable_info = new VOTABLE::INFO $factory->createElement('INFO')
	or return(0);
    $votable_info = new VOTABLE::INFO $factory->createElement('INFO'),
        ID => $test_ID
	or return(0);
    $votable_info = new VOTABLE::INFO ''
	or return(0);

    return(1);
}

sub test_get_ID()
{
    my($votable_info);
    my($test_ID) = '12345';

    $votable_info = new VOTABLE::INFO
	or return(0);
    not defined($votable_info->get_ID)
	or return(0);

    $votable_info = new VOTABLE::INFO '', ID => $test_ID
	or return(0);
    $votable_info->get_ID eq $test_ID
	or return(0);

    return(1);
}

sub test_set_ID()
{
    my($votable_info);
    my($test_ID) = '12345';

    $votable_info = new VOTABLE::INFO
	or return(0);
    $votable_info->set_ID($test_ID) eq $test_ID
	or return(0);
    not defined($votable_info->set_ID(undef))
	or return(0);

    return(1);
}

sub test_get_name()
{
    my($votable_info);
    my($test_name) = 'testname';

    $votable_info = new VOTABLE::INFO
	or return(0);
    not defined($votable_info->get_name)
	or return(0);

    $votable_info = new VOTABLE::INFO '', name => $test_name
	or return(0);
    $votable_info->get_name eq $test_name
	or return(0);

    return(1);
}

sub test_set_name()
{
    my($votable_info);
    my($test_name) = 'testname';

    $votable_info = new VOTABLE::INFO
	or return(0);
    $votable_info->set_name($test_name) eq $test_name
	or return(0);
    not defined($votable_info->set_name(undef))
	or return(0);

    return(1);
}

sub test_get_value()
{
    my($votable_info);
    my($test_value) = '12345.6';

    $votable_info = new VOTABLE::INFO
	or return(0);
    not defined($votable_info->get_value)
	or return(0);

    $votable_info = new VOTABLE::INFO '', value => $test_value
	or return(0);
    $votable_info->get_value eq $test_value
	or return(0);

    return(1);
}

sub test_set_value()
{
    my($votable_info);
    my($test_value) = '12345.6';

    $votable_info = new VOTABLE::INFO
	or return(0);
    $votable_info->set_value($test_value) eq $test_value
	or return(0);
    not defined($votable_info->set_value(undef))
	or return(0);

    return(1);
}

sub test_get()
{
    my($votable_info);
    my($test_text) = 'This is a test.';
    my($test_text2) = 'This is another test.';
    my($textnode);

    $votable_info = new VOTABLE::INFO
	or return(0);
    not defined($votable_info->get)
	or return(0);

    $votable_info = new VOTABLE::INFO $test_text
	or return(0);
    $votable_info->get eq $test_text
	or return(0);

    $textnode = $factory->createTextNode($test_text2)
	or return(0);
    $textnode->setOwnerDocument($votable_info->
				_get_XMLDOM->getOwnerDocument);
    $votable_info->_get_XMLDOM->appendChild($textnode)
	or return(0);
    $votable_info->get eq ($test_text . $test_text2)
	or return(0);

    return(1);
}

sub test_set()
{
    my($votable_info);
    my($test_text) = 'This is a test.';

    $votable_info = new VOTABLE::INFO
 	or return(0);
    $votable_info->set($test_text) eq $test_text
 	or return(0);
    not defined($votable_info->set(undef))
 	or return(0);

    return(1);
}
