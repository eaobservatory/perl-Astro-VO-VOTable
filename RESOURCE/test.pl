# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 22 };
use VOTABLE::RESOURCE;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use XML::DOM;
use VOTABLE::COOSYS;
use VOTABLE::DESCRIPTION;
use VOTABLE::INFO;
use VOTABLE::LINK;
use VOTABLE::PARAM;
use VOTABLE::TABLE;

# Subroutine prototypes.
sub test_new();
sub test_get_description();
sub test_set_description();
sub test_get_info();
sub test_set_info();
sub test_get_coosys();
sub test_set_coosys();
sub test_get_param();
sub test_set_param();
sub test_get_link();
sub test_set_link();
sub test_get_table();
sub test_set_table();
sub test_get_resource();
sub test_set_resource();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
my($test_resource) = new VOTABLE::RESOURCE;
ok($test_resource->set_ID('100'), 100);
ok($test_resource->get_ID, 100);
ok($test_resource->set_name('fred'), 'fred');
ok($test_resource->get_name, 'fred');
ok($test_resource->set_type('results'), 'results');
ok($test_resource->get_type, 'results');

# Test the element accessors.
ok(test_get_description, 1);
ok(test_set_description, 1);
ok(test_get_info, 1);
ok(test_set_info, 1);
ok(test_get_coosys, 1);
ok(test_set_coosys, 1);
ok(test_get_param, 1);
ok(test_set_param, 1);
ok(test_get_link, 1);
ok(test_set_link, 1);
ok(test_get_table, 1);
ok(test_set_table, 1);
ok(test_get_resource, 1);
ok(test_set_resource, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_resource);
    $votable_resource = new VOTABLE::RESOURCE
	or return(0);
    $votable_resource = new VOTABLE::RESOURCE
	$factory->createElement('RESOURCE')
	or return(0);
    return(1);
}

sub test_get_description()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_description) = 'This is a test.';
    my($votable_description) = new VOTABLE::DESCRIPTION $test_description
 	or return(0);
    $votable_resource->set_description($votable_description) eq
	$votable_description
 	or return(0);
    return(1);
}

sub test_set_description()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_description) = 'This is a test.';
    my($votable_description) = new VOTABLE::DESCRIPTION $test_description
 	or return(0);
    $votable_resource->set_description($votable_description) eq
	$votable_description
 	or return(0);
    return(1);
}

sub test_get_info()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_info) = 'This is a test.';
    my($votable_info) = new VOTABLE::INFO $test_info
 	or return(0);
    $votable_resource->set_info(($votable_info))
 	or return(0);
    ($votable_resource->get_info)[0] eq $votable_info
	or return(0);
    return(1);
}

sub test_set_info()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_info) = 'This is a test.';
    my($votable_info) = new VOTABLE::INFO $test_info
 	or return(0);
    $votable_resource->set_info(($votable_info))
 	or return(0);
    ($votable_resource->get_info)[0] eq $votable_info
	or return(0);
    return(1);
}
 
sub test_get_coosys()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_coosys) = 'This is a test.';
    my($votable_coosys) = new VOTABLE::COOSYS $test_coosys
 	or return(0);
    $votable_resource->set_coosys(($votable_coosys))
 	or return(0);
    ($votable_resource->get_coosys)[0] eq $votable_coosys
	or return(0);
    return(1);
}

sub test_set_coosys()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_coosys) = 'This is a test.';
    my($votable_coosys) = new VOTABLE::COOSYS $test_coosys
 	or return(0);
    $votable_resource->set_coosys(($votable_coosys))
 	or return(0);
    ($votable_resource->get_coosys)[0] eq $votable_coosys
	or return(0);
    return(1);
}

sub test_get_param()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    $votable_resource->set_param(($votable_param))
 	or return(0);
    ($votable_resource->get_param)[0] eq $votable_param
	or return(0);
    return(1);
}

sub test_set_param()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($votable_param) = new VOTABLE::PARAM
 	or return(0);
    $votable_resource->set_param(($votable_param))
 	or return(0);
    ($votable_resource->get_param)[0] eq $votable_param
	or return(0);
    return(1);
}

sub test_get_link()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_link) = 'This is a test.';
    my($votable_link) = new VOTABLE::LINK $test_link
 	or return(0);
    $votable_resource->set_link(($votable_link))
 	or return(0);
    ($votable_resource->get_link)[0] eq $votable_link
	or return(0);
    return(1);
}

sub test_set_link()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($test_link) = 'This is a test.';
    my($votable_link) = new VOTABLE::LINK $test_link
 	or return(0);
    $votable_resource->set_link(($votable_link))
 	or return(0);
    ($votable_resource->get_link)[0] eq $votable_link
	or return(0);
    return(1);
}

sub test_get_table()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    $votable_resource->set_table(($votable_table))
 	or return(0);
    ($votable_resource->get_table)[0] eq $votable_table
	or return(0);
    return(1);
}

sub test_set_table()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    $votable_resource->set_table(($votable_table))
 	or return(0);
    ($votable_resource->get_table)[0] eq $votable_table
	or return(0);
    return(1);
}

sub test_get_resource()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($votable_resource_test) = new VOTABLE::RESOURCE
 	or return(0);
    $votable_resource->set_resource(($votable_resource_test))
 	or return(0);
    ($votable_resource->get_resource)[0] eq $votable_resource_test
	or return(0);
    return(1);
}

sub test_set_resource()
{
    my($votable_resource) = new VOTABLE::RESOURCE
 	or return(0);
    my($votable_resource_test) = new VOTABLE::RESOURCE
 	or return(0);
    $votable_resource->set_resource(($votable_resource_test))
 	or return(0);
    ($votable_resource->get_resource)[0] eq $votable_resource_test
	or return(0);
    return(1);
}
