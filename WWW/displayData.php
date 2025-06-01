<?php
$xml = new DOMDocument();
$xml->load("xml/budovy.xml");

$xsl = new DOMDocument();
$xsl->load("xml/budovy.xsl");

$proc = new XSLTProcessor();
$proc->importStylesheet($xsl);

echo $proc->transformToXML($xml);
?>
