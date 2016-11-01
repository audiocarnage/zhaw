<?php
// ========================================================
//
// (N,K) Block Codes
//
// --------------------------------------------------------
//
// Filename:		block.php
// Author:		Juerg M. Stettbacher
//
// Version		1.00
// Creation date:	2013-06-12
// Last modified:	2013-06-12
//
// Target:		PHP 4/5 (Linux)
//
// --------------------------------------------------------
//
// Description:
// --------------
// Reads an input bit string of length K from the command
// line and generates the Block Code.
// The script also reads an error vector of length N from
// the command line, applies the error to the Block Code
// and tries to decode.
//
// NOTE: Bit vectors are implemented as arrays. Matrices
// are implemented as arrays of arrays (i. e. vectors of
// vectors. Vectors are row-vectors. Indices in arrays
// start at zero. Index zero corresponds to the first
// vector element.
//
// Usage:
// --------------
// > php block.php input_vector error_vector
//
// input_vector and error_vector are simply sequences of
// '0' and '1'.
// ========================================================


// ========================================================
// Intro:
// ========================================================
print("\n");
print('------------------------------------------------'."\n");
print('(7,4) Block Codes'."\n");
print('------------------------------------------------'."\n");
print("\n");


// ========================================================
// Some helper functions:
// ========================================================

// ........................................................
// Convert an input string to a binary array:
// ........................................................
function str_to_bin_array($str) {
	// Initialize an empty array:
	$out = array();
	// Parse through all characters of string:
	for ($k=0; $k<strlen($str); $k++) {
		
		// Add the element to the output array
		// if it is a valid binary value.
		if ($str[$k] == '0') {
			$out[] = 0;
		} elseif ($str[$k] == '1') {
			$out[] = 1;
		} else {
			// This character is not valid: 
			print("WARNING: character '".$str[$k]."' skipped in str_to_bin_array().\n");
		}
	}
	return($out);
}


// ........................................................
// Add two bits:
// ........................................................
function bit_add($a, $b) {
	// Default return value:
	$result = 0;
	// Two cases for a result of 1 (1+0=1, 0+1=1):
	if ( (($a == 1) and ($b == 0)) or
	     (($a == 0) and ($b == 1)) ) {
		$result = 1;
	}
	return($result);
}


// ........................................................
// Multiply two bits:
// ........................................................
function bit_mul($a, $b) {
	// Default return value:
	$result = 0;
	// One case for a result of 1 (1*1=1):
	if (($a == 1) and ($b == 1)) {
		$result = 1;
	}
	return($result);
}


// ........................................................
// Add bit-vectors:
// ........................................................
function bit_vector_add($v1, $v2) {
	// Check dimensions:
	if (count($v1) != count($v2)) {
		print("ERROR: vector dimensions do not match in bit_vector_add().\n");
		exit;
	}
	// Default return value:
	$result = array();
	// Parse through all vector elements:
	for ($k=0; $k<count($v1); $k++) {
		$result[$k] = bit_add($v1[$k], $v2[$k]);
	}
	return($result);
}


// ........................................................
// Multiply bit-vector with bit-matrix:
// ........................................................
function bit_vector_matrix_mul($v, $m) {
	// Check dimensions:
	if (count($v) != count($m)) {
		print("ERROR: vector and matrix dimensions do not match in bit_vector_matrix_mul().\n");
		exit;
	}
	// Default return value:
	$result = array();
	// Parse through colums of matrix:
	for ($k=0; $k<count($m[1]); $k++) {
// ############################################################################
// ############################################################################
// Insert your code here.
// ############################################################################
// ############################################################################
	}
	return($result);
}


// ........................................................
// Convert a bit-vector to a decimal number:
// ........................................................
function bit_vector_to_dec($v) {
	// Default return value:
	$result = 0;
	for ($k=0; $k<count($v); $k++) {
		$result = 2*$result+$v[$k];
	}
	return($result);
}


// ........................................................
// Print a vector:
// ........................................................
function bit_vector_print($v) {
	for ($k=0; $k<count($v); $k++) {
		print($v[$k]);
	}
}


// ========================================================
// Set up some parameters:
// ========================================================

// (N,K)
$K   = 4;
$N   = 7;

// ........................................................
// Extract input vector and error vector:
// ........................................................
if ($argc < 2) {
	print("ERROR: not enough parameters (".$argc.").\n");
	print("Two command-line parameters are required.\n");
	exit;
}
$raw_input = $argv[1];
$raw_error = $argv[2];
$x         = str_to_bin_array($raw_input);
$e         = str_to_bin_array($raw_error);
// Check if length is ok:
if (count($x) != $K) {
	print("ERROR: input vector x does not have length ".$K.".\n");
	exit;
}
if (count($e) != $N) {
	print("ERROR: error vector e does not have length ".$N.".\n");
	exit;
}
print("Command-line parameters:\n");
print("    Input vector: ");
bit_vector_print($x);
print("\n");
print("    Error vector: ");
bit_vector_print($e);
print("\n");	
print("\n");


// ........................................................
// Some local definitions:
// ........................................................

// Generator matrix:
$G   = array(
		array(1, 0, 0, 0, 1, 0, 1),
		array(0, 1, 0, 0, 1, 1, 0),
		array(0, 0, 1, 0, 1, 1, 1),
		array(0, 0, 0, 1, 0, 1, 1)
);
print("Generator matrix:\n");
for ($k=0; $k<count($G); $k++) {
	print("    |");
	for ($n=0; $n<count($G[$k]); $n++) {
		print(" ".$G[$k][$n]);
	}
	print(" |\n");
 }
print("\n");

// Parity check matrix:
$H   = array(
		array(1, 0, 1),
		array(1, 1, 0),
		array(1, 1, 1),
		array(0, 1, 1),
		array(1, 0, 0),
		array(0, 1, 0),
		array(0, 0, 1)
);
print("Parity check matrix:\n");
for ($k=0; $k<count($H); $k++) {
	print("    |");
	for ($n=0; $n<count($H[$k]); $n++) {
		print(" ".$H[$k][$n]);
	}
	print(" |\n");
 }
print("\n");


// ========================================================
// Encoder:
// ========================================================
// Get code y:
// ############################################################################
// ############################################################################
// Insert your code here.
// $y = ...
// ############################################################################
// ############################################################################
print("Encoder:\n");
print("    Input vector x  : ");
bit_vector_print($x);
print("\n");
print("    Code y          : ");
bit_vector_print($y);
print("\n");
print("\n");


// ========================================================
// Channel:
// ========================================================
print("Channel:\n");
print("    Error vector    : ");
bit_vector_print($e);
print("\n");
print("\n");


// ========================================================
// Decoder:
// ========================================================
// Get bit pattern at receiver:
$yy = bit_vector_add($y, $e);
print("Decoder:\n");
print("    Received pattern: ");
bit_vector_print($yy);
print("\n");

// Syndrom:
// ############################################################################
// ############################################################################
// Insert your code here.
// $s  = ...
// ############################################################################
// ############################################################################
print("    Syndrom         : ");
bit_vector_print($s);
print(" (".bit_vector_to_dec($s).")\n");

// Mapping of syndrom to most probable bit-errors:
$map = array(
// ############################################################################
// ############################################################################
// Insert your code here.
// Mapping of syndroms to estimated error.
// ############################################################################
// ############################################################################
);

// Error correction:
$ee  = $map[bit_vector_to_dec($s)];
$yyy = bit_vector_add($yy, $ee);
print("    Error correction: ");
bit_vector_print($ee);
print("\n");
print("    Corr. pattern   : ");
bit_vector_print($yyy);
print("\n");

// Decoding of systematic code:
$xx = array();
// ############################################################################
// ############################################################################
// Insert your code here
// ############################################################################
// ############################################################################
print("    Decoded pattern : ");
bit_vector_print($xx);
print("\n");
print("\n");


// ========================================================
// All done:
// ========================================================
print('Done.'."\n");
print('------------------------------------------------'."\n");


// ========================================================
// ========================================================
?>