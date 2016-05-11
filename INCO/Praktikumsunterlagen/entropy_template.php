<?php
// --------------------------------------------------------
//
// SHOW INFORMATION AND ENTROPY
//
// --------------------------------------------------------
//
// Filename:		entropy.php
// Author:		Juerg M. Stettbacher
//
// Version		2.0
// Creation date:	2007-03-19
// Last modified:	2012-02-28
//
// Target:		PHP 4/5 (Linux)
//
// --------------------------------------------------------
//
// Description:
// --------------
// Reads a data file and evaluates information and entropy.
//
// Usage:
// --------------
// > php entropy.php datafile
//
// --------------------------------------------------------


// --------------------------------------------------------
// Parameter:
// --------------------------------------------------------

// Name of data file:
$filename    = $argv[1];


// --------------------------------------------------------
// Show parameter:
// --------------------------------------------------------
print("\n");
print('------------------------'."\n");
print('Information and Entropy'."\n");
print('------------------------'."\n");
print("\n");
print('Data file (source S): "'.$filename.'"'."\n");
print("\n");


// --------------------------------------------------------
// Check if data file exists and open or exit:
// --------------------------------------------------------

// Check if data file exists:
if (!file_exists($filename)) {
	print('ERROR: data file does not exist.'."\n");
	print('Please supply valid filename as command line parameter.'."\n");
	print("\n");
	print('------------------------'."\n");
	exit;
} else {
	print('Data file exists.'."\n");
}

// Open data file:
print('Opening data file.'."\n");
$handle = fopen($filename, 'r');


// --------------------------------------------------------
// Build hostogram ($counts):
// --------------------------------------------------------

// Data loop:
print('Entering data loop.'."\n");
$length = 0;          // Number of valid symbols.
$counts = array();    // Histogram.
while(!feof($handle)) {
	
	// Read a symbol from file:
	$x = fgetc($handle);
	
	// Check if this is a valid symbol:
	if ($x >= ' ') {

// ########################################################
//
// Fill in data analysis here.
//
// ########################################################

	}
}

// Close file again:
print('Closing data file.'."\n");
fclose($handle);
print('Number of symbols: '.$length."\n");


// --------------------------------------------------------
// Do some clean-ups:
// --------------------------------------------------------

// Convert ISO-Latin-1 keys to printable keys:
$iso_latin = array(228, 246, 252, 196, 214, 220);
$printable = array("ä", "ö", "ü", "Ä", "Ö", "Ü");
for ($k=0; $k<count($iso_latin); $k++) {

	// Only convert if the corresponding iso_latin key exists:
	if (isset($counts[chr($iso_latin[$k])])) {
		// Create a new array entry with printable key:
		$counts[$printable[$k]] = $counts[chr($iso_latin[$k])];
		// Remove array entry with iso_latin key:
		unset($counts[chr($iso_latin[$k])]);
	}
}

// Sort array keys:
ksort($counts);


// --------------------------------------------------------
// Print character histogram:
// --------------------------------------------------------

print("\n");
print('Statistics:'."\n");
foreach($counts as $symbol=>$n) {

	print("\t".'"'.$symbol.'": '.$n.' ('.round($n*100/$length,4).' %)'."\n");
}


// --------------------------------------------------------
// Information and entropy:
// --------------------------------------------------------

// ########################################################
//
// Fill in information and entropy output here.
//
// ########################################################


// --------------------------------------------------------
// All done:
// --------------------------------------------------------

print('Done.'."\n");
print('------------------------'."\n");


// --------------------------------------------------------
// --------------------------------------------------------
?>
