function loadData() {
    fetch('loadData.php')
        .then(response => response.json())
        .then(data => {
            const messDiv = document.getElementById('loadMessage');
            messDiv.innerHTML = data.status
                ? data.message
                : data.message;
        })
        .catch(() => {
            document.getElementById('loadMessage').innerText = 'Nastala chyba při komunikaci se serverem.';
        });
}

function validateData(){
    fetch("validate.php")
        .then(response => response.json())
        .then(data => {
            const messDiv = document.getElementById('validMessage');
            messDiv.innerHTML = data.status
                ? data.message
                : data.message;
        })
        .catch(() => {
            document.getElementById('validMessage').innerText = 'Nastala chyba při komunikaci se serverem.';
        });
}
