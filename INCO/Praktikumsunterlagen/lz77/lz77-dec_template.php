<?php
// --------------------------------------------------------
//
// LZ-77 Decoder
//
// --------------------------------------------------------
//
// Filename:		lz77-dec.php
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
// Reads a LZ-77 encoded data file and decodes it.
//
// Usage:
// --------------
// > php lz77-dec.php datafile
//
// --------------------------------------------------------


// --------------------------------------------------------
// Parameter:
// --------------------------------------------------------

// Name of data file:
$filename     = $argv[1];
$filename_out = $filename.".dec";


// --------------------------------------------------------
// Show parameter:
// --------------------------------------------------------
print("\n");
print('------------------------'."\n");
print('LZ-77 Decoder'."\n");
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


//Read buffer configuration from input file:
fscanf($handle_in, "%d",  $preview_buf_size);
fscanf($handle_in, "%d", $search_buf_size);

echo "Preview buffer is ". $preview_buf_size. " bytes long.\n";
echo "Search buffer is ". $search_buf_size. " bytes long.\n";


// Initialize buffers:
$search_buf = "";
for ($k=0; $k<$search_buf_size; $k++) {
	$search_buf = $search_buf."\0";
}


// Data loop:
print('Entering data loop.'."\n");

$tokens = 0;
while (!feof($handle_in)) {

	$tokens++;

	// ####################################################################
	//
	// Process LZ77 tokens and reconstruct original message:
	// - Read a token from file.
	// - Check if reading a token was successful.
	// - Process token by searching the substring in actual search buffer.
	// - Generate output string.
	// - Update search buffer.
	//
	// ####################################################################

	// Read a token and check for successful reading:
	// $cnt  = 0;
	// $cnt += fscanf($handle_in, "%d", $match_pos);
	// $cnt += fscanf($handle_in, "%d", $match_size);
	// $char = fgetc($handle_in);
	// Read to end of line:
	// fscanf($handle_in, "%s", $null);

}

// Close file again:
print('Closing data file.'."\n");
fclose($handle_in);
fclose($handle_out);
print('Number of tokens: '.$tokens."\n");


// --------------------------------------------------------
// All done:
// --------------------------------------------------------
print('Done.'."\n");
print('------------------------'."\n");


?>
