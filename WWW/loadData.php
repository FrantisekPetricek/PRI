<?php
require_once 'db.php';
require_once 'dataToXML.php';

$data = dbLoadData();

header('Content-Type: application/json');

if(!empty($data)){
    $xml = dataToXml($data);
    if($xml){
        echo json_encode(
            ["status" => TRUE, "message" => "XML bylo vygenerováno"]
        );
    }
    else{
        echo json_encode(
            ["status" => FALSE, "message" => "Chyba při generování XML"]
        );
    }
}
else{
    echo json_encode(
        ["status" => FALSE, "message" => "Chyba při načítání dat z databáze"]
    );
}