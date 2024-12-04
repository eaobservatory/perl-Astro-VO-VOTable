# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
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
sub test_get_content();
sub test_set_content();

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

# Test other methods.
ok(test_get_content, 1);
ok(test_set_content, 1);

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

sub test_get_content()
{

    # Local variables.
    my($votable_binary);
    my($votable_stream);
    my($str);
    my($test_file) = 'test.dat';
    my($test_val) = 1.0;
    my($val);

    #--------------------------------------------------------------------------

    # Create the external binary data file. It will contain a single
    # double-precision floating-point number.
    $str = pack('d', $test_val);
    open(BINARY_STREAM, ">$test_file") or return(0);
    print BINARY_STREAM $str;
    close(BINARY_STREAM) or return(0);

    # Create the STREAM element.
    $votable_stream = new VOTABLE::STREAM
	undef, type => 'locator', encoding => 'none' or return(0);
    $votable_stream->set_href("file://$test_file") or return(0);

    # Create the BINARY element and assign the STREAM to it.
    $votable_binary = new VOTABLE::BINARY or return(0);
    $votable_binary->set_stream($votable_stream) or return(0);

    # Read the content and check it.
    $str = $votable_binary->get_content or return(0);
    ($val) = unpack('d', $str);
    $val == $test_val or return(0);

    # Unlink the file so it is automatically deleted on exit.
    unlink($test_file) or return(0);

    # It worked.
    return(1);

}

sub test_set_content()
{

    # Local variables

    my($votable_stream);
    my($votable_binary);
    my($test_bytes) = 'test';

    #--------------------------------------------------------------------------

    # Create the STREAM.
    $votable_stream = new VOTABLE::STREAM
	undef, actuate => 'none' or return(0);

    # Create the BINARY and assign the STREAM to it.
    $votable_binary = new VOTABLE::BINARY or return(0);
    $votable_binary->set_stream($votable_stream) eq $votable_stream
	or return(0);

    # Set the content and verify it.
    $votable_binary->set_content($test_bytes) eq $test_bytes or return(0);

    # It worked!
    return(1);

}
