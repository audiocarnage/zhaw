<?php
// --------------------------------------------------------
//
// LZ-77 Encoder
//
// --------------------------------------------------------
//
// Filename:		lz77-enc.php
// Author:		Juerg M. Stettbacher
//
// Version		1.0
// Creation date:	2012-03-27
// Last modified:	2013-03-18
//
// Target:		PHP 4/5 (Linux)
//
// --------------------------------------------------------
//
// Description:
// --------------
// Reads a data file and generates an LZ-77 encoded file.
//
// Usage:
// --------------
// > php lz77-enc.php datafile
//
// --------------------------------------------------------


// --------------------------------------------------------
// Parameter:
// --------------------------------------------------------

// Name of data file:
$filename     = $argv[1];
$filename_out = $filename.".lz77";

// Buffer configuration:
$preview_buf_size  = 32;
$search_buf_size   = 1024;


// --------------------------------------------------------
// Show parameter:
// --------------------------------------------------------
print("\n");
print('------------------------'."\n");
print('LZ-77 Encoder'."\n");
print('------------------------'."\n");
print("\n");
print("Input file (source S):  '".$filename."'\n");
print("Output file (source S): '".$filename_out."'\n");

print("\n");


// --------------------------------------------------------
// Open data files:
// --------------------------------------------------------

// Check if input data file exists:
if (!file_exists($filename)) {
	print('ERROR: input file does not exist.'."\n");
	print('Please supply valid filename as command line parameter.'."\n");
	print("\n");
	print('------------------------'."\n");
        exit;
} else {
	print('Input data file exists.'."\n");
}

// Open data file:
print("Opening data files.\n");
$handle_in  = fopen($filename, 'r');
$handle_out = fopen($filename_out, 'w');

fprintf($handle_out, "%d\n", $preview_buf_size);
fprintf($handle_out, "%d\n", $search_buf_size);

// Initialize buffers:
$search_buf = "";
$search_buf = str_pad($search_buf, $search_buf_size, "\0");

$preview_buf = "";
for ($k=0; $k<$preview_buf_size; $k++) {
	if (!feof($handle_in)) {
		$preview_buf = $preview_buf.fgetc($handle_in);
	} else {
		$preview_buf = $preview_buf."\0";
	}
}

// Data loop:
print('Entering data loop.'."\n");

$tokens = 0;
while ($preview_buf[0] != "\0") {

	$tokens++;

	// ####################################################################
	//
	// Build LZ77 tokens here:
	// - Search for matching substrings.
	//   Determine the length and the position of the matching substring
	//   in the search buffer.
	// - Write the token to the output file.
	// - Update search and preview buffers.
	//
	// ####################################################################

	// Write token to output file:
	// ---------------------------
	// fprintf($handle_out, "%d\n", ...);
	// fprintf($handle_out, "%d\n", ...);
	// fprintf($handle_out, "%s\n", ...);

}

// Close file again:
print('Closing data file.'."\n");
fclose($handle_in);
fclose($handle_out);
print('Number of tokens: '.$tokens."\n");


// --------------------------------------------------------
// Do some clean-ups:
// --------------------------------------------------------



// --------------------------------------------------------
// Print character histogram:
// --------------------------------------------------------


// --------------------------------------------------------
// All done:
// --------------------------------------------------------
print('Done.'."\n");
print('------------------------'."\n");

?>
