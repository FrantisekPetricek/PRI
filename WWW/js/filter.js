document.addEventListener("DOMContentLoaded", function () {
  const budovaFilter = document.getElementById("budovaFilter");
  const typFilter = document.getElementById("typFilter");
  const podlaziFilter = document.getElementById("podlaziFilter");
  const searchInput = document.getElementById("searchInput");

  const updateVisibility = () => {
    const selectedBudova = budovaFilter.value.toLowerCase();
    const selectedTyp = typFilter.value.toLowerCase();
    const selectedPodlazi = podlaziFilter.value;
    const searchText = searchInput.value.trim().toLowerCase();

    const budovy = document.querySelectorAll(".budova");

    budovy.forEach((budova) => {
      const budovaKod = budova.getAttribute("data-kod").toLowerCase();
      const mistnosti = budova.querySelectorAll(".mistnost");

      let anyVisible = false;

      mistnosti.forEach((mistnost) => {
        const typ = mistnost.getAttribute("data-typ").toLowerCase();
        const podlazi = mistnost.getAttribute("data-podlazi");
        const kod = mistnost.getAttribute("data-kod").toLowerCase();

        const matchesBudova = !selectedBudova || selectedBudova === budovaKod;
        const matchesTyp = !selectedTyp || selectedTyp === typ;
        const matchesPodlazi = !selectedPodlazi || selectedPodlazi === podlazi;
        const matchesSearch = !searchText || kod.includes(searchText);

        const isVisible = matchesBudova && matchesTyp && matchesPodlazi && matchesSearch;

        mistnost.style.display = isVisible ? "block" : "none";

        if (isVisible) anyVisible = true;
      });

      budova.style.display = anyVisible ? "block" : "none";
    });
  };

  budovaFilter.addEventListener("change", updateVisibility);
  typFilter.addEventListener("change", updateVisibility);
  podlaziFilter.addEventListener("change", updateVisibility);
  searchInput.addEventListener("input", updateVisibility);

  updateVisibility(); // inicializace
});
