<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index</title>
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="js/index.js"></script>

</head>
<body>

    <nav class="navbar">
        <ul>
            <li><a href="/index.php">Home</a></li>
            <li><a href="/displayData.php">Zobrazit data</a></li>
            <li><a href="/addData.php">Přidat data</a></li>
        </ul>
    </nav>

    <h1>Správa Budov</h1>
    <button onclick="loadData()">Načti data z databáze</button>
    <div id="loadMessage"></div>

    <button onclick="validateData()">Zvaliduj data</button>
    <div id="validMessage"></div>



</body>
</html>