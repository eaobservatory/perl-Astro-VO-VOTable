# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 12 };
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
sub test_get_row();
sub test_set_row();

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

# Test other methods.
ok(test_get_row, 1);
ok(test_set_row, 1);

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

sub test_get_row()
{
    my($votable_table);
    my($votable_data);
    my($votable_tabledata);
    my($votable_tr);
    my($votable_td);
    my(@row);
    my($test_str) = 'Test';
    my($votable_stream);
    my($votable_binary);
    my($test_data_file) = 'test.dat';
    my(@votable_field);

    # Test TABLEDATA version.
    $votable_td = new VOTABLE::TD $test_str or return(0);
    $votable_tr = new VOTABLE::TR or return(0);
    $votable_tr->set_td(($votable_td)) or return(0);
    $votable_tabledata = new VOTABLE::TABLEDATA or return(0);
    $votable_tabledata->append_tr($votable_tr) eq $votable_tr
	or return(0);
    $votable_data = new VOTABLE::DATA or return(0);
    $votable_data->set_tabledata($votable_tabledata) or return(0);
    $votable_table = new VOTABLE::TABLE or return(0);
    $votable_table->set_data($votable_data) or return(0);
    @row = $votable_table->get_row(0) or return(0);
    $row[0] eq $test_str or return(0);

    # Test BINARY version.
    open(TESTFILE, ">$test_data_file") or return(0);
    print TESTFILE pack('dfaslCqaa10', 1.23, 4.56, 'T', 42, 123456, 254,
 			123456789, 'z', 'Hello!');
    close(TESTFILE) or return(0);
    $votable_stream = new VOTABLE::STREAM or return(0);
    $votable_stream->set_href("file://$test_data_file") or return(0);
    $votable_binary = new VOTABLE::BINARY or return(0);
    $votable_binary->set_stream($votable_stream) or return(0);
    $votable_data = new VOTABLE::DATA or return(0);
    $votable_data->set_binary($votable_binary) or return(0);
    $votable_table = new VOTABLE::TABLE or return(0);
    $votable_table->set_data($votable_data) or return(0);
    $votable_field[0] = new VOTABLE::FIELD
 	undef, name => 'RA', datatype => 'double' or return(0);
    $votable_field[1] = new VOTABLE::FIELD
 	undef, name => 'DEC', datatype => 'float' or return(0);
    $votable_field[2] = new VOTABLE::FIELD
 	undef, name => 'GOODFLAG', datatype => 'boolean' or return(0);
    $votable_field[3] = new VOTABLE::FIELD
 	undef, name => 'COUNTS', datatype => 'short' or return(0);
    $votable_field[4] = new VOTABLE::FIELD
 	undef, name => 'OTHER_COUNTS', datatype => 'int' or return(0);
    $votable_field[5] = new VOTABLE::FIELD
 	undef, name => 'FLAGS', datatype => 'unsignedByte' or return(0);
    $votable_field[6] = new VOTABLE::FIELD
 	undef, name => 'BIG_NUMBER', datatype => 'long' or return(0);
    $votable_field[7] = new VOTABLE::FIELD
 	undef, name => 'LAST_LETTER', datatype => 'char' or return(0);
    $votable_field[8] = new VOTABLE::FIELD
 	undef, name => 'MESSAGE', datatype => 'char', arraysize => 10
 	or return(0);
    $votable_table->set_field(@votable_field) or return(0);
    @row = $votable_table->get_row(0) or return(0);
    abs($row[0] - 1.23) <= 1e-14 or return(0);
    abs($row[1] - 4.56) <= 1e-7 or return(0);
    $row[2] eq 'T' or return(0);
    $row[3] == 42 or return(0);
    $row[4] == 123456 or return(0);
    $row[5] ==  254 or return(0);
    $row[6] == 123456789 or return(0);
    $row[7] eq 'z' or return(0);
    $row[8] =~ /^Hello\!/ or return(0);
    unlink($test_data_file) or return(0);

    # It worked.
    return(1);

}

sub test_set_row()
{
    my($votable_table);
    my($votable_field);
    my($votable_data);
    my($votable_tabledata);
    my($votable_tr);
    my($votable_td);
    my(@row);
    my($test_str) = 'Test';
    my($test_data_file) = 'test.dat';
    my($votable_stream);
    my($votable_binary);

    # Test TABLEDATA version.
    $votable_td = new VOTABLE::TD or return(0);
    $votable_tr = new VOTABLE::TR or return(0);
    $votable_tr->set_td(($votable_td)) or return(0);
    $votable_tabledata = new VOTABLE::TABLEDATA or return(0);
    $votable_tabledata->append_tr($votable_tr) eq $votable_tr or return(0);
    $votable_data = new VOTABLE::DATA or return(0);
    $votable_data->set_tabledata($votable_tabledata) or return(0);
    $votable_table = new VOTABLE::TABLE or return(0);
    $votable_table->set_data($votable_data) or return(0);
    $votable_table->set_row(0, ($test_str)) or return(0);
    @row = $votable_table->get_row(0) or return(0);
    $row[0] eq $test_str or return(0);

    # Test BINARY version.
    open(TESTFILE, ">$test_data_file") or return(0);
    print TESTFILE pack('d', 1.23);
    close(TESTFILE) or return(0);
    $votable_stream = new VOTABLE::STREAM
 	undef, 'href' => "file://$test_data_file" or return(0);
    $votable_binary = new VOTABLE::BINARY or return(0);
    $votable_binary->set_stream($votable_stream) or return(0);
    $votable_data = new VOTABLE::DATA or return(0);
    $votable_data->set_binary($votable_binary) or return(0);
    $votable_table = new VOTABLE::TABLE or return(0);
    $votable_table->set_data($votable_data) or return(0);
    $votable_field = new VOTABLE::FIELD
 	undef, name => 'RA', datatype => 'double' or return(0);
    $votable_table->set_field(($votable_field)) or return(0);
    ($votable_table->get_row(0))[0] == 1.23 or return(0);
    $votable_table->set_row(0, (2.46)) or return(0);
    ($votable_table->get_row(0))[0] == 2.46 or return(0);
    $votable_table->set_row(1, (2.46)) or return(0);
    ($votable_table->get_row(1))[0] == 2.46 or return(0);

    # It worked.
    return(1);

}
