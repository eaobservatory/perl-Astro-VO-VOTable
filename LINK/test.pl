# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 20 };
use VOTABLE::LINK;
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
sub test_get_ID();
sub test_set_ID();
sub test_get_action();
sub test_set_action();
sub test_get_content_role();
sub test_set_content_role();
sub test_get_content_type();
sub test_set_content_type();
sub test_get_gref();
sub test_set_gref();
sub test_get_href();
sub test_set_href();
sub test_get_title();
sub test_set_title();
sub test_get_value();
sub test_set_value();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_action, 1);
ok(test_set_action, 1);
ok(test_get_content_role, 1);
ok(test_set_content_role, 1);
ok(test_get_content_type, 1);
ok(test_set_content_type, 1);
ok(test_get_gref, 1);
ok(test_set_gref, 1);
ok(test_get_href, 1);
ok(test_set_href, 1);
ok(test_get_title, 1);
ok(test_set_title, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);

# Test the element accessors.

# Test the PCDATA accessors.
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($test_text) = 'Test link';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link = new VOTABLE::LINK $test_text
	or return(0);
    $votable_link = new VOTABLE::LINK $test_text, ID => '12345'
	or return(0);
    $votable_link = new VOTABLE::LINK $factory->createElement('LINK')
	or return(0);
    return(1);
}

sub test_get_ID()
{
    my($test_ID) = 'a ID';
    my($votable_link) = new VOTABLE::LINK '', ID => $test_ID
	or return(0);
    $votable_link->get_ID eq $test_ID
	or return(0);
    return(1);
}

sub test_set_ID()
{
    my($test_ID) = 'a ID';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_ID($test_ID) eq $test_ID
	or return(0);
    return(1);
}

sub test_get_action()
{
    my($test_action) = 'a action';
    my($votable_link) = new VOTABLE::LINK '', action => $test_action
	or return(0);
    $votable_link->get_action eq $test_action
	or return(0);
    return(1);
}

sub test_set_action()
{
    my($test_action) = 'a action';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_action($test_action) eq $test_action
	or return(0);
    return(1);
}

sub test_get_content_role()
{
    my($test_content_role) = 'doc';
    my($votable_link) = new VOTABLE::LINK '', 'content-role' =>
	$test_content_role
	or return(0);
    $votable_link->get_content_role eq $test_content_role
	or return(0);
    return(1);
}

sub test_set_content_role()
{
    my($test_content_role) = 'doc';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_content_role($test_content_role) eq $test_content_role
	or return(0);
    return(1);
}

sub test_get_content_type()
{
    my($test_content_type) = 'image/gif';
    my($votable_link) = new VOTABLE::LINK '', 'content-type' =>
	$test_content_type
	or return(0);
    $votable_link->get_content_type eq $test_content_type
	or return(0);
    return(1);
}

sub test_set_content_type()
{
    my($test_content_type) = 'image/gif';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_content_type($test_content_type) eq $test_content_type
	or return(0);
    return(1);
}

sub test_get_gref()
{
    my($test_gref) = 'What is a gref?';
    my($votable_link) = new VOTABLE::LINK '', 'gref' =>	$test_gref
	or return(0);
    $votable_link->get_gref eq $test_gref
	or return(0);
    return(1);
}

sub test_set_gref()
{
    my($test_gref) = 'What is a gref?';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_gref($test_gref) eq $test_gref
	or return(0);
    return(1);
}

sub test_get_href()
{
    my($test_href) = 'http://www.nasa.gov';
    my($votable_link) = new VOTABLE::LINK '', 'href' =>	$test_href
	or return(0);
    $votable_link->get_href eq $test_href
	or return(0);
    return(1);
}

sub test_set_href()
{
    my($test_href) = 'http://www.nasa.gov';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_href($test_href) eq $test_href
	or return(0);
    return(1);
}

sub test_get_title()
{
    my($test_title) = 'Test title';
    my($votable_link) = new VOTABLE::LINK '', 'title' => $test_title
	or return(0);
    $votable_link->get_title eq $test_title
	or return(0);
    return(1);
}

sub test_set_title()
{
    my($test_title) = 'Test title';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_title($test_title) eq $test_title
	or return(0);
    return(1);
}

sub test_get_value()
{
    my($test_value) = 'Test value';
    my($votable_link) = new VOTABLE::LINK '', 'value' => $test_value
	or return(0);
    $votable_link->get_value eq $test_value
	or return(0);
    return(1);
}

sub test_set_value()
{
    my($test_value) = 'Test value';
    my($votable_link) = new VOTABLE::LINK
	or return(0);
    $votable_link->set_value($test_value) eq $test_value
	or return(0);
    return(1);
}

sub test_get()
{
    my($test_text) = 'This is a test.';
    my($this) = new VOTABLE::LINK $test_text
	or return(0);
    $this->get() eq $test_text
	or return(0);
    return(1);
}

sub test_set()
{
    my($test_text) = 'This is a test.';
    my($this) = new VOTABLE::LINK $test_text
	or return(0);
    $this->set($test_text) eq $test_text
	or return(0);
    return(1);
}
