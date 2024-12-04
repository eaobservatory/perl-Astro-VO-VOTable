# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 17 };
use VOTABLE::Document;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules.
use VOTABLE::DESCRIPTION;
use VOTABLE::DEFINITIONS;
use VOTABLE::INFO;
use VOTABLE::RESOURCE;

# Subroutine prototypes.
sub new_from_filehandle();
sub new_from_string();
sub new_from_filename();
sub test_get_ID();
sub test_set_ID();
sub test_get_version();
sub test_set_version();
sub test_get_description();
sub test_set_description();
sub test_get_definitions();
sub test_set_definitions();
sub test_get_info();
sub test_set_info();
sub test_get_resource();
sub test_set_resource();

#########################

# Make sure the plain constructor works.
ok(defined(new VOTABLE::Document), 1);

# Make sure the constructor works with open filehandle input.
ok(new_from_filehandle, 1);

# Make sure the constructor works with string input.
ok(new_from_string(), 1);

# Make sure the alternate filename-based constructor works.
ok(new_from_filename(), 1);

# Test attribute accessors.
ok(test_get_ID(), 1);
ok(test_set_ID(), 1);
ok(test_get_version, 1);
ok(test_set_version, 1);

# Test the element accessors.
ok(test_get_description, 1);
ok(test_set_description, 1);
ok(test_get_definitions, 1);
ok(test_set_definitions, 1);
ok(test_get_info, 1);
ok(test_set_info, 1);
ok(test_get_resource, 1);
ok(test_set_resource, 1);

#########################

# Supporting subroutines for testing.

sub new_from_filehandle()
{
    my($filename) = 'test.xml';

    # Create the test file.
    if (not open(TEST_VOTABLE_FILE, ">$filename")) {
	warn("Unable to create $filename: $!");
	return(0);
    }

    # Fill in the test file.
    print TEST_VOTABLE_FILE <<_EOS_
<?xml version="1.0"?>
<!DOCTYPE VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
</VOTABLE>
_EOS_
;

    # Close the test file.
    if (not close(TEST_VOTABLE_FILE)) {
	warn("Unable to close $filename: $!");
	return(0);
    }

    # Create a file handle for the test file.
    my($fh) = new FileHandle $filename;
    if (not $fh) {
	warn("Unable to create filehandle for $filename: $!");
	return(0);
    }

    # Create the object from the file.
    my($votable) = new VOTABLE::Document $fh;
    if (not $votable) {
	warn("Unable to create VOTABLE::Document from file $filename!");
	return(0);
    }

    # Delete the file.
    if (not unlink($filename)) {
	warn("Unable to delete $filename: $!");
	return(0);
    }

    # Return normally.
    return(1);

}

sub new_from_string()
{

    # Fill in the test string.
    my($str) = <<'_EOS_'
<?xml version="1.0"?>
<!DOCTYPE VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
</VOTABLE>
_EOS_
;


    # Create the object from the string.
    my($votable) = new VOTABLE::Document $str;
    if (not $votable) {
 	warn("Unable to create VOTABLE::Document from string $str!");
 	return(0);
    }

    # Return normally.
    return(1);

}

sub new_from_filename()
{

    my($filename) = 'test.xml';

    # Create the test file.
    if (not open(TEST_VOTABLE_FILE, ">$filename")) {
	warn("Unable to create $filename: $!");
	return(0);
    }

    # Fill in the test file.
    print TEST_VOTABLE_FILE <<_EOS_
<?xml version="1.0"?>
<!DOCTYPE VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
</VOTABLE>
_EOS_
;

    # Close the test file.
    if (not close(TEST_VOTABLE_FILE)) {
	warn("Unable to close $filename: $!");
	return(0);
    }

    # Create the object from the file.
    my($votable) = new_from_filename VOTABLE::Document $filename;
    if (not $votable) {
	warn("Unable to create VOTABLE::Document from file $filename!");
	return(0);
    }

    # Delete the file.
    if (not unlink($filename)) {
	warn("Unable to delete $filename: $!");
	return(0);
    }

    # Return normally.
    return(1);

}

sub test_get_ID()
{
    my($votable_document) = new VOTABLE::Document
	or return(0);
    $votable_document->set_ID('100') eq '100'
	or return(0);
    $votable_document->get_ID eq '100'
	or return(0);
    return(1);
}

sub test_set_ID()
{
    my($votable_document) = new VOTABLE::Document
	or return(0);
    $votable_document->set_ID('100') eq '100'
	or return(0);
    $votable_document->get_ID eq '100'
	or return(0);
    return(1);
}

sub test_get_version()
{
    my($votable_document) = new VOTABLE::Document
	or return(0);
    $votable_document->set_version('1.0') eq '1.0'
	or return(0);
    $votable_document->get_version eq '1.0'
	or return(0);
    return(1);
}

sub test_set_version()
{
    my($votable_document) = new VOTABLE::Document
	or return(0);
    $votable_document->set_version('1.0') eq '1.0'
	or return(0);
    $votable_document->get_version eq '1.0'
	or return(0);
    return(1);
}

sub test_get_description()
{
    my($str) =
'<?xml version="1.0"?>
<!DOCTYPE  VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
<DESCRIPTION>Test description</DESCRIPTION>
</VOTABLE>';
    my($votable) = new VOTABLE::Document $str;
    return(0) if (not $votable);
    return(0) if (not $votable->get_description);
    return(0) if ($votable->get_description->get ne 'Test description');

    return(1);
}

sub test_set_description()
{
    my($votable) = new VOTABLE::Document
	or return(0);
    my($test_str) = 'This is a test.';
    my($description) = new VOTABLE::DESCRIPTION $test_str;
    return(0) if (not $description);
    return(0) if (not $votable->set_description($description));
    return(1);
}

sub test_get_definitions()
{
    my($str) =
'<?xml version="1.0"?>
<!DOCTYPE  VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
<DEFINITIONS></DEFINITIONS>
</VOTABLE>';
    my($votable) = new VOTABLE::Document $str;
    return(0) if (not $votable);
    return(0) if (not $votable->get_definitions);

    return(1);
}

sub test_set_definitions()
{
    my($votable) = new VOTABLE::Document
	or return(0);
    my($definitions) = new VOTABLE::DEFINITIONS
	or return(0);
    return(0) if (not $votable->set_definitions($definitions));
    return(1);
}

sub test_get_info()
{
    my($str) =
'<?xml version="1.0"?>
<!DOCTYPE  VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
<INFO></INFO>
<INFO></INFO>
</VOTABLE>';
    my($votable) = new VOTABLE::Document $str
	or return(0);
    return(0) if (not $votable->get_info);

    return(1);
}

sub test_set_info()
{
    my($votable) = new VOTABLE::Document
	or return(0);
    my($info) = new VOTABLE::INFO
	or return(0);
    $votable->set_info(($info))
	or return(0);
    return(1);
}

sub test_get_resource()
{
    my($str) =
'<?xml version="1.0"?>
<!DOCTYPE  VOTABLE SYSTEM "http://us-vo.org/xml/VOTable.dtd">
<VOTABLE>
<RESOURCE></RESOURCE>
<RESOURCE></RESOURCE>
</VOTABLE>';
    my($votable) = new VOTABLE::Document $str
	or return(0);
    return(0) if (not $votable->get_resource);
    return(1);
}

sub test_set_resource()
{
    my($votable) = new VOTABLE::Document
	or return(0);
    my($resource) = new VOTABLE::RESOURCE
	or return(0);
    return(0) if (not $votable->set_resource(($resource)));
    return(1);
}
