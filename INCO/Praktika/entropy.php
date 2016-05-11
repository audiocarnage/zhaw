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
// Check if data file exists:if (!file_exists($filename)) {
	print('ERROR: data file does not exist.'."\n");
	print('Please supply valid filename as command line parameter.'."\n");
	print("\n");
	print('------------------------'."\n");
	exit;
} else {
	print('Data file exists.'."\n");
}
// Open data file:print('Opening data file.'."\n");$handle = fopen($filename, 'r');
// --------------------------------------------------------
// Build histogram ($counts):
// --------------------------------------------------------
// Data loop
print('Entering data loop.'."\n");
$length = 0;          // Number of valid symbols.
$counts = array();    // Histogram.
while(!feof($handle)) {
	// Read a symbol from file:
	$x = fgetc($handle);
	// Check if this is a valid symbol:
	if ($x >= ' ') {		$length++;		if (!isset($counts[$x])) {			$counts[$x] = 1;		} else {			$counts[$x]++;		}
	}
}
// Close file again:
print('Closing data file.'."\n");
fclose($handle);
print('Number of symbols: '.$length."\n");
// --------------------------------------------------------
// Do some clean-ups:
// --------------------------------------------------------// Convert ISO-Latin-1 keys to printable keys:
$iso_latin = array(228, 246, 252, 196, 214, 220);
$printable = array("ä", "ö", "ü", "Ä", "Ö", "Ü");
for ($k=0; $k<count($iso_latin); $k++) {
	// Only convert if the corresponding iso_latin key exists:	if (isset($counts[chr($iso_latin[$k])])) {
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
print('Statistics:'."\n");$probability = array();
foreach($counts as $symbol => $n) {	$probability[$symbol] = $n/$length;	print("\t".'"'.$symbol.'": '.$n.' ('.round($probability[$symbol]*100,4).' %)'."\n");
}
// --------------------------------------------------------
// Information and entropy:
// --------------------------------------------------------print("\n\n".'Information per symbol:'."\n");$information = array();$values = array();foreach($counts as $symbol => $n) {	$information[$symbol] = log(1/$probability[$symbol], 2);	$values[$symbol] = log(1/$probability[$symbol], 2);}array_multisort($values, SORT_ASC, $information);foreach($values as $symbol => $n) {	print("\t".'"'.$symbol.'": ('.round($information[$symbol], 4).' bit)'."\n");}print("\n\n".'Entropy of source:'."\n");$entropy=0;foreach($counts as $symbol => $n) {	$entropy += $information[$symbol] * $probability[$symbol];}print(round($entropy, 4). ' bit / symbol');

// --------------------------------------------------------
// All done:
// --------------------------------------------------------
print("\n\n".'Done.'."\n");
print('------------------------'."\n");
?>