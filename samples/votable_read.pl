#!/Home/lhea3/elwinter/bin/perl -w

# Standard modules.
require 'dumpvar.pl';
use FileHandle;

# Project modules.
use VOTABLE::Document;

#------------------------------------------------------------------------------

# Subroutine declarations.
sub print_BINARY($);
sub print_COOSYS($);
sub print_DATA($);
sub print_DEFINITIONS($);
sub print_DESCRIPTION($);
sub print_FIELD($);
sub print_FITS($);
sub print_INFO($);
sub print_LINK($);
sub print_MAX($);
sub print_MIN($);
sub print_OPTION($);
sub print_PARAM($);
sub print_RESOURCE($);
sub print_STREAM($);
sub print_TABLE($);
sub print_TABLEDATA($);
sub print_TD($);
sub print_TR($);
sub print_VALUES($);
sub print_VOTABLE($);

#------------------------------------------------------------------------------

# Begin main program.
{

    # Local variables.
    my($filename) = $ARGV[0];
    $filename or die 'Must provide a filename!';
    my($fh);
    my($votable);

    #--------------------------------------------------------------------------

    # Open an existing Vizier output file in VOTABLE format.
    $fh = new FileHandle $filename or die;

    # Parse the VOTABLE document.
    $votable = new VOTABLE::Document $fh or die;

    # Print the contents.
    print_VOTABLE($votable);

}

#------------------------------------------------------------------------------

# Subroutines to print each class of element.

sub print_BINARY($)
{
    my($this) = @_;
    my($votable_element);

    print("BINARY\n");

    # Elements
    if ($votable_element = $this->get_stream) {
	print_STREAM($votable_element);
    }

}

sub print_COOSYS($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("COOSYS\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_equinox) {
	print("equinox = $attribute_value\n");
    }
    if ($attribute_value = $this->get_epoch) {
	print("epoch = $attribute_value\n");
    }
    if ($attribute_value = $this->get_system) {
	print("system = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_DATA($)
{
    my($this) = @_;
    my($votable_element);

    print("DATA\n");

    # Elements
    if ($votable_element = $this->get_tabledata) {
	print_TABLEDATA($votable_element);
    }
    if ($votable_element = $this->get_binary) {
	print_BINARY($votable_element);
    }
    if ($votable_element = $this->get_fits) {
	print_FITS($votable_element);
    }

}

sub print_DEFINITIONS($)
{
    my($this) = @_;
    my(@votable_elements);
    my($i);

    print("DEFINITIONS\n");

    # Elements
    if (@votable_elements = $this->get_coosys) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_COOSYS($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_param) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_PARAM($votable_elements[$i]);
	}
    }

}

sub print_DESCRIPTION($)
{
    my($this) = @_;
    my($pcdata);

    print("DESCRIPTION\n");

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_FIELD($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($votable_element);
    my($i);

    print("PARAM\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_unit) {
	print("unit = $attribute_value\n");
    }
    if ($attribute_value = $this->get_datatype) {
	print("datatype = $attribute_value\n");
    }
    if ($attribute_value = $this->get_precision) {
	print("precision = $attribute_value\n");
    }
    if ($attribute_value = $this->get_width) {
	print("width = $attribute_value\n");
    }
    if ($attribute_value = $this->get_ref) {
	print("ref = $attribute_value\n");
    }
    if ($attribute_value = $this->get_name) {
	print("name = $attribute_value\n");
    }
    if ($attribute_value = $this->get_ucd) {
	print("ucd = $attribute_value\n");
    }
    if ($attribute_value = $this->get_arraysize) {
	print("arraysize = $attribute_value\n");
    }
    if ($attribute_value = $this->get_type) {
	print("type = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_description) {
	print_DESCRIPTION($votable_element);
    }
    if (@votable_elements = $this->get_values) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_VALUES($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_link) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_LINK($votable_elements[$i]);
	}
    }

}

sub print_FITS($)
{
    my($this) = @_;
    my($attribute_value);
    my($votable_element);

    print("FITS\n");

    # Attributes
    if ($attribute_value = $this->get_extnum) {
	print("extnum = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_stream) {
	print_STREAM($votable_element);
    }

}

sub print_INFO($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("INFO\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_name) {
	print("name = $attribute_value\n");
    }
    if ($attribute_value = $this->get_value) {
	print("value = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_LINK($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("LINK\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_content_role) {
	print("content-role = $attribute_value\n");
    }
    if ($attribute_value = $this->get_content_type) {
	print("content-type = $attribute_value\n");
    }
    if ($attribute_value = $this->get_title) {
	print("title = $attribute_value\n");
    }
    if ($attribute_value = $this->get_value) {
	print("value = $attribute_value\n");
    }
    if ($attribute_value = $this->get_href) {
	print("href = $attribute_value\n");
    }
    if ($attribute_value = $this->get_gref) {
	print("gref = $attribute_value\n");
    }
    if ($attribute_value = $this->get_action) {
	print("action = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_MAX($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("MAX\n");

    # Attributes
    if ($attribute_value = $this->get_value) {
	print("value = $attribute_value\n");
    }
    if ($attribute_value = $this->get_inclusive) {
	print("inclusive = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_MIN($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("MIN\n");

    # Attributes
    if ($attribute_value = $this->get_value) {
	print("value = $attribute_value\n");
    }
    if ($attribute_value = $this->get_inclusive) {
	print("inclusive = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_OPTION($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($i);

    print("OPTION\n");

    # Attributes
    if ($attribute_value = $this->get_name) {
	print("name = $attribute_value\n");
    }
    if ($attribute_value = $this->get_value) {
	print("value = $attribute_value\n");
    }

    # Elements
    if (@votable_elements = $this->get_option) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_OPTION($votable_elements[$i]);
	}
    }

}

sub print_PARAM($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($votable_element);
    my($i);

    print("PARAM\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_unit) {
	print("unit = $attribute_value\n");
    }
    if ($attribute_value = $this->get_datatype) {
	print("datatype = $attribute_value\n");
    }
    if ($attribute_value = $this->get_precision) {
	print("precision = $attribute_value\n");
    }
    if ($attribute_value = $this->get_width) {
	print("width = $attribute_value\n");
    }
    if ($attribute_value = $this->get_ref) {
	print("ref = $attribute_value\n");
    }
    if ($attribute_value = $this->get_name) {
	print("name = $attribute_value\n");
    }
    if ($attribute_value = $this->get_ucd) {
	print("ucd = $attribute_value\n");
    }
    if ($attribute_value = $this->get_value) {
	print("value = $attribute_value\n");
    }
    if ($attribute_value = $this->get_arraysize) {
	print("arraysize = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_description) {
	print_DESCRIPTION($votable_element);
    }
    if ($votable_element = $this->get_values) {
	print_VALUES($votable_element);
    }
    if (@votable_elements = $this->get_link) {
	print_LINK($votable_elements[$i]);
    }

}

sub print_RESOURCE($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($votable_element);
    my($i);

    print("RESOURCE\n");

    # Attributes
    if ($attribute_value = $this->get_name) {
	print("name = $attribute_value\n");
    }
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_type) {
	print("type = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_description) {
	print_DESCRIPTION($votable_element);
    }
    if (@votable_elements = $this->get_info) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_INFO($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_coosys) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_COOSYS($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_param) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_PARAM($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_link) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_LINK($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_table) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_TABLE($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_resource) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_RESOURCE($votable_elements[$i]);
	}
    }

}

sub print_STREAM($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("STREAM\n");

    # Attributes
    if ($attribute_value = $this->get_type) {
	print("type = $attribute_value\n");
    }
    if ($attribute_value = $this->get_href) {
	print("href = $attribute_value\n");
    }
    if ($attribute_value = $this->get_actuate) {
	print("actuate = $attribute_value\n");
    }
    if ($attribute_value = $this->get_encoding) {
	print("encoding = $attribute_value\n");
    }
    if ($attribute_value = $this->get_expires) {
	print("expires = $attribute_value\n");
    }
    if ($attribute_value = $this->get_rights) {
	print("rights = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_TABLE($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($votable_element);
    my($i);

    print("TABLE\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_name) {
	print("name = $attribute_value\n");
    }
    if ($attribute_value = $this->get_ref) {
	print("ref = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_description) {
	print_DESCRIPTION($votable_element);
    }
    if (@votable_elements = $this->get_link) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_LINK($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_field) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_FIELD($votable_elements[$i]);
	}
    }
    if ($votable_element = $this->get_data) {
	print_DATA($votable_element);
    }

}

sub print_TABLEDATA($)
{
    my($this) = @_;
    my(@votable_elements);
    my($i);

    print("TR\n");

    # Elements
    if (@votable_elements = $this->get_tr) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_TR($votable_elements[$i]);
	}
    }

}

sub print_TD($)
{
    my($this) = @_;
    my($attribute_value);
    my($pcdata);

    print("TD\n");

    # Attributes
    if ($attribute_value = $this->get_ref) {
	print("ref = $attribute_value\n");
    }

    # PCDATA
    if ($pcdata = $this->get) {
	print("PCDATA = $pcdata\n");
    }

}

sub print_TR($)
{
    my($this) = @_;
    my(@votable_elements);
    my($i);

    print("TR\n");

    # Elements
    if (@votable_elements = $this->get_td) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_TD($votable_elements[$i]);
	}
    }

}

sub print_VALUES($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($votable_element);
    my($i);

    print("VALUES\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_type) {
	print("type = $attribute_value\n");
    }
    if ($attribute_value = $this->get_null) {
	print("null = $attribute_value\n");
    }
    if ($attribute_value = $this->get_invalid) {
	print("invalid = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_min) {
	print_MIN($votable_element);
    }
    if ($votable_element = $this->get_max) {
	print_MAX($votable_element);
    }
    if (@votable_elements = $this->get_option) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_OPTION($votable_elements[$i]);
	}
    }

}

sub print_VOTABLE($)
{
    my($this) = @_;
    my($attribute_value);
    my(@votable_elements);
    my($votable_element);
    my($i);

    print("VOTABLE\n");

    # Attributes
    if ($attribute_value = $this->get_ID) {
	print("ID = $attribute_value\n");
    }
    if ($attribute_value = $this->get_version) {
	print("version = $attribute_value\n");
    }

    # Elements
    if ($votable_element = $this->get_description) {
	print_DESCRIPTION($votable_element);
    }
    if ($votable_element = $this->get_definitions) {
	print_DEFINITIONS($votable_element);
    }
    if (@votable_elements = $this->get_info) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_INFO($votable_elements[$i]);
	}
    }
    if (@votable_elements = $this->get_resource) {
	for ($i = 0; $i < @votable_elements; $i++) {
	    print_RESOURCE($votable_elements[$i]);
	}
    }

}
