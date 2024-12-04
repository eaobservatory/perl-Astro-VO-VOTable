#!/Home/lhea3/elwinter/bin/perl -w

# Standard modules.
use FileHandle;

# Project modules.
use VOTABLE::DESCRIPTION;
use VOTABLE::Document;

#------------------------------------------------------------------------------

# Subroutine declarations.

#------------------------------------------------------------------------------

# Begin main program.
{

    # Local variables.

    # Name of file to write to.
    my($filename) = $ARGV[0];
    $filename or die 'Must provide a filename!';

    # New VOTABLE::Document object.
    my($votable);

    # Data description.
    my($description) = 'Sample data from WGACAT';

    # Describe the data fields.
    my(%fields) =
	(
	 ra =>
	 {width => '8', precision => '4', unit => 'degree',
	  datatype => 'double', ucd => 'POS_EQ_RA_MAIN'},
	 dec =>
	 {width => '8', precision => '4', unit => 'degree',
	  datatype => 'double', ucd => 'POS_EQ_DEC_MAIN'},
	 count_rate =>
	 {width => '10', precision => '5', unit => 'count.second-1',
	  datatype => 'double', ucd => 'PHOT_COUNT-RATE_X'},
	 );

    # RA, DEC, and photon count rate from current record.
    my($ra, $dec, $count_rate);

    # Array of data records, as hashes.
    my(@records);

    # VOTABLE::DESCRIPTION element object for the data.
    my($votable_description);

    # VOTABLE::RESOURCE element object for the data table.
    my($votable_resource);

    # VOTABLE::TABLE element object for the data table.
    my($votable_table);

    # VOTABLE::FIELD element object for the current field, and all of
    # them.
    my($votable_field);
    my(@votable_fields);

    # VOTABLE::DATA element object for the data table.
    my($votable_data);

    # VOTABLE::TABLEDATA element object for the data table.
    my($votable_tabledata);

    # Current TR element, and all of them.
    my($votable_tr);
    my(@votable_tr);

    # Current set of TD elements for the current TR element.
    my(@votable_td);

    # Filehandle for output.
    my($fh);

    # Loop counter.
    my($i);

    #--------------------------------------------------------------------------

    # Read in the test data.
    while (<DATA>) {
	chomp;
	($ra, $dec, $count_rate) = split '\|';
	push(@records, {ra => $ra, dec => $dec, count_rate => $count_rate});
    }

    #--------------------------------------------------------------------------

    # Create the new VOTABLE::Document object.
    $votable = new VOTABLE::Document or die;

    # Create a DESCRIPTION element for the document, and assign it to
    # the document.
    $votable_description = new VOTABLE::DESCRIPTION $description or die;
    $votable->set_description($votable_description) or die;

    # Create a RESOURCE element to hold the data, and assign it to the
    # document.
    $votable_resource = new VOTABLE::RESOURCE or die;
    $votable->set_resource(($votable_resource)) or die;

    # Create a TABLE element to hold the data, and assign it to the
    # RESOURCE.
    $votable_table = new VOTABLE::TABLE or die;
    $votable_resource->set_table(($votable_table)) or die;

    # Create FIELD elements for the table.
    foreach $field (keys %fields) {
	$votable_field = new VOTABLE::FIELD undef,
	    name => $field, %{$fields{$field}} or die;
	push(@votable_fields, $votable_field);
    }
    $votable_table->set_field(@votable_fields) or die;

    # Create a DATA element to hold the data, and assign it to the
    # TABLE.
    $votable_data = new VOTABLE::DATA or die;
    $votable_table->set_data($votable_data) or die;

    # Create a TABLEDATA element to hold the data, and assign it to
    # the DATA.
    $votable_tabledata = new VOTABLE::TABLEDATA or die;
    $votable_data->set_tabledata($votable_tabledata) or die;

    # Finally, create a TR element for each record, and a TD element
    # for each field. Then assign the TRs to the TABLEDATA.
    for ($i = 0; $i < @records; $i++) {
	$votable_tr = new VOTABLE::TR or die;
	@votable_td = ();
	$votable_td[0] = new VOTABLE::TD $records[$i]{ra} or die;
	$votable_td[1] = new VOTABLE::TD $records[$i]{dec} or die;
	$votable_td[2] = new VOTABLE::TD $records[$i]{count_rate} or die;
	$votable_tr->set_td(@votable_td) or die; 
	push(@votable_tr, $votable_tr);
    }
    $votable_tabledata->set_tr(@votable_tr) or die;

    # At this point we have assembled the complete document, so print
    # it.
    $fh = new FileHandle ">$filename" or die;
    $votable->print($fh);

}

#******************************************************************************

# Data beyond the __END__ token is read using the DATA filehandle.
__END__
151.4658333302|-85.50288888878|46
150.8241666635|-85.27752777735|332
150.9270833333|-85.16391666624|43
151.929583327|-85.07694444444|999
149.998333327|-85.07311111132|22
151.0016666667|-84.82680555556|54
154.4912500064|-84.7319722218|40
152.0320833325|-84.57444444444|59
96.71916666031|-82.4844722222|504
95.81375000079|-82.46013888889|323
92.27666666706|-82.39950000021|288
94.09416666826|-82.32619444423|139
90.51875|-82.28288888931|97
90.08916666508|-82.25|216
95.33166666826|-82.19611111111|128
92.93916667302|-82.17602777799|75
90.59916666349|-82.16944444444|221
90.57666666508|-82.15950000021|53
97.73874999682|-82.11216666645|297
96.69750000636|-82.07330555545|206
90.76958333254|-82.04188888868|97
90.49458333651|-81.97844444487|101
95.93999999364|-81.95508333312|105
88.36708333492|-81.94783333355|1420
88.36708333492|-81.94647222201|3197
96.26041666667|-81.94413888931|146
94.61458333333|-81.9403611109|84
91.62041666508|-81.85955555598|20
91.61500000159|-81.85902777778|47
91.97666667302|-81.83588888884|13
92.94291666349|-81.83163888931|59
92.92875000636|-81.82458333333|206
96.34749999841|-81.81744444443|41
96.15458332698|-81.80641666677|131
92.04375|-81.79108333323|32
92.03291666706|-81.78774999989|116
94.77000000079|-81.75652777778|30
90.57208333015|-81.72036111116|162
94.34000000159|-81.71222222222|46
95.80041666826|-81.68247222265|92
92.39291666349|-81.64155555566|16
94.07958333492|-81.63736111111|40
94.08375000159|-81.63569444444|109
93.10166666508|-81.60461111122|72
97.16416667302|-81.57775000042|258
92.18166666031|-81.56158333355|49
90.79041666587|-81.53988888899|48
93.56291666826|-81.46130555577|73
93.57624999682|-81.45758333312|112
92.04500000079|-81.42647222201|44
92.12041666508|-81.38644444439|128
93.54333333174|-81.36672222222|209
94.725|-81.2778611109|277
85.78458333413|-81.25883333312|407
85.03041666746|-81.06777777778|156
84.89083333015|-80.86641666624|69
87.03375000159|-80.76980555561|156
83.18166666031|-80.75799999979|81
84.77291666667|-80.71658333355|45
84.04874999921|-80.70780555566|33
85.18291667302|-80.70402777778|52
84.15375000636|-80.66016666624|33
85.29583333333|-80.65455555545|41
84.49708333015|-80.58261111153|18
83.35250000159|-80.49044444455|24
84.28916666508|-80.46794444442|75
83.10458333492|-80.45438888894|44
84.0074999998|-80.35891666624|34
83.78875000079|-80.34502777735|73
83.49833332698|-80.33344444445|36
84.77625000079|-80.32866666688|34
82.71750000318|-80.32797222243|44
85.5087499996|-80.25980555534|303
83.20041666031|-80.24136111101|41
82.11791666349|-80.17033333328|241
85.41541666985|-80.14372222265|91
85.32291666667|-80.06319444444|95
85.54458333254|-80.05466666645|182
177.8979166667|-79.98522222228|445
84.41958333651|-79.96113888847|179
176.8816666683|-79.90711111122|402
181.926666673|-79.87494444423|763
178.1458333333|-79.79294444402|249
182.5408333341|-79.78091666645|468
181.2354166667|-79.7469722218|247
180.389166673|-79.70808333344|126
180.8237500032|-79.68272222201|134
176.4445833365|-79.65833333333|311
181.4762499968|-79.64163888878|203
176.8070833325|-79.5775|236
176.7912499984|-79.52844444487|227
180.5866666635|-79.52386111101|72
179.5595833341|-79.51886111114|15
179.5658333341|-79.51669444444|48
181.6237500032|-79.51025000042|181
182.1595833302|-79.47533333355|228
178.9487500032|-79.43272222201|52
181.4225000064|-79.39419444402|136
179.2362500032|-79.38291666667|30
180.4362500032|-79.3591111109|104
