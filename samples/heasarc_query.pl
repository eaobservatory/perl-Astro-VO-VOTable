#!/Home/lhea3/elwinter/bin/perl -w

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

heasarc_query.pl - Query a HEASARC database

=head1 SYNOPSIS

heasarc_query.pl [--constraint=string] [--debug] [--help] [--labels]
[--output_file=filename] [--output_format=format] [--registry=filename]
[--sep=s] [--verbose] [--version] [--warn] [--xmldir=path]
table col1 [col2 ...]

where:

--constraint=string - Use 'string' as a SQL constraint for the query.
--debug - Turn on debugging output.
--help - Display a help message describing command-line options.
--labels - Print column labels above the output.
--output_file=filename - Send query results to file 'filename'.
--output_format=format - Produce results in the specified format. The
  currently supported formats are: 'binary', 'csv', 'fits',
  'votable_binary','votable_fits', and 'votable_tabledata'.
--registry=filename - Use 'filename' as the name of the file
  containing information for the database registry. Default is
  'CLASSX_ROOT/lib/databases.dat'.
--sep=s - Use the string 's' as the column separator; default is the
  pipe character ('|').
--verbose - Turn on verbose output.
--version - Print the program version number.
--warn - Print warning messages for recoverable errors.
--xmldir=path - Specify the path to the directory containing XML
  files. The default is CLASSX_ROOT/xml.
table - Name of the HEASARC table to query (_without_ the 'heasarc_'
prefix).
coln - Name of column to extract. At least one column must be
specified.

=head1 DESCRIPTION

This program queries the specified HEASARC database and prints the
contents of the specified columns for all records. No output ordering
is performed.

=head1 WARNINGS

=over 4

=item *

Due to incompatibilities in legacy code, this program invokes the
older program. C<heasarc_sql.pl>, to fetch the data from the HEASARC
database.

=back

=head1 SEE ALSO

C<heasarc_sql.pl>

=head1 VERSION

$Id: heasarc_query.pl,v 1.1.1.14 2002/06/06 19:30:06 elwinter Exp $

=head1 AUTHOR

Eric Winter (elwinter@milkyway.gsfc.nasa.gov)

=cut

#------------------------------------------------------------------------------

# Revision history

# $Log: heasarc_query.pl,v $
# Revision 1.1.1.14  2002/06/06  19:30:06  elwinter
# Changed field pruning to ensure proper ordering.
#
# Revision 1.1.1.13  2002/05/30  14:07:45  elwinter
# Overhauled interface and internals.
#
# Revision 1.1.1.12  2002/04/25  11:21:00  elwinter
# Added call to dispose method.
#
# Revision 1.1.1.11  2002/04/24  17:40:08  elwinter
# Fixed documentation typo.
#
# Revision 1.1.1.10  2002/04/24  17:26:13  elwinter
# Added optional filename to --xmlout option.
#
# Revision 1.1.1.9  2002/04/24  17:01:56  elwinter
# Added initial support for --constraint option.
#
# Revision 1.1.1.8  2002/04/24  16:27:33  elwinter
# First version to suppoer --xmlout option.
#
# Revision 1.1.1.7  2002/04/24  13:20:59  elwinter
# Modified to open pipe to heasarc_sql.pl.
#
# Revision 1.1.1.6  2002/02/20  18:41:10  elwinter
# Removed table/column checks.
#
# Revision 1.1.1.5  2002/02/06  17:39:10  elwinter
# Fixed bug with undefined output fields.
#
# Revision 1.1.1.4  2002/02/05  20:51:32  elwinter
# Added support for RASSBSC table.
#
# Revision 1.1.1.3  2001/12/10  18:52:50  elwinter
# Changed location of default registry fuile.
#
# Revision 1.1.1.2  2001/11/23  21:08:00  elwinter
# Updated to cover RASSFSC, ROSATSRC, and WGACAT tables.
#
# Revision 1.1.1.1  2001/11/23  20:12:14  elwinter
# Placeholder for new branch.
#
# Revision 1.1  2001/11/23  19:12:39  elwinter
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
use FileHandle;
use Getopt::Long;

# Third-party modules.

# Project modules.
use VOTABLE::Document;

#------------------------------------------------------------------------------

# Constants

# Program version
use constant VERSION => '$Revision: 1.1.1.14 $ ';

# Default format for query results.
use constant DEFAULT_OUTPUT_FORMAT => 'csv';

# Name of default database registry file.
use constant DEFAULT_REGISTRY_FILE => "$ENV{'CLASSX_ROOT'}/lib/databases.dat";

# Default column separator character.
use constant DEFAULT_COLUMN_SEPARATOR => '|';

# Path to default XML directory.
use constant DEFAULT_XML_DIR => "$ENV{'CLASSX_ROOT'}/xml";

# Prefix for names of HEASARC tables.
use constant HEASARC_TABLE_NAME_PREFIX => 'heasarc_';

# List of valid output formats.
my(@VALID_OUTPUT_FORMATS) = ('binary', 'csv', 'fits', 'votable_binary',
			     'votable_fits', 'votable_tabledata');

# Hash to map VOTABLE datatype attributes (from FIELD elements) to
# equivalent format codes for the Perl subroutines pack() and
# unpack(), and the corresponding byte sizes.
my(%type_map) =
    (
     boolean      => {code => 'a', size => 1},
     char         => {code => 'a', size => 1},
     double       => {code => 'd', size => 8},
     float        => {code => 'f', size => 4},
     int          => {code => 'l', size => 4},
     long         => {code => 'q', size => 8},
     short        => {code => 's', size => 2},
     unsignedByte => {code => 'C', size => 1},
     );

#------------------------------------------------------------------------------

# Globals

# Array containing SQL constraint strings for the query.
my(@constraints);

# Set this flag to generate debugging output.
my($debug);

# Set this flag if the user wants help.
my($help);

# Set this flag to print labels for the output columns.
my($labels);

# Name of output file.
my($output_file);

# Output format.
my($output_format) = DEFAULT_OUTPUT_FORMAT;

# Path to database registry file.
my($registry) = DEFAULT_REGISTRY_FILE;

# String to use as the column separator.
my($sep) = DEFAULT_COLUMN_SEPARATOR;

# Set this flag for verbose operation.
my($verbose);

# Set this flag to print the program version number.
my($version);

# Set this flag to print warning messages.
my($warn);

# Set to the path to the XML directory.
my($xmldir) = DEFAULT_XML_DIR;

# List of option specifiers, and hash to hold mapping of command-line
# options and arguments for GetOptions().
my(@optlist) =
    (
     'constraint=s@',
     'debug',
     'help',
     'labels',
     'output_file=s',
     'output_format=s',
     'registry=s',
     'sep=s',
     'verbose',
     'version',
     'warn',
     'xmldir=s',
     );
my(%optctl) =
    (
     'constraint'    => \@constraints,
     'debug'         => \$debug,
     'help'          => \$help,
     'labels'        => \$labels,
     'output_file'   => \$output_file,
     'output_format' => \$output_format,
     'registry'      => \$registry,
     'sep'           => \$sep,
     'verbose'       => \$verbose,
     'version'       => \$version,
     'warn'          => \$warn,
     'xmldir'        => \$xmldir,
     );

#------------------------------------------------------------------------------

# Subroutine declarations

sub _GetHelp();
sub _GetVersion();
sub _ValidOptions();
sub _MainLoop();
sub _PruneVOTABLE($$);

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
Usage: heasarc_query.pl [--constraint=string] [--debug] [--help] [--labels]
[--output_file=filename] [--output_format=format] [--registry=filename]
[--sep=s] [--verbose] [--version] [--warn] [--xmldir=path]
table col1 [col2 ...]

where:

--constraint=string - Use 'string' as a SQL constraint for the query.
--debug - Turn on debugging output.
--help - Display a help message describing command-line options.
--labels - Print column labels above the output.
--output_file=filename - Send query results to file 'filename'.
--output_format=format - Produce results in the specified format. The
  currently supported formats are: 'binary', 'csv', 'fits',
  'votable_binary','votable_fits', and 'votable_tabledata'.
--registry=filename - Use 'filename' as the name of the file
  containing information for the database registry. Default is
  'CLASSX_ROOT/lib/databases.dat'.
--sep=s - Use the string 's' as the column separator; default is the
  pipe character ('|').
--verbose - Turn on verbose output.
--version - Print the program version number.
--warn - Print warning messages for recoverable errors.
--xmldir=path - Specify the path to the directory containing XML
  files. The default is CLASSX_ROOT/xml.
table - Name of the HEASARC table to query (_without_ the 'heasarc_'
prefix).
coln - Name of column to extract. At least one column must be
specified.
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

    # Current column name.
    my($column_name);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # A valid database registry file must be specified.
    if (not defined($registry) or length($registry) == 0) {
 	warn('ERROR: A registry file must be specified!');
 	return(0);
    }

    # A valid column separator must be specified.
    if (not defined($sep) or length($sep) == 0) {
 	warn('ERROR: A column separator must be specified!');
 	return(0);
    }

    # A valid XML directory must be specified.
    if (not defined($xmldir) or length($xmldir) == 0) {
 	warn('ERROR: A XML directory must be specified!');
 	return(0);
    }

    # Make sure a table name was specified.
    if (not defined($ARGV[0]) or length($ARGV[0]) == 0) {
	warn('ERROR: A table name must be specified!');
	return(0);
    }

    # Make sure at least one column name was specified.
    if (scalar(@ARGV) - 1 == 0) {
 	warn('ERROR: At least one column name must be specified!');
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

    # Local variables.

    # Name of table to query.
    my($table_name);

    # Array of names of columns to extract.
    my(@column_names);

    # Path to XML template file for current table.
    my($xml_template_file);

    # Reference to VOTABLE::Document object to hold the XML data.
    my($votable_document);

    # Format string for pack() subroutine.
    my($pack_format);

    # Path to external file for votable_binary output format. Also
    # used as the value of the href attribute for the STREAM element.
    my($href);

    # Temporary string to hold list of column names in SQL format.
    my($column_names_sql);

    # String to hold the SQL command.
    my($sql);

    # Temporary string to hold the constraints in SQL form.
    my($constraint_sql);

    # String to hold external command strings.
    my($cmd);

    # Filehandles to write data output.
    my($outfh);
    my($outfh2);

    # Filehandle object to process input from external command.
    my($infh);

    # String containing current row of query results.
    my($row);

    # Array of field values for current row.
    my(@fields);

    # String to hold output row.
    my($output_row);

    my($votable_resource);
    my($votable_table);
    my($votable_data);
    my($votable_tabledata);
    my($votable_tr, @votable_tr);
    my($votable_td, @votable_td);
    my($votable_binary);
    my($votable_stream);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Command-line options are assumed to be previously validated by
    # _ValidOptions().

    # Save the name of the table to query.
    $table_name = shift(@ARGV);
    _dump('table_name', \$table_name) if ($debug);

    # Save the list of columns specified on the command line.
    @column_names = @ARGV;
    _dump('column_names', \@column_names) if ($debug);

    #--------------------------------------------------------------------------

    # Assemble the path to the XML template file for the current
    # table.
    $xml_template_file = "$xmldir/${table_name}.xml";
    _dump('xml_template_file', \$xml_template_file) if ($debug);

    # Read the XML template file for the specified table.
    print("Reading XML template file $xml_template_file.\n") if ($verbose);
    $votable_document =
	new_from_filename VOTABLE::Document $xml_template_file;
    if (not $votable_document) {
	warn("Unable to read $xml_template_file.");
	return(0);
    }

    # Prune the XML to remove FIELD elements not required by the
    # current query.
    print("Pruning unused FIELD elements from template.\n") if ($verbose);
    if (not _PruneVOTABLE($votable_document, \@column_names)) {
	warn('Unable to prune unused FIELD elements from VOTABLE.');
	return(0);
    }

    # Compute the packing format for the remaining fields.
    print("Computing packing format.\n") if ($verbose);
    $pack_format = _AssemblePackFormat($votable_document);
    if (not $pack_format) {
	warn('Unable to compute packing format.');
	return(0);
    }
    _dump('pack_format', \$pack_format) if ($debug);

    # Compute the name of the external VOTABLE file if needed.
    if ($output_format eq 'votable_binary') {
	$href = $output_file;
	$href =~ s/\..*//;
	$href .= '.bin';
	_dump('href', \$href) if ($debug);
    }

    #--------------------------------------------------------------------------

    print("Assembling query.\n") if ($verbose);

    # Assemble the desired column names as a SQL fragment.
    $column_names_sql = join(',', @column_names);
    _dump('column_name_sql', \$column_names_sql) if ($debug);

    # Prepend the prefix to the table name.
    $table_name = HEASARC_TABLE_NAME_PREFIX . $table_name;
    _dump('table_name', \$table_name) if ($debug);

    # Assemble the basic query SQL.
    $sql = "select $column_names_sql from $table_name";
    _dump('sql', \$sql) if ($debug);

    # If there are any constraints, append them to the query string.
    if (@constraints) {
	$constraint_sql = join(' and ', @constraints);
	_dump('constraint_sql', \$constraint_sql) if ($debug);
	$sql .= " where $constraint_sql";
	_dump('sql', \$sql) if ($debug);
    }

    # Set up the query command.
    $cmd = "heasarc_sql.pl --registry=$registry --sep='|' '$sql'";
    _dump('cmd', \$cmd) if ($debug);

    #--------------------------------------------------------------------------

    # Create the output file if required.
    if (defined($output_file)) {
	$outfh = new FileHandle ">$output_file";
	if (not $outfh) {
	    warn("Unable to create file $output_file.");
	    return(0);
	}
    } else {
	$outfh = *STDOUT;
    }

    # Create the output file to hold external data for the
    # votable_binary format.
    if ($href) {
	$outfh2 = new FileHandle ">$href";
	if (not $outfh2) {
	    warn("Unable to create file $href.");
	    return(0);
	}
    }

    # Create a filehandle object to manage the input from the external
    # query command.
    print("Executing query '$cmd'.\n") if ($verbose);
    $infh = new FileHandle "$cmd |";
    if (not $infh) {
	warn("Unable to execute '$cmd'.");
	return(0);
    }

    # Print the results header, if desired.
    if ($labels) {
 	print(join($sep, @column_names), "\n");
    }

    # Process one line at a time.
    print("Processing query results.\n") if ($verbose);
    while ($row = <$infh>) {

	# Remove the trailing newline.
	chomp($row);

	# Split the fields for this row.
	@fields = split(/\|/, $row);

	# Process the results based on the specified format.
	if ($output_format eq 'csv') {
  	    $output_row = join($sep, @fields);
  	    $outfh->print("$output_row\n");
	} elsif ($output_format eq 'binary') {
	    $output_row = pack($pack_format, @fields);
	    $outfh->print($output_row);
	} elsif ($output_format eq 'fits') {
	    warn("Unsupported output format: $output_format!");
	    return(0);
	} elsif ($output_format eq 'votable_tabledata') {
	    $votable_tr = new VOTABLE::TR or die;
	    @votable_td = ();
	    for ($i = 0; $i < @fields; $i++) {
		$votable_td[$i] = new VOTABLE::TD $fields[$i] or die;
	    }
	    $votable_tr->set_td(@votable_td) or die;
	    push(@votable_tr, $votable_tr);
	} elsif ($output_format eq 'votable_binary') {
	    $output_row = pack($pack_format, @fields);
	    $outfh2->print($output_row);
	} elsif ($output_format eq 'votable_fits') {
	    warn("Unsupported output format: $output_format!");
	    return(0);
  	} else {
	    warn("Unsupported output format: $output_format!");
	    return(0);
	}

    }

    # Close the input pipe from the external query command.
    if (not $infh->close) {
	warn("Unable to close pipe for $cmd.");
	return(0);
    }

    # If needed, set and print the VOTABLE data.
    if ($output_format eq 'votable_tabledata') {
	$votable_resource = ($votable_document->get_resource)[0] or die;
	$votable_table = ($votable_resource->get_table)[0] or die;
	$votable_data = new VOTABLE::DATA or die;
	$votable_table->set_data($votable_data) or die;
	$votable_tabledata = new VOTABLE::TABLEDATA or die;
	$votable_data->set_tabledata($votable_tabledata) or die;
	$votable_tabledata->set_tr(@votable_tr) or die;
	$votable_document->print($outfh);
    } elsif ($output_format eq 'votable_binary') {
	$votable_resource = ($votable_document->get_resource)[0] or die;
	$votable_table = ($votable_resource->get_table)[0] or die;
	$votable_data = new VOTABLE::DATA or die;
	$votable_table->set_data($votable_data) or die;
	$votable_binary = new VOTABLE::BINARY or die;
	$votable_data->set_binary($votable_binary) or die;
	$votable_stream = new VOTABLE::STREAM or die;
	$votable_binary->set_stream($votable_stream) or die;
	$votable_stream->set_href("file://$href") or die;
	$votable_document->print($outfh);
    }

    # Close the output files.
    if (not $outfh->close) {
	warn("Unable to close file $output_file!");
	return(0);
    }
    if ($outfh2 and not $outfh2->close) {
	warn("Unable to close file $href!");
	return(0);
    }

    # Delete the FileHandle objects.
    undef $infh;
    undef $outfh;
    undef $outfh2;

    #--------------------------------------------------------------------------

    _dump('Ending ' . (caller(0))[3]) if ($debug);

    # Return normally.
    return(1);

}

#******************************************************************************

# _PruneVOTABLE()

# Subroutine to prune from the VOTABLE all FIELD elements not
# specified by the caller. This subroutine assumes that the
# VOTABLE::Document object was already successfully read from a file,
# and is therefore assumed to be valid.

sub _PruneVOTABLE($$)
{

    _dump('Starting ' . (caller(0))[3]) if ($debug);

    #--------------------------------------------------------------------------

    # Save arguments.
    my($votable_document, $fields_to_keep) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Array of RESOURCE element objects for the current document. The
    # XML templates used in this program should have only one RESOURCE
    # element.
    my(@votable_resource);

    # Array of TABLE element objects for the current RESOURCE. The XML
    # templates used in this program should have only one TABLE
    # element.
    my(@votable_table);

    # Array of FIELD element objects for the current TABLE.
    my(@votable_field);

    # Array of FIELD element objects to keep.
    my(@votable_field_to_keep);

    # Name of the current FIELD element.
    my($field_name);

    # Current FIELD element.
    my($votable_field);

    #--------------------------------------------------------------------------

    # Get a list of all RESOURCE elements in the document (there
    # should only be one RESOURCE element).
    @votable_resource = $votable_document->get_resource or die;

    # Get a list of all TABLE elements in the RESOURCE (there should
    # only be one TABLE element).
    @votable_table = $votable_resource[0]->get_table or die;

    # Get a list of all FIELD elements in the the TABLE.
    @votable_field = $votable_table[0]->get_field or die;

    # Remove each FIELD element that is not required, and put the
    # remainder in the order specified by the user.
    @votable_field_to_keep = ();
    foreach $field_name (@$fields_to_keep) {
	foreach $votable_field (@votable_field) {
	    if ($field_name eq $votable_field->get_name) {
		push(@votable_field_to_keep, $votable_field);
		last;
	    }
	}
    }

    # Set the FIELD elements for the TABLE.
    if (not $votable_table[0]->set_field(@votable_field_to_keep)) {
	warn('Unable to set new FIELD elements!');
	return(0);
    }

    #--------------------------------------------------------------------------

    _dump('Ending ' . (caller(0))[3]) if ($debug);

    # Return normally.
    return(1);

}

#******************************************************************************

# _AssemblePackFormat()

sub _AssemblePackFormat($)
{

    _dump('Starting ' . (caller(0))[3]) if ($debug);

    #--------------------------------------------------------------------------

    # Save arguments.
    my($votable_document) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # VOTABLE objects needed to get to the FIELD elements.
    my($votable_resource);
    my($votable_table);
    my(@votable_field);
    my($votable_field);

    # String to hold the pack format.
    my($pack_format);

    #--------------------------------------------------------------------------

    # Find the first RESOURCE element.
    $votable_resource = ($votable_document->get_resource)[0];
    if (not $votable_resource) {
	warn('ERROR: Not VOTABLE RESOURCE!');
	return(undef);
    }

    # Find the first TABLE element.
    $votable_table = ($votable_resource->get_table)[0];
    if (not $votable_table) {
	warn('ERROR: Not VOTABLE TABLE!');
	return(undef);
    }

    # Find the list of FIELD elements.
    @votable_field = $votable_table->get_field;
    if (not @votable_field) {
	warn('ERROR: No VOTABLE FIELD!');
	return(undef);
    }

    # Map each FIELD element datatype to its corresponding pack format
    # code.
    $pack_format = '';
    foreach $votable_field (@votable_field) {
	$pack_format .= $type_map{$votable_field->get_datatype}{code};
    }

    #--------------------------------------------------------------------------

    _dump('Ending ' . (caller(0))[3]) if ($debug);

    # Return the packing format.
    return($pack_format);

}
