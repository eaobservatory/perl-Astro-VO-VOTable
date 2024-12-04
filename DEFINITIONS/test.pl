# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
use VOTABLE::DEFINITIONS;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use XML::DOM;
use VOTABLE::COOSYS;
use VOTABLE::PARAM;

# Subroutine prototypes.
sub test_new();
sub test_get_coosys();
sub test_set_coosys();
sub test_get_param();
sub test_set_param();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the element accessors.
ok(test_get_coosys, 1);
ok(test_set_coosys, 1);
ok(test_get_param, 1);
ok(test_set_param, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_definitions);
    $votable_definitions = new VOTABLE::DEFINITIONS
	or return(0);
    $votable_definitions = new VOTABLE::DEFINITIONS
	$factory->createElement('DEFINITIONS')
	or return(0);
    return(1);
}

sub test_get_coosys()
{
    my($votable_definitions) = new VOTABLE::DEFINITIONS
	or return(0);
    my($votable_coosys) = new VOTABLE::COOSYS
	or return(0);
    $votable_definitions->set_coosys(($votable_coosys))
	or return(0);
    ($votable_definitions->get_coosys)[0] eq $votable_coosys
	or return(0);
    return(1);
}

sub test_set_coosys()
{
    my($votable_definitions) = new VOTABLE::DEFINITIONS
	or return(0);
    my($votable_coosys) = new VOTABLE::COOSYS
	or return(0);
    $votable_definitions->set_coosys(($votable_coosys))
	or return(0);
    ($votable_definitions->get_coosys)[0] eq $votable_coosys
	or return(0);
    return(1);
}

sub test_get_param()
{
    my($votable_definitions) = new VOTABLE::DEFINITIONS
	or return(0);
    my($votable_param) = new VOTABLE::PARAM
	or return(0);
    $votable_definitions->set_param(($votable_param))
	or return(0);
    ($votable_definitions->get_param)[0] eq $votable_param
	or return(0);
    return(1);
}

sub test_set_param()
{
    my($votable_definitions) = new VOTABLE::DEFINITIONS
	or return(0);
    my($votable_param) = new VOTABLE::PARAM
	or return(0);
    $votable_definitions->set_param(($votable_param))
	or return(0);
    ($votable_definitions->get_param)[0] eq $votable_param
	or return(0);
    return(1);
}
