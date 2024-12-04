# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 4 };
use VOTABLE::BINARY;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use VOTABLE::STREAM;

# Subroutine prototypes.
sub test_new();
sub test_get_stream();
sub test_set_stream();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.

# Test the element accessors.
ok(test_get_stream, 1);
ok(test_set_stream, 1);

# Test the PCDATA accessors.

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_binary);
    $votable_binary = new VOTABLE::BINARY
	or return(0);
    $votable_binary = new VOTABLE::BINARY $factory->createElement('BINARY')
	or return(0);
    return(1);
}

sub test_get_stream()
{
    my($votable_binary) = new VOTABLE::BINARY
	or return(0);
    my($votable_stream) = new VOTABLE::STREAM 'Test stream'
 	or return(0);
    $votable_binary->set_stream($votable_stream) eq $votable_stream
 	or return(0);
    $votable_binary->get_stream eq $votable_stream
 	or return(0);
    return(1);
}

sub test_set_stream()
{
    my($votable_binary) = new VOTABLE::BINARY
	or return(0);
    my($votable_stream) = new VOTABLE::STREAM 'Test stream'
 	or return(0);
    $votable_binary->set_stream($votable_stream) eq $votable_stream
 	or return(0);
    return(1);
}
