<?php

function dbConnect() {
    $host = 'db';
    $user = 'root';
    $pass = 'root';
    $db = 'sprava_mistnosti';

    $conn = new mysqli($host, $user, $pass, $db);

    if ($conn->connect_error) {
        die("Připojení selhalo: " . $conn->connect_error);
    }

    return $conn;
}

function dbLoadData() {
    $conn = dbConnect();

    $sql = "SELECT b.id AS budova_id, b.nazev AS budova_nazev, b.kod AS budova_kod,
                   m.id AS mistnost_id, m.kod AS mistnost_kod, m.podlazi AS podlazi,
                   m_t.id AS typ_id, m_t.nazev AS typ_nazev
            FROM mistnosti AS m
            JOIN mistnosti_typ AS m_t ON m.id_typ = m_t.id
            JOIN budovy AS b ON m.id_bud = b.id;";

    $vysledek = $conn->query($sql);
    $data = [];

    if ($vysledek) {
        while ($row = $vysledek->fetch_assoc()) {
            $data[] = $row;
        }
    }

    $conn->close();
    return $data;
}

function dbInsertData($id_bud, $id_typ, $podlazi) {
    $conn = dbConnect();

    $stmt = $conn->prepare("INSERT INTO mistnosti (id_bud, id_typ, podlazi) VALUES (?, ?, ?)");
    if (!$stmt) {
        die("Příprava selhala: " . $conn->error);
    }

    $stmt->bind_param("iii", $id_bud, $id_typ, $podlazi);

    $success = $stmt->execute();
    $stmt->close();
    $conn->close();

    return $success;
}

?>
