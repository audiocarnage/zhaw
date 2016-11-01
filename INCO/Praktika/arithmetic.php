<?php
// ========================================================
//
// Arithmetic Encoder for {A, E, I, O, U, D}
//
// --------------------------------------------------------
//
// Filename:		arithmetic.php
// Author:		Juerg M. Stettbacher
//
// Version		1.00
// Creation date:	2013-06-05
// Last modified:	2013-06-05
//
// Target:		PHP 4/5 (Linux)
//
// --------------------------------------------------------
//
// Description:
// --------------
// Reads a data file and generates an arithmetic code.
//
// Usage:
// --------------
// > php arithmetic.php datafile
//
// ========================================================


// ========================================================
// Intro:
// ========================================================
print("\n");
print('------------------------------------------------'."\n");
print('Arithmetic Encode'."\n");
print('------------------------------------------------'."\n");
print("\n");


// ========================================================
// Set up some parameters:
// ========================================================

// ........................................................
// Extract name of data file:
// ........................................................
$filename    = $argv[1];
// Print name of data file:
print("Data file from command line: '".$filename."'.\n");
print("\n");


// ........................................................
// Valid symbols and histogram counts:
// ........................................................
// Note: the first symbol will be arranged on top of the interval 0 to 1.
$data = array("A"=>81.0, "E"=>127.0, "I"=>70.0, "U"=>75.0, " "=>28.0, "D"=>42.0);
// Print valid symbols and histogram:
print("Symbol table (histogram):\n");
foreach ($data as $key=>$val) {
	print("\t'" . $key . "'\t (" . $val . ")\n");
}
print("\n");
// Clear local variables:
unset($key, $val);


// ........................................................
// Replace symbol histogram counts with probabilities:
// ........................................................
$p_sum = 0.0;
foreach ($data as $key=>$val) {
	// Add all histogram data:
	$p_sum = $p_sum + $val;
}
foreach ($data as $key=>$val) {
	// Normalize all histogram data:
	$data["$key"] = $data["$key"] / $p_sum;
}
// Print valid symbols and probabilities:
print("Symbol table (histogram):\n");
foreach ($data as $key=>$val) {
	print("\t'" . $key . "'\t (" . $val . ")\n");
}
print("\n");
// Clear local variables:
unset($p_sum, $key, $val);


// ........................................................
// Obtain cumulative probabilities:
// ........................................................
$cump  = array();
$cnt   = 1;
foreach ($data as $key=>$val) {
	$cump["$key"] = array_sum(array_slice($data, $cnt, count($data)-$cnt));
	$cnt = $cnt + 1;
}
print("Symbol table (cumulative probabilities):\n");
foreach ($cump as $key=>$val) {
	print("\t'" . $key . "'\t (" . $val . ")\n");
}
print("\n");
// Clear local variables:
unset($cnt, $key, $val);

// ========================================================
// Open data file:
// ========================================================
printf("Checking data file.\n");

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
print("\n");


// ========================================================
// Read all symbols from file and build arithmetic code:
// ========================================================
print('Entering encoder loop.'."\n");
$string      = "";
$count       = 0;
$upper_limit = 1.0;
$lower_limit = 0.0;
$new_lower_limit = 0;
$new_upper_limit = 0;

while (!feof($handle)) {
	$sym = fgetc($handle);
	$count = $count + 1;
	print("\n");
	print("--- Symbol no. " . $count . " read.\n");

	// ................................................
	// Check if $sym is a valid symbol:
	// ................................................
	if ($sym < ' ') {
		// Symbol $sym is a control character like 'horizontal tab' (HT),
		// 'line feed' (LF), 'carriage return' (CR), 'end of file' (EOF),
		// 'escape' (ESC) or others. Note in the ASCII character table
		// all these control characters are below ' ' (SPACE).
		// We simply ignore these symbols and don't do anything.
		print("    Symbol is a control character.\n");
		print("    Symbol ignored.\n");
	} else if (array_search($sym, array_keys($data), "strict") === FALSE) {
		// Symbol $sym is not a key in the $data array. Hence it is
		// not considered a valid symbol in this encoder.
		// We simply ignore these symbols and only print a warning.
		print("    Symbol '" . $sym . "' (0x" . dechex(ord($sym)) . ")\n");
		print("    WARNING: invalid input symbol found!\n");
		print("    WARNING: invalid input symbol dropped!\n");
	} else {
		// Symbol $sym is a valid symbol for this encoder.
		// Start processing:
		print("    Symbol '" . $sym . "' (0x" . dechex(ord($sym)) . ").\n");
		print("    Symbol is valid.\n");

		// Update string:
		$string = $string . $sym;
		print("    Present data string: '" . $string . "'.\n");

		$new_upper_limit = $lower_limit + (($cump[$sym] + $data[$sym]) * ($upper_limit - $lower_limit));
		$new_lower_limit = $lower_limit + ($cump[$sym] * ($upper_limit - $lower_limit));
		$lower_limit = $new_lower_limit;
		$upper_limit = $new_upper_limit;
		
		print("    Updated interval:\t [" . $lower_limit . " " . $upper_limit . "].\n");
	}
}
print("\n");
print("Encoder loop complete.\n");
// Clear local variables:
unset($sym, $count, $new_lower_limit, $new_upper_limit);


// ========================================================
// Close input file:
// ========================================================
print("Close data file.\n");
print("\n");
fclose($handle);


// ========================================================
// Summarize encoding results:
// ========================================================
print("Encoder output:\n");
$code  = ($lower_limit + $upper_limit) / 2;
$width = $upper_limit - $lower_limit;
print("    Message:  " . $string . "\n");
print("    Code:     " . $code   . "\n");
print("    Interval: " . $width  . "\n");
print("\n");
// Clear local variables:
$length = strlen($string);
unset($string, $width, $lower_limit, $upper_limit);


// ========================================================
// Decode:
// ========================================================
// Note we only use $code, $length, $data and $cump of the
// above variables.
print("Start decoder.\n");
print("Decode " . $length . " symbols.\n");


// ........................................................
// Set up some variables:
// ........................................................
$string      = "";
$count       = 0;
$upper_limit = 1.0;
$lower_limit = 0.0;
$cp          = $cump;

// ........................................................
// Repeat for all symbols:
// ........................................................
print("Entering decoder loop:\n");
print("Symbol table (cumulative probabilities):\n");
foreach ($cump as $key=>$val) {
	print("\t'" . $key . "'\t (" . $val . ")\n");
}
print("\n");
for ($k = 0; $k <= ($length-1); $k++) {

	// Update counter:
	$count = $count + 1;
	print("--- Decode symbol no. " . $count . ".\n");
	
	// Find symbol interval in which $code is located:
	foreach ($cp as $key=>$val) {
		// $cump contains the lower interval limit for each
		// symbol starting at top of interval. We store the
		// corresponding $key (symbol) as soon as the lower
		// limit ($val) is below $code and exit from the
		// foreach-loop:
		if ($val < $code) {
			// $code is between $val and the previous
			// symbol, which is above.
			$sym = $key;
			break;
		}
	}
	print("    Symbol is '" . $sym . "'.\n");

	// Update string:
	$string = $string . $sym;
	print("    Present data string: '" . $string . "'\n");

	// update cumulative probabilities:
	$new_lower_limit = $lower_limit + ($upper_limit - $lower_limit) * $cump[$sym];
	$new_upper_limit = $lower_limit + ($upper_limit - $lower_limit) * ($cump[$sym] + $data[$sym]);
	$lower_limit = $new_lower_limit;
	$upper_limit = $new_upper_limit;
	
	foreach ($cp as $key=>$val) {
		$cp[$key] = $cump[$key] * ($upper_limit - $lower_limit) + $lower_limit;
	}
	
	// Print updated interval data:
	print("    Updated interval:\t [" . $lower_limit . " " . $upper_limit . "].\n");
	//print("    Symbol table (lower interval limit):\n");
	//foreach ($cp as $key=>$val) {
		//print("    \t'" . $key . "'\t (" . $val . ")\n");
	//}
	print("\n");

}
print("Decoder loop complete.\n");
print("\n");
// Clear local variables:
unset($k, $key, $val, $sym, $new_lower_limit, $new_upper_limit);


// ========================================================
// Summarize decoding results:
// ========================================================
print("Decoder output:\n");
print("    String: '" . $string . "'\n");

print("\n");


// ========================================================
// All done:
// ========================================================
print('Done.'."\n");
print('------------------------------------------------'."\n");


// ========================================================
// ========================================================
?>
