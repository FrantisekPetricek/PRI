<?php
require_once "db.php";

function dataToXML($data) {
    $path = "xml/budovy.xml";

    $dom = new DOMDocument('1.0', 'UTF-8');
    $dom->formatOutput = true;

    $root = $dom->createElement('budovy');
    $dom->appendChild($root);

    $aktualniBudovaID = null;
    $budovaElement = null;

    foreach ($data as $radek) {
        if ($radek['budova_id'] !== $aktualniBudovaID) {
            $aktualniBudovaID = $radek['budova_id'];

            $budovaElement = $dom->createElement('budova');
            $budovaElement->setAttribute('id', $radek['budova_id']);

            $budovaElement->appendChild($dom->createElement('kod', htmlspecialchars($radek['budova_kod'])));
            $budovaElement->appendChild($dom->createElement('nazev', htmlspecialchars($radek['budova_nazev'])));
            $mistnostiElement = $dom->createElement('mistnosti');

            $budovaElement->appendChild($mistnostiElement);
            $root->appendChild($budovaElement);
        }

        $mistnost = $dom->createElement('mistnost');
        $mistnost->setAttribute('id', $radek['mistnost_id']);

        $mistnost->appendChild($dom->createElement('kod', $radek['mistnost_kod']));
        $mistnost->appendChild($dom->createElement('podlazi', $radek['podlazi']));

        $typ = $dom->createElement('typ');
        $typ->setAttribute('id', $radek['typ_id']);
        $typ->appendChild($dom->createElement('nazev', htmlspecialchars($radek['typ_nazev'])));
        $mistnost->appendChild($typ);

        $budovaElement->getElementsByTagName('mistnosti')->item(0)->appendChild($mistnost);
    }

    $dom->save($path);

    return $dom;
}


