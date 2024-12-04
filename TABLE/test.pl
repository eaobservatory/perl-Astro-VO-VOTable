# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 10 };
use VOTABLE::TABLE;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use XML::DOM;
use VOTABLE::DATA;
use VOTABLE::DESCRIPTION;
use VOTABLE::FIELD;
use VOTABLE::LINK;

# Subroutine prototypes.
sub test_new();
sub test_get_data();
sub test_set_data();
sub test_get_description();
sub test_set_description();
sub test_get_field();
sub test_set_field();
sub test_get_link();
sub test_set_link();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_data, 1);
ok(test_set_data, 1);
ok(test_get_description, 1);
ok(test_set_description, 1);
ok(test_get_field, 1);
ok(test_set_field, 1);
ok(test_get_link, 1);
ok(test_set_link, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_table);
    $votable_table = new VOTABLE::TABLE
	or return(0);
    $votable_table = new VOTABLE::TABLE
	$factory->createElement('TABLE') or return(0);
    return(1);
}

sub test_get_data()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($votable_data) = new VOTABLE::DATA
 	or return(0);
    $votable_table->set_data($votable_data)
 	or return(0);
    $votable_table->get_data eq $votable_data
 	or die;
    return(1);
}

sub test_set_data()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($votable_data) = new VOTABLE::DATA
 	or return(0);
    $votable_table->set_data($votable_data)
 	or return(0);
    $votable_table->get_data eq $votable_data
 	or return(0);
    return(1);
}

sub test_get_description()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($test_description) = 'This is a test.';
    my($votable_description) = new VOTABLE::DESCRIPTION $test_description
 	or return(0);
    $votable_table->set_description($votable_description) eq
	$votable_description
 	or return(0);
    return(1);
}

sub test_set_description()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($test_description) = 'This is a test.';
    my($votable_description) = new VOTABLE::DESCRIPTION $test_description
 	or return(0);
    $votable_table->set_description($votable_description) eq
	$votable_description
 	or return(0);
    return(1);
}

sub test_get_field()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($votable_field) = new VOTABLE::FIELD
 	or return(0);
    $votable_table->set_field($votable_field)
 	or return(0);
    ($votable_table->get_field)[0] eq $votable_field
 	or return(0);
    return(1);
}

sub test_set_field()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($votable_field) = new VOTABLE::FIELD
 	or return(0);
    $votable_table->set_field($votable_field)
 	or return(0);
    ($votable_table->get_field)[0] eq $votable_field
 	or return(0);
    return(1);
}

sub test_get_link()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($votable_link) = new VOTABLE::LINK
 	or return(0);
    $votable_table->set_link($votable_link)
 	or return(0);
    ($votable_table->get_link)[0] eq $votable_link
 	or return(0);
    return(1);
}

sub test_set_link()
{
    my($votable_table) = new VOTABLE::TABLE
 	or return(0);
    my($votable_link) = new VOTABLE::LINK
 	or return(0);
    $votable_table->set_link($votable_link)
 	or return(0);
    ($votable_table->get_link)[0] eq $votable_link
 	or return(0);
    return(1);
}
