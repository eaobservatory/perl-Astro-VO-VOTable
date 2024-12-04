# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use VOTABLE::MIN;
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
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($test_text) = '100';
    my($votable_min) = new VOTABLE::MIN
	or return(0);
    $votable_min = new VOTABLE::MIN $test_text
	or return(0);
    $votable_min = new VOTABLE::MIN $test_text, inclusive => 'no'
	or return(0);
    $votable_min = new VOTABLE::MIN $factory->createElement('MIN')
	or return(0);
    return(1);
}

sub test_get_inclusive()
{
    my($test_inclusive) = 'no';
    my($votable_min) = new VOTABLE::MIN '', inclusive => $test_inclusive
	or return(0);
    $votable_min->get_inclusive eq $test_inclusive
	or return(0);
    return(1);
}

sub test_set_inclusive()
{
    my($test_inclusive) = 'no';
    my($votable_min) = new VOTABLE::MIN
	or return(0);
    $votable_min->set_inclusive($test_inclusive) eq $test_inclusive
	or return(0);
    return(1);
}

sub test_get_value()
{
    my($test_value) = '100';
    my($votable_min) = new VOTABLE::MIN '', value => $test_value
	or return(0);
    $votable_min->get_value eq $test_value
	or return(0);
    return(1);
}

sub test_set_value()
{
    my($test_value) = '100';
    my($votable_min) = new VOTABLE::MIN
	or return(0);
    $votable_min->set_value($test_value) eq $test_value
	or return(0);
    return(1);
}

sub test_get()
{
    my($test_text) = 'This is a test.';
    my($this) = new VOTABLE::MIN $test_text
	or return(0);
    $this->get eq $test_text
	or return(0);
    return(1);
}

sub test_set()
{
    my($test_text) = 'This is a test.';
    my($this) = new VOTABLE::MIN ''
	or return(0);
    $this->set($test_text) eq $test_text
	or return(0);
    return(1);
}
