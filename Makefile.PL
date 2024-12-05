use ExtUtils::MakeMaker;

# Write the Makefile.
WriteMakefile(
	      'NAME' => 'Astro::VO::VOTable',
	      'VERSION_FROM' => 'lib/Astro/VO/VOTable.pm',
	      'PREREQ_PM' => {},
	      'ABSTRACT_FROM' => 'lib/Astro/VO/VOTable.pm',
	      'AUTHOR' => 'Eric Winter <Eric.L.Winter.1@gsfc.nasa.gov>',
	      );
