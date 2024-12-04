# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 4 };
use VOTABLE::TABLEDATA;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use XML::DOM;
use VOTABLE::TR;

# Subroutine prototypes.
sub test_new();
sub test_get_tr();
sub test_set_tr();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test PCDATA accessors.

# Test attribute accessors.

# Test element accessors.
ok(test_get_tr, 1);
ok(test_set_tr, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_tabledata);
    $votable_tabledata = new VOTABLE::TABLEDATA
	or return(0);
    $votable_tabledata = new VOTABLE::TABLEDATA
	$factory->createElement('TABLEDATA')
	or return(0);
    return(1);
}

sub test_get_tr()
{
    my($votable_tabledata);
    $votable_tabledata = new VOTABLE::TABLEDATA
	or return(0);
    my($votable_tr) = new VOTABLE::TR
 	or return(0);
    $votable_tabledata->set_tr(($votable_tr))
	or return(0);
    ($votable_tabledata->get_tr)[0] eq $votable_tr
	or return(0);
    return(1);
}

sub test_set_tr()
{
    my($votable_tabledata);
    $votable_tabledata = new VOTABLE::TABLEDATA
	or return(0);
    my($votable_tr) = new VOTABLE::TR
 	or return(0);
    $votable_tabledata->set_tr(($votable_tr))
	or return(0);
    ($votable_tabledata->get_tr)[0] eq $votable_tr
	or return(0);
    return(1);
}
