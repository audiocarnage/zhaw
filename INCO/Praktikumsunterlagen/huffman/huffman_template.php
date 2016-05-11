<?php
// --------------------------------------------------------
//
// Huffman Encoder
//
// --------------------------------------------------------
//
// Filename:		huffman.php
// Author:		Juerg M. Stettbacher
//
// Version		2.01
// Creation date:	2007-03-19
// Last modified:	2013-03-04
//
// Target:		PHP 4/5 (Linux)
//
// --------------------------------------------------------
//
// Description:
// --------------
// Reads a data file and generates a Huffman code.
//
// Usage:
// --------------
// > php huffman.php datafile
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
print('Huffman Encode'."\n");
print('------------------------'."\n");
print("\n");
print("Data file (source S): '".$filename."'\n");
print("\n");


// --------------------------------------------------------
// Open data file:
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
print("Opening data file.\n");
$handle = fopen($filename, 'r');


// --------------------------------------------------------
// Read all symbols from file and count each symbol:
// --------------------------------------------------------

print('Entering data loop.'."\n");
$length = 0;         // Total length of entire symbol stream.
$counts = array();   // Holds the count for each symbol.
while (!feof($handle)) {
	
	// Read a symbol from file:
	$x = fgetc($handle);
	
	// Check if this is a valid symbol:
	if ($x >= ' ') {
		$length++;
	
		// Build statistics:
		if (!isset($counts[$x])) {
			// If symbol does not yet exist in histogram:
			$counts[$x] = 1;
		} else {
			// If the symbol is already present in histogram:
			$counts[$x]++;
		}
	}
}

// Close file again:
print('Closing data file.'."\n");
fclose($handle);
print('Number of symbols: '.$length."\n");


// --------------------------------------------------------
// Do some clean-ups:
// --------------------------------------------------------

// Sort array values from lowest to highest:
asort($counts);


// --------------------------------------------------------
// Print character histogram:
// --------------------------------------------------------

print("\n");
print('Statistics:'."\n");
foreach($counts as $symbol => $n) {

	print("\t'".char_convert($symbol)."': ".$n." (".round($n*100/$length,4)." %)"."\n");
}


// --------------------------------------------------------
// Build Huffman code:
// --------------------------------------------------------

// Setup helper arrays:
$tree  = array();   // Holds the branches of the Huffman tree.
$codes = array();   // Holds the code for each symbol and the code length.
foreach ($counts as $symbol => $count) {
	// Create a Huffman tree branche for each symbol.
	// Initialize tree branches with the number of occurences for each symbol.
	$tree["$symbol"]  = $count;
	// The codes array is two-dimensional.
	// Initialize an emtpy code and length zero for each symbol.
	$codes["$symbol"] = array("code" => "", "length" => 0);
}

// Build Huffman tree:
echo "\nTree building:\n";
while (count($tree) > 1) {


	// ####################################################################
	//
	// Build the Huffman tree here:
	// - Find the two keys of branches with smallest counts in tree.
	// - Merge the two branches with smalles count in tree.
	// - Note that the keys for each branch list all the symbols covered
	//   by the branch.
	// - Update code and code length for each symbol found in the keys
	//   combined before.
	//
	// ####################################################################


	// Debug output (if required):
	echo "\n\tSymbols to combine: '".char_convert($i1)."' and '".char_convert($i2)."'.\n";
	foreach ($tree as $symbol => $count) {
		echo "\t'".char_convert($symbol)."' ==> count = ".$count."\n";
	}
	echo "\t(press return)";
	fgets(STDIN);
}


// --------------------------------------------------------
// Print Huffman codes:
// --------------------------------------------------------
print("\n");
print('Huffman codes:'."\n");
ksort($codes);
foreach($codes as $symbol=>$n) {
	//print("\t".'"'.$symbol.'": '.$n["code"]."\t\t"." (length ".$n["length"]." bit)"."\n");
	printf("\t'%s': %20s \t (length %2d bits)\n", char_convert($symbol), $n["code"], $n["length"]);
}
printf("Total %d\n\n", count($codes));


// --------------------------------------------------------
// All done:
// --------------------------------------------------------
print('Done.'."\n");
print('------------------------'."\n");



// Convert ISO-Latin-1 keys to printable keys:
function char_convert($ch) {

	$out = "";

	$iso_latin = array(228, 246, 252, 196, 214, 220);
	$printable = array("ä", "ö", "ü", "Ä", "Ö", "Ü");

	// Do for all characters in string $ch:
	for ($k = 0; $k < strlen($ch); $k++) {

		// Is $ch in the $iso_latin array?
		$n = array_search(ord($ch[$k]), $iso_latin);

		// If it is in the array:
		if ($n !== false) {
			$out = $out.$printable[$n];
		} else {
			$out = $out.$ch[$k];
		}
	}

	return($out);
}

?>
