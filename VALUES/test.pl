# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 16 };
use VOTABLE::VALUES;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use XML::DOM;
#use VOTABLE::Document;
use VOTABLE::MAX;
use VOTABLE::MIN;

# Subroutine prototypes.
sub test_new();
sub test_get_ID();
sub test_set_ID();
sub test_get_invalid();
sub test_set_invalid();
sub test_get_null();
sub test_set_null();
sub test_get_type();
sub test_set_type();
sub test_get_max();
sub test_set_max();
sub test_get_min();
sub test_set_min();
sub test_get_option();
sub test_set_option();

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document or die;

#########################

# Test the constructor.
ok(test_new, 1);

# Test attribute accessors.
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_invalid, 1);
ok(test_set_invalid, 1);
ok(test_get_null, 1);
ok(test_set_null, 1);
ok(test_get_type, 1);
ok(test_set_type, 1);

# Test element accessors.
ok(test_get_max, 1);
ok(test_set_max, 1);
ok(test_get_min, 1);
ok(test_set_min, 1);
ok(test_get_option, 1);
ok(test_set_option, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    $votable_values = new VOTABLE::VALUES $factory->createElement('VALUES')
	or return(0);
    return(1);
}

sub test_get_ID()
{
    my($test_id) = '100';
    my($votable_values) = new VOTABLE::VALUES '', ID => $test_id
	or return(0);
    $votable_values->get_ID eq $test_id
	or return(0);
    return(1);
}

sub test_set_ID()
{
    my($test_id) = '100';
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    $votable_values->set_ID ($test_id) eq $test_id
	or return(0);
    return(1);
}

sub test_get_invalid()
{
    my($test_invalid) = 'no';
    my($votable_values) = new VOTABLE::VALUES '', invalid => $test_invalid
	or return(0);
    $votable_values->get_invalid eq $test_invalid
	or return(0);
    return(1);
}

sub test_set_invalid()
{
    my($test_invalid) = 'no';
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    $votable_values->set_invalid ($test_invalid) eq $test_invalid
	or return(0);
    return(1);
}

sub test_get_null()
{
    my($test_null) = '-99';
    my($votable_values) = new VOTABLE::VALUES '', null => $test_null
	or return(0);
    $votable_values->get_null eq $test_null
	or return(0);
    return(1);
}

sub test_set_null()
{
    my($test_null) = '-99';
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    $votable_values->set_null ($test_null) eq $test_null
	or return(0);
    return(1);
}

sub test_get_type()
{
    my($test_type) = 'actual';
    my($votable_values) = new VOTABLE::VALUES '', type => $test_type
	or return(0);
    $votable_values->get_type eq $test_type
	or return(0);
    return(1);
}

sub test_set_type()
{
    my($test_type) = 'actual';
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    $votable_values->set_type ($test_type) eq $test_type
	or return(0);
    return(1);
}

sub test_get_max()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    my($test_max) = '100';
    my($votable_max) = new VOTABLE::MAX $test_max
	or return(0);
    $votable_values->set_max($votable_max) eq $votable_max
	or return(0);
    $votable_values->get_max eq $votable_max
	or return(0);
    return(1);
}

sub test_set_max()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    my($test_max) = '100';
    my($votable_max) = new VOTABLE::MAX $test_max
	or return(0);
    $votable_values->set_max($votable_max) eq $votable_max
	or return(0);
    $votable_values->get_max eq $votable_max
	or return(0);
    return(1);
}

sub test_get_min()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    my($test_min) = '100';
    my($votable_min) = new VOTABLE::MIN $test_min
	or return(0);
    $votable_values->set_min($votable_min) eq $votable_min
	or return(0);
    $votable_values->get_min eq $votable_min
	or return(0);
    return(1);
}

sub test_set_min()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    my($test_min) = '100';
    my($votable_min) = new VOTABLE::MIN $test_min
	or return(0);
    $votable_values->set_min($votable_min) eq $votable_min
	or return(0);
    $votable_values->get_min eq $votable_min
	or return(0);
    return(1);
}

sub test_get_option()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    my($votable_option) = new VOTABLE::OPTION
	or return(0);
    $votable_values->set_option(($votable_option))
	or return(0);
    ($votable_values->get_option)[0] eq $votable_option
	or return(0);
    return(1);
}

sub test_set_option()
{
    my($votable_values) = new VOTABLE::VALUES
	or return(0);
    my($votable_option) = new VOTABLE::OPTION
	or return(0);
    $votable_values->set_option(($votable_option))
	or return(0);
    ($votable_values->get_option)[0] eq $votable_option
	or return(0);
    return(1);
}
