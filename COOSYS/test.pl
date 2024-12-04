# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 12 };
use VOTABLE::COOSYS;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# External modules.
use XML::DOM;

# Subroutine prototypes.
sub test_new();
sub test_get_ID();
sub test_set_ID();
sub test_get_epoch();
sub test_set_epoch();
sub test_get_equinox();
sub test_set_equinox();
sub test_get_system();
sub test_set_system();
sub test_get();
sub test_set();

#########################

# Create a factory document for building XML::DOM objects.
my($factory) = new XML::DOM::Document;

# Test the constructor.
ok(test_new, 1);

# Test the attribute accessors.
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_epoch, 1);
ok(test_set_epoch, 1);
ok(test_get_equinox, 1);
ok(test_set_equinox, 1);
ok(test_get_system, 1);
ok(test_set_system, 1);

# Test the element accessors.

# Test the PCDATA accessors.
ok(test_get, 1);
ok(test_set, 1);

#########################

# Supporting subroutines for testing

sub test_new()
{
    my($votable_coosys);
    my($test_str) = 'This is a test.';
    my($test_ID) = '1';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    $votable_coosys = new VOTABLE::COOSYS $test_str
	or return(0);
    $votable_coosys = new VOTABLE::COOSYS $test_str , ID => $test_ID
	or return(0);
    $votable_coosys = new VOTABLE::COOSYS $factory->createElement('COOSYS')
	or return(0);
    $votable_coosys = new VOTABLE::COOSYS $factory->createElement('COOSYS'),
        ID => $test_ID
	or return(0);
    $votable_coosys = new VOTABLE::COOSYS ''
	or return(0);

    return(1);
}

sub test_get_ID()
{
    my($votable_coosys);
    my($test_ID) = '12345';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    not defined($votable_coosys->get_ID)
	or return(0);

    $votable_coosys = new VOTABLE::COOSYS '', ID => $test_ID
	or return(0);
    $votable_coosys->get_ID eq $test_ID
	or return(0);

    return(1);
}

sub test_set_ID()
{
    my($votable_coosys);
    my($test_ID) = '12345';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    $votable_coosys->set_ID($test_ID) eq $test_ID
	or return(0);
    not defined($votable_coosys->set_ID(undef))
	or return(0);

    return(1);
}

sub test_get_epoch()
{
    my($votable_coosys);
    my($test_epoch) = '2000';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    not defined($votable_coosys->get_epoch)
	or return(0);

    $votable_coosys = new VOTABLE::COOSYS '', epoch => $test_epoch
	or return(0);
    $votable_coosys->get_epoch eq $test_epoch
	or return(0);

    return(1);
}

sub test_set_epoch()
{
    my($votable_coosys);
    my($test_epoch) = '2000';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    $votable_coosys->set_epoch($test_epoch) eq $test_epoch
	or return(0);
    not defined($votable_coosys->set_epoch(undef))
	or return(0);

    return(1);
}

sub test_get_equinox()
{
    my($votable_coosys);
    my($test_equinox) = '2000';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    not defined($votable_coosys->get_equinox)
	or return(0);

    $votable_coosys = new VOTABLE::COOSYS '', equinox => $test_equinox
	or return(0);
    $votable_coosys->get_equinox eq $test_equinox
	or return(0);

    return(1);
}

sub test_set_equinox()
{
    my($votable_coosys);
    my($test_equinox) = '2000';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    $votable_coosys->set_equinox($test_equinox) eq $test_equinox
	or return(0);
    not defined($votable_coosys->set_equinox(undef))
	or return(0);

    return(1);
}

sub test_get_system()
{
    my($votable_coosys);
    my($test_system) = 'galactic';
    my($test_system_default) = 'eq_FK5';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    $votable_coosys->get_system eq $test_system_default
	or return(0);

    $votable_coosys = new VOTABLE::COOSYS '', system => $test_system
	or return(0);
    $votable_coosys->get_system eq $test_system
	or return(0);

    return(1);
}

sub test_set_system()
{
    my($votable_coosys);
    my($test_system) = 'galactic';
    my($test_system_default) = 'eq_FK5';

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    $votable_coosys->set_system($test_system) eq $test_system
	or return(0);
    $votable_coosys->set_system(undef) eq $test_system_default
	or return(0);

    return(1);
}

sub test_get()
{
    my($votable_coosys);
    my($test_text) = 'This is a test.';
    my($test_text2) = 'This is another test.';
    my($textnode);

    $votable_coosys = new VOTABLE::COOSYS
	or return(0);
    not defined($votable_coosys->get)
	or return(0);

    $votable_coosys = new VOTABLE::COOSYS $test_text
	or return(0);
    $votable_coosys->get eq $test_text
	or return(0);

    $textnode = $factory->createTextNode($test_text2)
	or return(0);
    $textnode->setOwnerDocument($votable_coosys->
				_get_XMLDOM->getOwnerDocument);
    $votable_coosys->_get_XMLDOM->appendChild($textnode)
	or return(0);
    $votable_coosys->get eq ($test_text . $test_text2)
	or return(0);

    return(1);
}

sub test_set()
{
    my($votable_coosys);
    my($test_text) = 'This is a test.';

    $votable_coosys = new VOTABLE::COOSYS
 	or return(0);
    $votable_coosys->set($test_text) eq $test_text
 	or return(0);
    not defined($votable_coosys->set(undef))
 	or return(0);

    return(1);
}
