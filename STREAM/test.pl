# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 20 };
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
sub test_actuate();
sub test_get_content();
sub test_set_content();
sub test_serialize();

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

# Test the other methods.
ok(test_actuate, 1);
ok(test_get_content, 1);
ok(test_set_content, 1);
ok(test_serialize, 1);

#########################

# Supporting subroutines for testing.

sub test_new()
{
    my($votable_stream);
    my($test_str) = 'This is a test.';
    my($test_type) = 'locator';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream = new VOTABLE::STREAM $test_str
	or return(0);
    $votable_stream = new VOTABLE::STREAM $test_str, type => $test_type
	or return(0);
    $votable_stream = new VOTABLE::STREAM $factory->createElement('STREAM')
	or return(0);

    return(1);
}

sub test_get_actuate()
{
    my($votable_stream);
    my($test_actuate) = 'onLoad';
    my($default_actuate) = 'onRequest';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->get_actuate eq $default_actuate
	or return(0);

    $votable_stream = new VOTABLE::STREAM '', actuate => $test_actuate
 	or return(0);
    $votable_stream->get_actuate eq $test_actuate
 	or return(0);

    return(1);
}

sub test_set_actuate()
{
    my($votable_stream);
    my($test_actuate) = 'onLoad';
    my($default_actuate) = 'onRequest';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_actuate($test_actuate) eq $test_actuate
	or return(0);
    $votable_stream->set_actuate(undef) eq $default_actuate
	or return(0);

    return(1);
}

sub test_get_encoding()
{
    my($votable_stream);
    my($test_encoding) = 'base64';
    my($default_encoding) = 'none';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->get_encoding eq $default_encoding
	or return(0);

    $votable_stream = new VOTABLE::STREAM '', encoding => $test_encoding
 	or return(0);
    $votable_stream->get_encoding eq $test_encoding
 	or return(0);

    return(1);
}

sub test_set_encoding()
{
    my($votable_stream);
    my($test_encoding) = 'base64';
    my($default_encoding) = 'none';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_encoding($test_encoding) eq $test_encoding
	or return(0);
    $votable_stream->set_encoding(undef) eq $default_encoding
	or return(0);

    return(1);
}

sub test_get_expires()
{
    my($votable_stream);
    my($test_expires) = 'tomorrow';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    not defined($votable_stream->get_expires)
	or return(0);

    $votable_stream = new VOTABLE::STREAM '', expires => $test_expires
 	or return(0);
    $votable_stream->get_expires eq $test_expires
 	or return(0);

    return(1);
}

sub test_set_expires()
{
    my($votable_stream);
    my($test_expires) = 'tomorrow';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_expires($test_expires) eq $test_expires
	or return(0);
    not defined($votable_stream->set_expires(undef))
	or return(0);

    return(1);
}

sub test_get_href()
{
    my($votable_stream);
    my($test_href) = 'http://heasarc.gsfc.nasa.gov';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    not defined($votable_stream->get_href)
	or return(0);

    $votable_stream = new VOTABLE::STREAM '', href => $test_href
 	or return(0);
    $votable_stream->get_href eq $test_href
 	or return(0);

    return(1);
}

sub test_set_href()
{
    my($votable_stream);
    my($test_href) = 'http://heasarc.gsfc.nasa.gov';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_href($test_href) eq $test_href
	or return(0);
    not defined($votable_stream->set_href(undef))
	or return(0);

    return(1);
}

sub test_get_rights()
{
    my($votable_stream);
    my($test_rights) = 'unlimited';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    not defined($votable_stream->get_rights)
	or return(0);

    $votable_stream = new VOTABLE::STREAM '', rights => $test_rights
 	or return(0);
    $votable_stream->get_rights eq $test_rights
 	or return(0);

    return(1);
}

sub test_set_rights()
{
    my($votable_stream);
    my($test_rights) = 'unlimited';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_rights($test_rights) eq $test_rights
	or return(0);
    not defined($votable_stream->set_rights(undef))
	or return(0);

    return(1);
}

sub test_get_type()
{
    my($votable_stream);
    my($test_type) = 'other';
    my($default_type) = 'locator';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->get_type eq $default_type
	or return(0);

    $votable_stream = new VOTABLE::STREAM '', type => $test_type
 	or return(0);
    $votable_stream->get_type eq $test_type
 	or return(0);

    return(1);
}

sub test_set_type()
{
    my($votable_stream);
    my($test_type) = 'other';
    my($default_type) = 'locator';

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_type($test_type) eq $test_type
	or return(0);
    $votable_stream->set_type(undef) eq $default_type
	or return(0);

    return(1);
}

sub test_get()
{
    my($votable_stream);
    my($test_text) = 'This is a test.';
    my($test_text2) = 'This is another test.';
    my($textnode);

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    not defined($votable_stream->get)
	or return(0);

    $votable_stream = new VOTABLE::STREAM $test_text
	or return(0);
    $votable_stream->get eq $test_text
	or return(0);

    $textnode = $factory->createTextNode($test_text2)
	or return(0);
    $textnode->setOwnerDocument($votable_stream->
				_get_XMLDOM->getOwnerDocument);
    $votable_stream->_get_XMLDOM->appendChild($textnode)
	or return(0);
    $votable_stream->get eq ($test_text . $test_text2)
	or return(0);

    return(1);
}

sub test_set()
{
    my($votable_stream);
    my($test_text) = 'This is a test.';

    $votable_stream = new VOTABLE::STREAM
 	or return(0);
    $votable_stream->set($test_text) eq $test_text
 	or return(0);
    not defined($votable_stream->set(undef))
 	or return(0);

    return(1);
}

sub test_actuate()
{
    my($str);
    my($format) = 'd';
    my($value) = 1.0;
    my($filename) = 'test.dat';
    my($href) = "file://$filename";
    my($votable_stream);

    #--------------------------------------------------------------------------

    # Create the external binary data file. It will contain a single
    # double-precision floating-point number.
    $str = pack($format, $value);
    open(BINARY_STREAM, '>', $filename)
	or return(0);
    print BINARY_STREAM $str
	or return(0);
    close(BINARY_STREAM)
	or return(0);

    # Create the STREAM object and actuate it.
    $votable_stream = new VOTABLE::STREAM
 	undef, href => $href
	or return(0);
    $votable_stream->actuate
	or return(0);

    # Unlink the file so it is automatically deleted on exit.
    unlink($filename)
	or return(0);

    # It worked.
    return(1);

}

sub test_get_content()
{
    my($str);
    my($format) = 'd';
    my($value) = 1.0;
    my($filename) = 'test.dat';
    my($href) = "file://$filename";
    my($votable_stream);

    #--------------------------------------------------------------------------

    # Create the external binary data file. It will contain a single
    # double-precision floating-point number.
    $str = pack($format, $value);
    open(BINARY_STREAM, '>', $filename)
	or return(0);
    print BINARY_STREAM $str
	or return(0);
    close(BINARY_STREAM) or
	return(0);

    # Create the STREAM object.
    $votable_stream = new VOTABLE::STREAM
	undef, href => $href
	or return(0);

    # Read the binary file.
    $str = $votable_stream->get_content
	or return(0);

    # Verify the contents.
    (unpack($format, $str))[0] == $value
	or return(0);

    # Unlink the file so it is automatically deleted on exit.
    unlink($filename)
	or return(0);

    # It worked!
    return(1);

}

sub test_set_content()
{
    my($votable_stream);
    my($test_bytes) = 'test';

    #--------------------------------------------------------------------------

    $votable_stream = new VOTABLE::STREAM
	or return(0);
    $votable_stream->set_content($test_bytes) eq $test_bytes
	or return(0);

    return(1);

}

sub test_serialize()
{
    my($votable_stream);
    my($test_file) = 'test.dat';
    my($test_href) = "file://$test_file";
    my($test_format) = 'd';
    my($test_value) = 1.0;
    my($test_bytes);

    #--------------------------------------------------------------------------

    # Create the STREAM.
    $votable_stream = new VOTABLE::STREAM
	or return(0);

    # Assemble and assign the content.
    $test_bytes = pack($test_format, ($test_value))
	or return(0);
    $votable_stream->set_content($test_bytes) eq $test_bytes
	or return(0);

    # Assign the href (must be done AFTER setting data).
    $votable_stream->set_href($test_href) eq $test_href
	or return(0);

    # Serialize the content.
    $votable_stream->serialize
	or return(0);

    # Now read the data back in with another object.
    $votable_stream = new VOTABLE::STREAM
	undef, href => $test_href
	or return(0);
    $test_bytes = $votable_stream->get_content
	or return(0);
    (unpack($test_format, $test_bytes))[0] == $test_value
	or return(0);

    # It worked.
    return(1);

}
