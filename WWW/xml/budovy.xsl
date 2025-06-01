<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Budovy a místnosti</title>
        <link rel="stylesheet" href="css/displayData.css"/>
        <link rel="stylesheet" href="css/navbar.css"/>
        <script src="js/filter.js" ></script>
      </head>
      <body>
        <nav class="navbar">
        <ul>
            <li><a href="/index.php">Home</a></li>
            <li><a href="/displayData.php">Zobrazit data</a></li>
            <li><a href="/addData.php">Přidat data</a></li>
        </ul>
        </nav>

        <div class="center-container">
          <div class="filter-panel">
            <h2>Filtr</h2>

            <label for="budovaFilter">Budova:</label>
            <select id="budovaFilter">
              <option value="">Všechny</option>
              <xsl:for-each select="budovy/budova">
                <option value="{kod}">
                  <xsl:value-of select="nazev"/>
                </option>
              </xsl:for-each>
            </select>

            <label for="typFilter">Typ místnosti:</label>
            <select id="typFilter">
              <option value="">Všechny</option>
              <xsl:for-each select="//typ[nazev]">
                <xsl:sort select="nazev" />
                <xsl:if test="not(preceding::typ[nazev = current()/nazev])">
                  <option value="{nazev}">
                    <xsl:value-of select="nazev" />
                  </option>
                </xsl:if>
              </xsl:for-each>
            </select>

            <label for="podlaziFilter">Podlaží:</label>
            <select id="podlaziFilter">
              <option value="">Všechny</option>
              <xsl:for-each select="//mistnost/podlazi">
                <xsl:sort data-type="number" />
                <xsl:if test="not(preceding::mistnost/podlazi = current())">
                  <option value="{.}">
                    <xsl:value-of select="." />
                  </option>
                </xsl:if>
              </xsl:for-each>
            </select>

            <label for="searchInput">Hledat podle kódu:</label>
            <input type="text" id="searchInput" placeholder="TEC-2-KAN01" />
          </div>

          <div class="budovy">
            <xsl:for-each select="budovy/budova">
              <div class="budova" data-kod="{kod}">
                <h2>
                  <xsl:value-of select="nazev"/> (<xsl:value-of select="kod"/>)
                </h2>
                <div class="mistnosti">
                  <xsl:for-each select="mistnosti/mistnost">
                    <div class="mistnost"
                         data-id="{@id}"
                         data-typ="{typ/nazev}"
                         data-podlazi="{podlazi}"
                         data-kod="{kod}">
                         <p><strong>Kód</strong>
                          <br/>
                          <xsl:value-of select="kod"/>
                        </p>
                        <p><strong>Typ</strong>
                          <br/>
                          <xsl:value-of select="typ/nazev"/>
                        </p>
                          <p><strong>Podlaží</strong>
                            <br/>
                          <xsl:value-of select="podlazi"/>
                        </p>
                    </div>
                  </xsl:for-each>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
