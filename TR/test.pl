# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
use VOTABLE::TR;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use XML::DOM;
use VOTABLE::TD;

# Subroutine prototypes.
sub test_new();
sub test_get_td();
sub test_set_td();
sub test_as_array();
sub test_from_array();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test attribute accessors.

# Test element accessors.
ok(test_get_td, 1);
ok(test_set_td, 1);

# Test PCDATA accessors.

# Test the other methods.
ok(test_as_array, 1);
ok(test_from_array, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_tr);
    $votable_tr = new VOTABLE::TR
	or return(0);
    $votable_tr = new VOTABLE::TR $factory->createElement('TR')
	or return(0);
    return(1);
}

sub test_get_td()
{
    my($votable_tr) = new VOTABLE::TR
	or return(0);
    my($test_td) = 'One';
    my($votable_td) = new VOTABLE::TD $test_td
	or return(0);
    $votable_tr->set_td(($votable_td))
 	or return(0);
    ($votable_tr->get_td)[0] eq $votable_td
	or return(0);
    return(1);
}

sub test_set_td()
{
    my($votable_tr) = new VOTABLE::TR
	or return(0);
    my($test_td) = 'One';
    my($votable_td) = new VOTABLE::TD $test_td
	or return(0);
    $votable_tr->set_td(($votable_td))
 	or return(0);
    ($votable_tr->get_td)[0] eq $votable_td
	or return(0);
    return(1);
}

sub test_as_array()
{
    my($votable_tr) = new VOTABLE::TR or return(0);
    my($test_td) = 'One';
    my($votable_td) = new VOTABLE::TD $test_td or return(0);
    $votable_tr->set_td(($votable_td)) or return(0);
    my(@values) = $votable_tr->as_array or return(0);
    $values[0] eq 'One' or return(0);
    return(1);
}

sub test_from_array()
{
    my($votable_tr) = new VOTABLE::TR or return(0);
    my($test_td) = 'One';
    $votable_tr->from_array(($test_td)) or return(0);
    my(@values) = $votable_tr->as_array or return(0);
    $values[0] eq 'One' or return(0);
    return(1);
}
