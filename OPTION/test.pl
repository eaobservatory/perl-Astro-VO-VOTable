# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use VOTABLE::OPTION;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use XML::DOM;

# Subroutine prototypes.
sub test_new();
sub test_get_name();
sub test_set_name();
sub test_get_value();
sub test_set_value();
sub test_get_option();
sub test_set_option();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test attribute accessors.
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);

# Test element accessors.
ok(test_get_option, 1);
ok(test_set_option, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_option);
    $votable_option = new VOTABLE::OPTION
	or return(0);
    $votable_option = new VOTABLE::OPTION $factory->createElement('OPTION')
	or return(0);
    return(1);
}

sub test_get_name()
{
    my($votable_option);
    my($test_name) = 'I am an option';
    $votable_option = new VOTABLE::OPTION undef, name => $test_name
	or return(0);
    $votable_option->get_name eq $test_name
	or return(0);
    return(1);
}

sub test_set_name()
{
    my($votable_option);
    my($test_name) = 'I am an option';
    $votable_option = new VOTABLE::OPTION
	or return(0);
    $votable_option->set_name($test_name) eq $test_name
	or return(0);
    return(1);
}

sub test_get_value()
{
    my($votable_option);
    my($test_value) = '999';
    $votable_option = new VOTABLE::OPTION undef, value => $test_value
	or return(0);
    $votable_option->get_value eq $test_value
	or return(0);
    return(1);
}

sub test_set_value()
{
    my($votable_option);
    my($test_value) = '999';
    $votable_option = new VOTABLE::OPTION
	or return(0);
    $votable_option->set_value($test_value) eq $test_value
	or return(0);
    return(1);
}

sub test_get_option()
{
    my($votable_option) = new VOTABLE::OPTION
	or return(0);
    my($test_option) = new VOTABLE::OPTION
	or return(0);
    $votable_option->set_option(($test_option))
 	or return(0);
    ($votable_option->get_option)[0] eq $test_option
	or return(0);
    return(1);
}

sub test_set_option()
{
    my($votable_option) = new VOTABLE::OPTION
	or return(0);
    my($test_option) = new VOTABLE::OPTION
	or return(0);
    $votable_option->set_option(($test_option))
 	or return(0);
    ($votable_option->get_option)[0] eq $test_option
	or return(0);
    return(1);
}
