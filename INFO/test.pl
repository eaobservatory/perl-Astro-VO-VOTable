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

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

#########################

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

# Supporting subroutines for testing.

sub test_new()
{
    my($test_text) = 'This is a test.';
    my($test_ID) = '12345';
    my($votable_info) = new VOTABLE::INFO
	or return(0);
    $votable_info = new VOTABLE::INFO $test_text
	or return(0);
    $votable_info = new VOTABLE::INFO $test_text, ID => $test_ID
	or return(0);
    $votable_info = new VOTABLE::INFO $factory->createElement('INFO')
	or return(0);
    return(1);
}

sub test_get_ID()
{
    my($test_ID) = '12345';;
    my($votable_info) = new VOTABLE::INFO '', ID => $test_ID
	or return(0);
    $votable_info->get_ID eq $test_ID
        or return(0);
    return(1);
}

sub test_set_ID()
{
    my($test_ID) = '12345';
    my($votable_info) = new VOTABLE::INFO
	or return(0);
    $votable_info->set_ID($test_ID) eq $test_ID
	or return(0);
    return(1);
}

sub test_get_name()
{
    my($test_name) = 'My name is test.';
    my($votable_info) = new VOTABLE::INFO '', name => $test_name
	or return(0);
    $votable_info->get_name eq $test_name
	or return(0);
    return(1);
}

sub test_set_name()
{
    my($test_name) = 'My name is test.';
    my($votable_info) = new VOTABLE::INFO
	or return(0);
    $votable_info->set_name($test_name) eq $test_name
	or return(0);
    return(1);
}

sub test_get_value()
{
    my($test_value) = '1000';
    my($votable_info) = new VOTABLE::INFO '', value => $test_value
	or return(0);
    $votable_info->get_value eq $test_value
	or return(0);
    return(1);
}

sub test_set_value()
{
    my($test_value) = '1000';
    my($votable_info) = new VOTABLE::INFO
	or return(0);
    $votable_info->set_value($test_value) eq $test_value
	or return(0);
    return(1);
}

sub test_get()
{
    my($test_text) = 'This is a test.';
    my($this) = new VOTABLE::INFO $test_text
	or return(0);
    $this->get eq $test_text
        or return(0);
    return(1);
}

sub test_set()
{
    my($test_text) = 'This is a test.';
    my($this) = new VOTABLE::INFO
	or return(0);
    $this->set($test_text) eq $test_text
	or return(0);
    return(1);
}
