<?php
require_once 'db.php';


if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $id_bud = $_POST["id_bud"];
    $id_typ = $_POST["id_typ"];
    $podlazi = $_POST["podlazi"];

    if (dbInsertData($id_bud, $id_typ, $podlazi)) {
        header("Location: addData.php?success=1");
        exit;
    } else{
        header("Location: addData.php?success=0");
        exit;
    }
}

if (isset($_GET['success'])) {
    $zprava = "<p id = 'messPositive'>Místnost byla úspěšně vložena.</p>";
}else if(isset($_GET['success']) === 0){
    $zprava = "<p id = 'messNegative'>Chyba při vkládání místnosti.</p>";
}

$conn = dbConnect();

$budovy = $conn->query("SELECT id, nazev FROM budovy");
$typy = $conn->query("SELECT id, nazev FROM mistnosti_typ");

$conn->close();
?>

<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="UTF-8">
    <title>Přidat místnost</title>
    <link rel="stylesheet" href="css/addData.css">
    <link rel="stylesheet" href="css/navbar.css">
</head>
<body>
    <nav class="navbar">
        <ul>
            <li><a href="/index.php">Home</a></li>
            <li><a href="/displayData.php">Zobrazit data</a></li>
            <li><a href="/addData.php">Přidat data</a></li>
        </ul>
    </nav>

    <div class="form-container">
        <h2>Přidat novou místnost</h2>

        <form method="POST" action="addData.php">
            <label for="id_bud">Budova:</label>
            <select name="id_bud" required>
                <option value="">-- Vyberte budovu --</option>
                <?php while ($row = $budovy->fetch_assoc()): ?>
                    <option value="<?= $row['id'] ?>"><?= htmlspecialchars($row['nazev']) ?></option>
                <?php endwhile; ?>
            </select>

            <label for="id_typ">Typ místnosti:</label>
            <select name="id_typ" required>
                <option value="">-- Vyberte typ --</option>
                <?php while ($row = $typy->fetch_assoc()): ?>
                    <option value="<?= $row['id'] ?>"><?= htmlspecialchars($row['nazev']) ?></option>
                <?php endwhile; ?>
            </select>

            <label for="podlazi">Podlaží:</label>
            <input type="number" name="podlazi" required>

            <input type="submit" value="Přidat místnost">
        </form>
         <? if (isset($zprava)) echo $zprava; ?>
    </div>
</body>
</html>
