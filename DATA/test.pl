# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use VOTABLE::DATA;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use XML::DOM;
use VOTABLE::BINARY;
use VOTABLE::FITS;
use VOTABLE::TABLEDATA;

# Subroutine prototypes.
sub test_new();
sub test_get_binary();
sub test_set_binary();
sub test_get_fits();
sub test_set_fits();
sub test_get_tabledata();
sub test_set_tabledata();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.

# Test the element accessors.
ok(test_get_binary, 1);
ok(test_set_binary, 1);
ok(test_get_fits, 1);
ok(test_set_fits, 1);
ok(test_get_tabledata, 1);
ok(test_set_tabledata, 1);

# Test the PCDATA content accessors.

#########################

sub test_new()
{
    my($votable_data);
    $votable_data = new VOTABLE::DATA
	or return(0);
    return(1);
}

sub test_get_binary()
{
    my($votable_data) = new VOTABLE::DATA
	or return(0);
    my($votable_binary) = new VOTABLE::BINARY
	or return(0);
    $votable_data->set_binary($votable_binary) eq $votable_binary
	or return(0);
    $votable_data->get_binary eq $votable_binary
	or return(0);
    return(1);
}

sub test_set_binary()
{
    my($votable_data) = new VOTABLE::DATA
	or return(0);
    my($votable_binary) = new VOTABLE::BINARY
	or return(0);
    $votable_data->set_binary($votable_binary) eq $votable_binary
	or return(0);
    $votable_data->get_binary eq $votable_binary
	or return(0);
    return(1);
}

sub test_get_fits()
{
    my($votable_data) = new VOTABLE::DATA
	or return(0);
    my($votable_fits) = new VOTABLE::FITS
	or return(0);
    $votable_data->set_fits($votable_fits) eq $votable_fits
	or return(0);
    $votable_data->get_fits eq $votable_fits
	or return(0);
    return(1);
}

sub test_set_fits()
{
    my($votable_data) = new VOTABLE::DATA
	or return(0);
    my($votable_fits) = new VOTABLE::FITS
	or return(0);
    $votable_data->set_fits($votable_fits) eq $votable_fits
	or return(0);
    $votable_data->get_fits eq $votable_fits
	or return(0);
    return(1);
}

sub test_get_tabledata()
{
    my($votable_data) = new VOTABLE::DATA
	or return(0);
    my($votable_tabledata) = new VOTABLE::TABLEDATA
	or return(0);
    $votable_data->set_tabledata($votable_tabledata) eq $votable_tabledata
	or return(0);
    $votable_data->get_tabledata eq $votable_tabledata
	or return(0);
    return(1);
}

sub test_set_tabledata()
{
    my($votable_data) = new VOTABLE::DATA
	or return(0);
    my($votable_tabledata) = new VOTABLE::TABLEDATA
	or return(0);
    $votable_data->set_tabledata($votable_tabledata) eq $votable_tabledata
	or return(0);
    $votable_data->get_tabledata eq $votable_tabledata
	or return(0);
    return(1);
}
