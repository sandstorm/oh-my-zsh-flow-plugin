<?php

$flow3Help = file_get_contents('php://stdin');
$flow3Help = str_replace('* ', '  ', $flow3Help);

$results = array();
foreach (preg_split('/^  (?=\w)/m', $flow3Help) as $singleLine) {
	if (strlen(trim($singleLine)) === 0) continue;
		// Collapse superfluous whitespace
	$singleLine = preg_replace('/\s+/', ' ', $singleLine);
	$tmp = explode(' ', $singleLine);
	$command = array_shift($tmp);
	$explanation = implode(' ', $tmp);

	$results[] = sprintf('"%s:%s"', str_replace(':', '\:', $command), trim($explanation));
}

echo sprintf('cmdlist=(%s)', implode(' ', $results));
?>