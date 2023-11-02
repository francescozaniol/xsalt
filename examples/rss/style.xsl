<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="./../../src/xsalt.xsl"/>

  <xsl:template match="rss/@version" />

  <xsl:template match="rss" mode="x-component">

    <template>
      <html>
        <head>
          <title><xsl:value-of select="./channel/title" /></title>
          <meta name="description" content="{./channel/description}" />
        </head>
        <body>
          <header>
            <h1>
              <a href="{./channel/link}">
                <xsl:value-of select="./channel/title" />
              </a>
            </h1>
            <p><xsl:value-of select="./channel/description" /></p>
          </header>
          <xsl:for-each select="./channel/item">
            <xsl:copy-of select="." />
          </xsl:for-each>
        </body>
      </html>
    </template>

  </xsl:template>

  <xsl:template match="item" mode="x-component">

    <template autobem="true">
      <article>
        <h1>
          <a href="{./link}">
            <xsl:value-of select="./title" />
          </a>
        </h1>
        <p>
          <xsl:copy-of select="./description/* | ./description/text()" />
        </p>
      </article>
    </template>

    <style autobem="true">
      .\$ {
        padding: 10px;
        border: 1px solid #999;
        margin: 0 0 10px 0;
      }
    </style>

  </xsl:template>

</xsl:transform>