<?

$fliepath = "xml/budovy";

$xml = "$fliepath.xml" ;
$xsd = "$fliepath.xsd" ;

$dom = new DOMDocument();
$dom->load($xml);

if ($dom->schemaValidate($xsd)) {
    echo json_encode(
        ["status" => TRUE, "message" => "XML je validní."]
    );
}
else {
    $errorMessages = "";
    foreach (libxml_get_errors() as $error) {
        $errorMeseges += $error->message;
    }
    echo json_encode(
        ["status" => FALSE, "message" => $errorMessageses]
    );
}


