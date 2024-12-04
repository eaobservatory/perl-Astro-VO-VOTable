#!/Home/lhea3/elwinter/bin/perl -w

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

votable_dump.pl - Dump a VOTABLE file

=head1 SYNOPSIS

votable_dump.pl [--dataonly] [--debug] [--help] [--sep=s] [--verbose]
[--version] [--warn] votable_file [col1 col2 ...]

where:

--dataonly - Dump the data portions of the file only. The data from
  each DATA element are output as CSV tables, using the specified
  separator string, one record per line, with a all data in a single
  table.
--debug - Turn on debugging output.
--help - Display a help message describing command-line options.
--sep=s - Use the string 's' as the column separator; default is the
  pipe character ('|').
--verbose - Turn on verbose output.
--version - Print the program version number.
--warn - Print warning messages for recoverable errors.
votable_file - Name of VOTABLE file to dump.
coln - Name of column to dump in --dataonly mode. By default, all
columns are dumped.

=head1 DESCRIPTION

This program reads the specified VOTABLE file and dumps parts of it to
standard output in a human-readable format.

=head1 WARNINGS

=over 4

=item *

This is very crude code for now, and only works correctly on
single-table files.

=back

=head1 SEE ALSO

C<VOTABLE>

=head1 VERSION

$Id: votable_dump.pl,v 1.1.1.4 2002/06/06 19:34:18 elwinter Exp $

=head1 AUTHOR

Eric Winter (elwinter@milkyway.gsfc.nasa.gov)

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: votable_dump.pl,v $
# Revision 1.1.1.4  2002/06/06  19:34:18  elwinter
# Added correct --dataonly behavior.
#
# Revision 1.1.1.3  2002/05/30  17:47:02  elwinter
# Added options to allow specification of output columns.
#
# Revision 1.1.1.2  2002/05/30  16:59:08  elwinter
# Added --dataonly option.
#
# Revision 1.1.1.1  2002/05/30  16:26:22  elwinter
# Placeholder for new branch.
#
# Revision 1.1  2002/05/30  16:24:09  elwinter
# Initial revision
#

#******************************************************************************

# Begin main module.
package main;

#------------------------------------------------------------------------------

# Compiler pragmas.

# Turn on strict everything and maximum diagnostics.
use diagnostics;
use strict;
use warnings;

#------------------------------------------------------------------------------

# Specify external modules to use.

# Standard modules.
require 'dumpvar.pl';
use Getopt::Long;

# Third-party modules.

# Project modules.
use VOTABLE::Document;

#------------------------------------------------------------------------------

# Constants

# Program version
use constant VERSION => '$Revision: 1.1.1.4 $ ';

# Default column separator character.
use constant DEFAULT_COLUMN_SEPARATOR => '|';

#------------------------------------------------------------------------------

# Globals

# Set this flag to print only the DATA element contents.
my($dataonly);

# Set this flag to generate debugging output.
my($debug);

# Set this flag if the user wants help.
my($help);

# String to use as the column separator.
my($sep) = DEFAULT_COLUMN_SEPARATOR;

# Set this flag for verbose operation.
my($verbose);

# Set this flag to print the program version number.
my($version);

# Set this flag to print warning messages.
my($warn);

# List of option specifiers, and hash to hold mapping of command-line
# options and arguments for GetOptions().
my(@optlist) =
    (
     'dataonly',
     'debug',
     'help',
     'sep=s',
     'verbose',
     'version',
     'warn',
     );
my(%optctl) =
    (
     'dataonly' => \$dataonly,
     'debug'    => \$debug,
     'help'     => \$help,
     'sep'      => \$sep,
     'verbose'  => \$verbose,
     'version'  => \$version,
     'warn'     => \$warn,
     );

# Indent level (number of spaces) for printing.
my($indent);

# Names and indices of columns to dump.
my(@dumpcolumn_names);
my(@dumpcolumn_numbers);

#------------------------------------------------------------------------------

# Subroutine declarations

sub _GetHelp();
sub _GetVersion();
sub _ValidOptions();
sub _MainLoop();

sub _dump_BINARY($);
sub _dump_COOSYS($);
sub _dump_DATA($);
sub _dump_DEFINITIONS($);
sub _dump_DESCRIPTION($);
sub _dump_FIELD($);
sub _dump_FITS($);
sub _dump_INFO($);
sub _dump_LINK($);
sub _dump_MIN($);
sub _dump_MAX($);
sub _dump_OPTION($);
sub _dump_PARAM($);
sub _dump_RESOURCE($);
sub _dump_TABLE($);
sub _dump_TABLEDATA($);
sub _dump_TD($);
sub _dump_TR($);
sub _dump_VALUES($);
sub _dump_VOTABLE($);

sub _dump_attribute($$);
sub _dump_PCDATA($);

sub _MapColumnNamesToNumbers($@);

#******************************************************************************

# Local utility subroutines

# Debugging dump routine.
sub _dump { print("(DEBUG) $_[0]\n"); dumpValue($_[1]) if (defined($_[1])); }

#------------------------------------------------------------------------------

# Main block.

# This block processes command-line options and invokes the main code.

{

    # Process command-line arguments.
    GetOptions(\%optctl, @optlist);
    _dump('optctl', \%optctl) if ($debug);
    _dump('ARGV', \@ARGV) if ($debug);

    # Print help message if needed.
    exit(0) if ($help and print(_GetHelp()));

    # Print the program version number if needed.
    exit(0) if ($version and print(_GetVersion(), "\n"));

    # Validate the options.
    exit(1) if (not _ValidOptions());

    # Beyond this point, the code may safely assume that all values
    # and flags derived from the command line are valid and internally
    # consistent.

    #--------------------------------------------------------------------------

    # Enter the main program loop.
    die('Fatal error!') if (not _MainLoop());

    #--------------------------------------------------------------------------

    # Exit normally.
    exit(0);

}

#******************************************************************************

# _GetHelp()

# This internal subroutine returns a string containing help text for
# the program.

sub _GetHelp()
{
    return(<<_EOS_
Usage: votable_dump.pl [--dataonly] [--debug] [--help] [--sep=s] [--verbose]
[--version] [--warn] votable_file [col1 col2 ...]

where:

--dataonly - Dump the data portions of the file only. The data from
  each DATA element are output as CSV tables, using the specified
  separator string, one record per line, with all data in a single
  table.
--debug - Turn on debugging output.
--help - Display a help message describing command-line options.
--sep=s - Use the string 's' as the column separator; default is the
  pipe character ('|').
--verbose - Turn on verbose output.
--version - Print the program version number.
--warn - Print warning messages for recoverable errors.
votable_file - Name of VOTABLE file to dump.
coln - Name of column to dump in --dataonly mode. By default, all
columns are dumped.
_EOS_
    );
}

#******************************************************************************

# _GetVersion()

# This internal subroutine returns a string containing the program
# version number. The version string is maintained by RCS.

sub _GetVersion()
{
    return((VERSION =~ /(\d+(\.\d+)+)/)[0]);
}

#******************************************************************************

# _ValidOptions()

# This internal subroutine validates all of the options specified on
# the command line. Return 1 if all options are valid, and 0
# otherwise.

sub _ValidOptions()
{

    #--------------------------------------------------------------------------

    # A valid column separator must be specified.
    if (not defined($sep) or length($sep) == 0) {
 	warn('A column separator must be specified.');
 	return(0);
    }

    # A filename must be provided.
    if (not defined($ARGV[0]) or length($ARGV[0]) == 0) {
	warn('A filename must be specified.');
	return(0);
    }

    #--------------------------------------------------------------------------

    # Return normally.
    return(1);

}

#******************************************************************************

# _MainLoop()

# This internal subroutine contains the main high-level program loop.

sub _MainLoop()
{

    _dump('Starting ' . (caller(0))[3]) if ($debug);

    #--------------------------------------------------------------------------

    # Local variables

    # Name of VOTABLE file to dump.
    my($votable_file);

    # Arrays and scalars to hold VOTABLE objects.
    my($votable_document);

    #--------------------------------------------------------------------------

    # Save the name of the file to dump.
    $votable_file = shift @ARGV;
    _dump('votable_file', \$votable_file) if ($debug);

    # Get the names of the columns to dump.
    @dumpcolumn_names = @ARGV;
    _dump('dumpcolumn_names', \@dumpcolumn_names) if ($debug);

    # Read the VOTABLE file.
    $votable_document = new_from_filename VOTABLE::Document $votable_file
	or die;

    #--------------------------------------------------------------------------

    # Print the interesting parts.
    $indent = 0;
    _dump_VOTABLE($votable_document);

    #--------------------------------------------------------------------------

    _dump('Ending ' . (caller(0))[3]) if ($debug);

    # Return normally.
    return(1);

}

#******************************************************************************

sub _dump_BINARY($)
{
    my($this) = @_;
    my($element);

    print(' ' x $indent, "BINARY\n");
    $indent++;

    $element = $this->get_stream;
    if ($element) {
	_dump_STREAM($element);
    }

    $indent--;

    return(1);
}

sub _dump_COOSYS($)
{
    my($this) = @_;
    my($attribute, $pcdata);

    print(' ' x $indent, "COOSYS\n");
    $indent++;

    $attribute = $this->get_ID;
    if (defined($attribute)) {
	_dump_attribute('ID', $attribute);
    }

    $attribute = $this->get_equinox;
    if (defined($attribute)) {
	_dump_attribute('equinox', $attribute);
    }

    $attribute = $this->get_epoch;
    if (defined($attribute)) {
	_dump_attribute('epoch', $attribute);
    }

    $attribute = $this->get_system;
    if (defined($attribute)) {
	_dump_attribute('system', $attribute);
    }

    $indent--;

    return(1);
}

sub _dump_DATA($)
{
    my($this) = @_;
    my($element);

    print(' ' x $indent, "DATA\n");
    $indent++;

    $element = $this->get_tabledata;
    if ($element) {
	_dump_TABLEDATA($element);
    }

    $element = $this->get_binary;
    if ($element) {
	_dump_BINARY($element);
    }

    $element = $this->get_fits;
    if ($element) {
	_dump_FITS($element);
    }

    $indent--;

    return(1);

}

sub _dump_DEFINITIONS($)
{
    my($this) = @_;
    my(@elements, $element);

    print(' ' x $indent, "DEFINITIONS\n");
    $indent++;

    @elements = $this->get_coosys;
    if (@elements) {
	foreach $element (@elements) {
	    _dump_COOSYS($element);
	}
    }

    @elements = $this->get_param;
    if (@elements) {
	foreach $element (@elements) {
	    _dump_PARAM($element);
	}
    }

    $indent--;

    return(1);
}

sub _dump_DESCRIPTION($)
{
    my($this) = @_;
    my($pcdata);

    print(' ' x $indent, "DESCRIPTION\n");
    $indent++;

    $pcdata = $this->get;
    if ($pcdata) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);
}

sub _dump_FIELD($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);

    print(' ' x $indent, "FIELD\n");
    $indent++;

    $attribute = $this->get_ID;
    if (defined($attribute)) {
	_dump_attribute('ID', $attribute);
    }

    $attribute = $this->get_unit;
    if (defined($attribute)) {
	_dump_attribute('unit', $attribute);
    }

    $attribute = $this->get_datatype;
    if (defined($attribute)) {
	_dump_attribute('datatype', $attribute);
    }

    $attribute = $this->get_precision;
    if (defined($attribute)) {
	_dump_attribute('precision', $attribute);
    }

    $attribute = $this->get_width;
    if (defined($attribute)) {
	_dump_attribute('width', $attribute);
    }

    $attribute = $this->get_ref;
    if (defined($attribute)) {
	_dump_attribute('ref', $attribute);
    }

    $attribute = $this->get_name;
    if (defined($attribute)) {
	_dump_attribute('name', $attribute);
    }

    $attribute = $this->get_ucd;
    if (defined($attribute)) {
	_dump_attribute('ucd', $attribute);
    }

    $attribute = $this->get_arraysize;
    if (defined($attribute)) {
	_dump_attribute('arraysize', $attribute);
    }

    $attribute = $this->get_type;
    if (defined($attribute)) {
	_dump_attribute('type', $attribute);
    }

    $element = $this->get_description;
    if ($element) {
 	_dump_DESCRIPTION($element);
    }

    @elements = $this->get_values;
    if (@elements) {
 	foreach $element (@elements) {
 	    _dump_VALUES($element);
 	}
    }

    @elements = $this->get_link;
    if (@elements) {
 	foreach $element (@elements) {
 	    _dump_link($element);
 	}
    }

    $indent--;

    return(1);

}

sub _dump_FITS($)
{
    my($this) = @_;
    my($element, $attribute);

    print(' ' x $indent, "FITS\n");
    $indent++;

    $attribute = $this->get_extnum;
    if (defined($attribute)) {
	_dump_attribute('extnum', $attribute);
    }

    $element = $this->get_stream;
    if ($element) {
 	_dump_STREAM($element);
    }

    $indent--;

    return(1);

}

sub _dump_INFO($)
{
    my($this) = @_;
    my($attribute, $pcdata);

    print(' ' x $indent, "INFO\n");
    $indent++;

    $attribute = $this->get_ID;
    if (defined($attribute)) {
	_dump_attribute('ID', $attribute);
    }

    $attribute = $this->get_name;
    if (defined($attribute)) {
	_dump_attribute('name', $attribute);
    }

    $attribute = $this->get_value;
    if (defined($attribute)) {
	_dump_attribute('value', $attribute);
    }

    $pcdata = $this->get;
    if ($pcdata) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);
}

sub _dump_LINK($)
{
    my($this) = @_;
    my($attribute, $pcdata);

    print(' ' x $indent, "LINK\n");
    $indent++;

    $attribute = $this->get_ID;
    if (defined($attribute)) {
	_dump_attribute('ID', $attribute);
    }

    $attribute = $this->get_content_role;
    if (defined($attribute)) {
	_dump_attribute('content-role', $attribute);
    }

    $attribute = $this->get_content_type;
    if (defined($attribute)) {
	_dump_attribute('content-type', $attribute);
    }

    $attribute = $this->get_title;
    if (defined($attribute)) {
	_dump_attribute('title', $attribute);
    }

    $attribute = $this->get_value;
    if (defined($attribute)) {
	_dump_attribute('value', $attribute);
    }

    $attribute = $this->get_href;
    if (defined($attribute)) {
	_dump_attribute('href', $attribute);
    }

    $attribute = $this->get_gref;
    if (defined($attribute)) {
	_dump_attribute('gref', $attribute);
    }

    $attribute = $this->get_action;
    if (defined($attribute)) {
	_dump_attribute('action', $attribute);
    }

    $pcdata = $this->get;
    if ($pcdata) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);

}

sub _dump_MIN($)
{
    my($this) = @_;
    my($attribute, $pcdata);

    print(' ' x $indent, "MIN\n");
    $indent++;

    $attribute = $this->get_value;
    if (defined($attribute)) {
	_dump_attribute('value', $attribute);
    }

    $attribute = $this->get_inclusive;
    if (defined($attribute)) {
	_dump_attribute('inclusive', $attribute);
    }

    $pcdata = $this->get;
    if ($pcdata) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);

}

sub _dump_MAX($)
{
    my($this) = @_;
    my($attribute, $pcdata);

    print(' ' x $indent, "MAX\n");
    $indent++;

    $attribute = $this->get_value;
    if (defined($attribute)) {
	_dump_attribute('value', $attribute);
    }

    $attribute = $this->get_inclusive;
    if (defined($attribute)) {
	_dump_attribute('inclusive', $attribute);
    }

    $pcdata = $this->get;
    if ($pcdata) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);

}

sub _dump_OPTION($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);

    print(' ' x $indent, "OPTION\n");
    $indent++;

    $attribute = $this->get_name;
    if (defined($attribute)) {
	_dump_attribute('name', $attribute);
    }

    $attribute = $this->get_value;
    if (defined($attribute)) {
	_dump_attribute('value', $attribute);
    }

    @elements = $this->get_option;
    if (@elements) {
 	foreach $element (@elements) {
 	    _dump_OPTION($element);
 	}
    }

    $indent--;

    return(1);

}

sub _dump_PARAM($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);

    print(' ' x $indent, "PARAM\n");
    $indent++;

    $attribute = $this->get_ID;
    if (defined($attribute)) {
	_dump_attribute('ID', $attribute);
    }

    $attribute = $this->get_unit;
    if (defined($attribute)) {
	_dump_attribute('unit', $attribute);
    }

    $attribute = $this->get_datatype;
    if (defined($attribute)) {
	_dump_attribute('datatype', $attribute);
    }

    $attribute = $this->get_precision;
    if (defined($attribute)) {
	_dump_attribute('precision', $attribute);
    }

    $attribute = $this->get_width;
    if (defined($attribute)) {
	_dump_attribute('width', $attribute);
    }

    $attribute = $this->get_ref;
    if (defined($attribute)) {
	_dump_attribute('ref', $attribute);
    }

    $attribute = $this->get_name;
    if (defined($attribute)) {
	_dump_attribute('name', $attribute);
    }

    $attribute = $this->get_ucd;
    if (defined($attribute)) {
	_dump_attribute('ucd', $attribute);
    }

    $attribute = $this->get_value;
    if (defined($attribute)) {
	_dump_attribute('value', $attribute);
    }

    $attribute = $this->get_arraysize;
    if (defined($attribute)) {
	_dump_attribute('arraysize', $attribute);
    }

    $element = $this->get_description;
    if ($element) {
 	_dump_DESCRIPTION($element);
    }

    @elements = $this->get_values;
    if (@elements) {
 	foreach $element (@elements) {
 	    _dump_VALUES($element);
 	}
    }

    @elements = $this->get_link;
    if (@elements) {
 	foreach $element (@elements) {
 	    _dump_link($element);
 	}
    }

    $indent--;

    return(1);

}

sub _dump_RESOURCE($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);

    if ($dataonly) {

	@elements = $this->get_table;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_TABLE($element);
	    }
	}

	@elements = $this->get_resource;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_RESOURCE($element);
	    }
	}

    } else {

	print(' ' x $indent, "RESOURCE\n");
	$indent++;

	$attribute = $this->get_name;
	if (defined($attribute)) {
	    _dump_attribute('name', $attribute);
	}

	$attribute = $this->get_ID;
	if (defined($attribute)) {
	    _dump_attribute('ID', $attribute);
	}

	$attribute = $this->get_type;
	if (defined($attribute)) {
	    _dump_attribute('type', $attribute);
	}

	$element = $this->get_description;
	if ($element) {
	    _dump_DESCRIPTION($element);
	}

	@elements = $this->get_info;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_INFO($element);
	    }
	}

	@elements = $this->get_coosys;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_COOSYS($element);
	    }
	}

	@elements = $this->get_param;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_PARAM($element);
	    }
	}

	@elements = $this->get_link;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_LINK($element);
	    }
	}

	@elements = $this->get_table;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_TABLE($element);
	    }
	}

	@elements = $this->get_resource;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_RESOURCE($element);
	    }
	}

	$indent--;

    }

    return(1);

}

sub _dump_STREAM($)
{
    my($this) = @_;
    my($attribute, $pcdata);

    print(' ' x $indent, "STREAM\n");
    $indent++;

    $attribute = $this->get_type;
    if (defined($attribute)) {
	_dump_attribute('type', $attribute);
    }

    $attribute = $this->get_href;
    if (defined($attribute)) {
	_dump_attribute('href', $attribute);
    }

    $attribute = $this->get_actuate;
    if (defined($attribute)) {
	_dump_attribute('actuate', $attribute);
    }

    $attribute = $this->get_encoding;
    if (defined($attribute)) {
	_dump_attribute('encoding', $attribute);
    }

    $attribute = $this->get_expires;
    if (defined($attribute)) {
	_dump_attribute('expires', $attribute);
    }

    $attribute = $this->get_rights;
    if (defined($attribute)) {
	_dump_attribute('rights', $attribute);
    }

    $pcdata = $this->get;
    if (defined($pcdata)) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);
}

sub _dump_TABLE($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);
    my(@row);
    my($i);

    if (not @dumpcolumn_names) {
	@elements = $this->get_field;
	foreach $element (@elements) {
	    push(@dumpcolumn_names, $element->get_name);
	}
    }
    print("@dumpcolumn_names\n");
    @dumpcolumn_numbers = _MapColumnNamesToNumbers($this, @dumpcolumn_names);
    print("@dumpcolumn_numbers\n");

    if ($dataonly) {

	$i = 0;
	while (@row = $this->get_row($i)) {
	    print(join($sep, @row[@dumpcolumn_numbers]), "\n");
	    $i++;
	}

    } else {

	print(' ' x $indent, "TABLE\n");
	$indent++;

	$attribute = $this->get_ID;
	if (defined($attribute)) {
	    _dump_attribute('ID', $attribute);
	}

	$attribute = $this->get_name;
	if (defined($attribute)) {
	    _dump_attribute('name', $attribute);
	}

	$attribute = $this->get_ref;
	if (defined($attribute)) {
	    _dump_attribute('ref', $attribute);
	}

	$element = $this->get_description;
	if ($element) {
	    _dump_DESCRIPTION($element);
	}

	@elements = $this->get_field;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_FIELD($element);
	    }
	}

	@elements = $this->get_link;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_LINK($element);
	    }
	}

	$element = $this->get_data;
	if ($element) {
	    _dump_DATA($element);
	}

	$indent--;

    }

    return(1);

}

sub _dump_TABLEDATA($)
{
    my($this) = @_;
    my(@elements, $element);

    print(' ' x $indent, "TABLEDATA\n");
    $indent++;

    @elements = $this->get_tr;
    if (@elements) {
	foreach $element (@elements) {
	    _dump_TR($element);
	}
    }

    $indent--;

    return(1);

}

sub _dump_TD($)
{
    my($this) = @_;
    my($pcdata);

    print(' ' x $indent, "TD\n");
    $indent++;

    $pcdata = $this->get;
    if ($pcdata) {
	_dump_PCDATA($pcdata);
    }

    $indent--;

    return(1);

}

sub _dump_TR($)
{
    my($this) = @_;
    my(@elements, $element);

    print(' ' x $indent, "TR\n");
    $indent++;

    @elements = $this->get_td;
    if (@elements) {
	foreach $element (@elements) {
	    _dump_TD($element);
	}
    }

    $indent--;

    return(1);

}

sub _dump_VALUES($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);

    print(' ' x $indent, "VALUES\n");
    $indent++;

    $attribute = $this->get_ID;
    if (defined($attribute)) {
	_dump_attribute('ID', $attribute);
    }

    $attribute = $this->get_type;
    if (defined($attribute)) {
	_dump_attribute('type', $attribute);
    }

    $attribute = $this->get_null;
    if (defined($attribute)) {
	_dump_attribute('null', $attribute);
    }

    $attribute = $this->get_invalid;
    if (defined($attribute)) {
	_dump_attribute('invalid', $attribute);
    }

    $element = $this->get_min;
    if ($element) {
 	_dump_MIN($element);
    }

    $element = $this->get_max;
    if ($element) {
 	_dump_MAX($element);
    }

    @elements = $this->get_option;
    if (@elements) {
 	foreach $element (@elements) {
 	    _dump_OPTION($element);
 	}
    }

    $indent--;

    return(1);

}

sub _dump_VOTABLE($)
{
    my($this) = @_;
    my(@elements, $element, $attribute);

    if ($dataonly) {

	@elements = $this->get_resource;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_RESOURCE($element);
	    }
	}

    } else {

	print(' ' x $indent, "VOTABLE\n");
	$indent++;

	$attribute = $this->get_ID;
	if (defined($attribute)) {
	    _dump_attribute('ID', $attribute);
	}

	$attribute = $this->get_version;
	if (defined($attribute)) {
	    _dump_attribute('version', $attribute);
	}

	$element = $this->get_description;
	if ($element) {
	    _dump_DESCRIPTION($element);
	}

	@elements = $this->get_definitions;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_DEFINITIONS($element);
	    }
	}

	@elements = $this->get_info;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_INFO($element);
	    }
	}

	@elements = $this->get_resource;
	if (@elements) {
	    foreach $element (@elements) {
		_dump_RESOURCE($element);
	    }
	}

	$indent--;

    }

    return(1);
}

sub _dump_attribute($$)
{
    my($name, $value) = @_;

    print(' ' x $indent, "$name = '$value'\n");

    return(1);

}

sub _dump_PCDATA($)
{
    my($this) = @_;

    print(' ' x $indent, "PCDATA = '$this'\n");

    return(1);
}

#******************************************************************************

# _MapColumnNamesToNumbers()

sub _MapColumnNamesToNumbers($@)
{

    # Save inputs.
    my($this, @names) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # List of fields for this table.
    my(@fields);

    # List of column indices.
    my(@column_indices);

    # Loop counters.
    my($i, $j);

    #--------------------------------------------------------------------------

    # Fetch the fields.
    @fields = $this->get_field;
    if (not @fields) {
	warn('No FIELD elements found.');
	return(());
    }

    # Map each name to a column index.
    for ($i = 0; $i < @names; $i++) {
	for ($j = 0; $j < @fields; $j++) {
	    if ($fields[$j]->get_name eq $names[$i]) {
		$column_indices[$i] = $j;
		last;
	    }
	}
    }

    # Return the list of column numbers.
    return(@column_indices);

}
