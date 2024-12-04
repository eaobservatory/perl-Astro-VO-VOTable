# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 28 };
use VOTABLE::PARAM;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use XML::DOM;
use VOTABLE::DESCRIPTION;
use VOTABLE::LINK;
use VOTABLE::PARAM;

# Subroutine prototypes.
sub test_new();
sub test_get_description();
sub test_set_description();
sub test_get_values();
sub test_set_values();
sub test_get_link();
sub test_set_link();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
my($test_param) = new VOTABLE::PARAM;
ok($test_param->set_ID('100'), 100);
ok($test_param->get_ID, 100);
ok($test_param->set_arraysize('100x100'), '100x100');
ok($test_param->get_arraysize, '100x100');
ok($test_param->set_datatype('double'), 'double');
ok($test_param->get_datatype, 'double');
ok($test_param->set_name('RA'), 'RA');
ok($test_param->get_name, 'RA');
ok($test_param->set_precision('F4'), 'F4');
ok($test_param->get_precision, 'F4');
ok($test_param->set_ref('test reference'), 'test reference');
ok($test_param->get_ref, 'test reference');
ok($test_param->set_ucd('POS_EQ_RA'), 'POS_EQ_RA');
ok($test_param->get_ucd, 'POS_EQ_RA');
ok($test_param->set_unit('degree'), 'degree');
ok($test_param->get_unit, 'degree');
ok($test_param->set_value(45), 45);
ok($test_param->get_value, 45);
ok($test_param->set_width(9), 9);
ok($test_param->get_width, 9);

# Test the element accessors work.
ok(test_get_description, 1);
ok(test_set_description, 1);
ok(test_get_values, 1);
ok(test_set_values, 1);
ok(test_get_link, 1);
ok(test_set_link, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_param);
    $votable_param = new VOTABLE::PARAM
	or return(0);
    $votable_param = new VOTABLE::PARAM
	$factory->createElement('PARAM') or return(0);
    return(1);
}

sub test_get_description()
{
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    my($test_description) = 'This is a test.';
    my($votable_description) = new VOTABLE::DESCRIPTION $test_description
 	or return(0);
    $votable_param->set_description($votable_description) eq
	$votable_description
 	or return(0);
    return(1);
}

sub test_set_description()
{
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    my($test_description) = 'This is a test.';
    my($votable_description) = new VOTABLE::DESCRIPTION $test_description
 	or return(0);
    $votable_param->set_description($votable_description) eq
	$votable_description
 	or return(0);
    return(1);
}

sub test_get_values()
{
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    my($votable_values) = new VOTABLE::VALUES
 	or return(0);
    $votable_param->set_values(($votable_values))
 	or return(0);
    return(1);
}

sub test_set_values()
{
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    my($votable_values) = new VOTABLE::VALUES
 	or return(0);
    $votable_param->set_values(($votable_values))
 	or return(0);
    return(1);
}

sub test_get_link()
{
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    my($votable_link) = new VOTABLE::LINK
 	or return(0);
    $votable_param->set_link(($votable_link))
 	or return(0);
    return(1);
}

sub test_set_link()
{
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    my($votable_link) = new VOTABLE::LINK
 	or return(0);
    $votable_param->set_link(($votable_link))
 	or return(0);
    return(1);
}
