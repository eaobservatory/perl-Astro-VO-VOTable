# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 16 };
use VOTABLE::STREAM;
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
sub test_get_actuate();
sub test_set_actuate();
sub test_get_encoding();
sub test_set_encoding();
sub test_get_expires();
sub test_set_expires();
sub test_get_href();
sub test_set_href();
sub test_get_rights();
sub test_set_rights();
sub test_get_type();
sub test_set_type();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_actuate, 1);
ok(test_set_actuate, 1);
ok(test_get_encoding, 1);
ok(test_set_encoding, 1);
ok(test_get_expires, 1);
ok(test_set_expires, 1);
ok(test_get_href, 1);
ok(test_set_href, 1);
ok(test_get_rights, 1);
ok(test_set_rights, 1);
ok(test_get_type, 1);
ok(test_set_type, 1);

# Test the PCDATA accessors.
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_stream);
    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream = new VOTABLE::STREAM 'Test string'
	or return(0);
    $votable_stream = new VOTABLE::STREAM 'Test string', type => 'locator'
	or return(0);
    $votable_stream = new VOTABLE::STREAM $factory->createElement('STREAM')
	or return(0);
    return(1);
}

sub test_get_actuate()
{
    my($test_actuate) = 'onLoad';
    my($votable_stream) = new VOTABLE::STREAM '', actuate => $test_actuate
	or return(0);
    $votable_stream->get_actuate eq $test_actuate
	or return(0);
    return(1);
}

sub test_set_actuate()
{
    my($test_actuate) = 'onLoad';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_actuate($test_actuate) eq $test_actuate
	or return(0);
    return(1);
}

sub test_get_encoding()
{
    my($test_encoding) = 'gzip';
    my($votable_stream) = new VOTABLE::STREAM '', encoding => $test_encoding
	or return(0);
    $votable_stream->get_encoding eq $test_encoding
	or return(0);
    return(1);
}

sub test_set_encoding()
{
    my($test_encoding) = 'gzip';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_encoding($test_encoding) eq $test_encoding
	or return(0);
    return(1);
}

sub test_get_expires()
{
    my($test_expires) = 'tomorrow';
    my($votable_stream) = new VOTABLE::STREAM '', expires => $test_expires
	or return(0);
    $votable_stream->get_expires eq $test_expires
	or return(0);
    return(1);
}

sub test_set_expires()
{
    my($test_expires) = 'tomorrow';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_expires($test_expires) eq $test_expires
	or return(0);
    return(1);
}

sub test_get_href()
{
    my($test_href) = 'http://www.nasa.gov';
    my($votable_stream) = new VOTABLE::STREAM '', href => $test_href
	or return(0);
    $votable_stream->get_href eq $test_href
	or return(0);
    return(1);
}

sub test_set_href()
{
    my($test_href) = 'http://www.nasa.gov';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_href($test_href) eq $test_href
	or return(0);
    return(1);
}

sub test_get_rights()
{
    my($test_rights) = 'all mine';
    my($votable_stream) = new VOTABLE::STREAM '', rights => $test_rights
	or return(0);
    $votable_stream->get_rights eq $test_rights
	or return(0);
    return(1);
}

sub test_set_rights()
{
    my($test_rights) = 'all mine';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_rights($test_rights) eq $test_rights
	or return(0);
    return(1);
}

sub test_get_type()
{
    my($test_type) = 'locator';
    my($votable_stream) = new VOTABLE::STREAM '', type => $test_type
	or return(0);
    $votable_stream->get_type eq $test_type
	or return(0);
    return(1);
}

sub test_set_type()
{
    my($test_type) = 'locator';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_type($test_type) eq $test_type
	or return(0);
    return(1);
}

sub test_get()
{
    my($test_text) = 'This is a test.';
    my($votable_stream) = new VOTABLE::STREAM $test_text
	or return(0);
    $votable_stream->get() eq $test_text
	or return(0);
    return(1);
}

sub test_set()
{
    my($test_text) = 'This is a test.';
    my($votable_stream) = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set($test_text) eq $test_text
	or return(0);
    return(1);
}
