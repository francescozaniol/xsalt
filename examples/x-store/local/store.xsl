<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="x-store" mode="x-store">
  <xsl:copy-of select="document('./articles.xml')" />
</xsl:template>
</xsl:transform>