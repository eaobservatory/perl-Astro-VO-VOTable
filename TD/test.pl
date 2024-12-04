# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
use VOTABLE::TD;
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
sub test_get_ref();
sub test_set_ref();

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document or die;

#########################

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_ref, 1);
ok(test_set_ref, 1);

# Test the PCDATA accessors.
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_td);
    $votable_td = new VOTABLE::TD
	or return(0);
    $votable_td = new VOTABLE::TD 'Test string'
	or return(0);
    $votable_td = new VOTABLE::TD 'Test string', ref => 'a ref'
	or return(0);
    $votable_td = new VOTABLE::TD $factory->createElement('TD')
	or return(0);
    return(1);
}

sub test_get_ref()
{
    my($test_ref) = "a ref";
    my($votable_td) = new VOTABLE::TD '', ref => $test_ref
	or return(0);
    $votable_td->get_ref eq $test_ref
	or return(0);
    return(1);
}

sub test_set_ref()
{
    my($test_ref) = "a ref";
    my($votable_td) = new VOTABLE::TD
	or return(0);
    $votable_td->set_ref($test_ref) eq $test_ref
	or return(0);
    return(1);
}

sub test_get()
{
    my($test_text) = 'This is a test.';
    my($votable_td) = new VOTABLE::TD $test_text
	or return(0);
    $votable_td->get() eq $test_text
	or return(0);
    return(1);
}

sub test_set()
{
    my($test_text) = 'This is a test.';
    my($votable_td) = new VOTABLE::TD
	or return(0);
    $votable_td->set($test_text) eq $test_text
	or return(0);
    return(1);
}
