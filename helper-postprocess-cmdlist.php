<?php

$flowhelp = file_get_contents('php://stdin');
$flowhelp = str_replace('* ', '  ', $flowhelp);

$results = array();
foreach (preg_split('/^  (?=\w)/m', $flowhelp) as $singleLine) {
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