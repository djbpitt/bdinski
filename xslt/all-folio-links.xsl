<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template name="start">
        <form>
            <select id="folioChooser"
                onChange="location.href=this.options[this.selectedIndex].value;">
                <option>Go to page</option>
                <xsl:for-each select="1 to 76">
                    <option
                        value="http://bdinski.obdurodon.org/pages/bdinski{format-number(.,'000')}r.html">
                        <xsl:value-of select="."/>
                        <xsl:text>r</xsl:text>
                    </option>
                    <option
                        value="http://bdinski.obdurodon.org/pages/bdinski{format-number(.,'000')}v.html">
                        <xsl:value-of select="."/>
                        <xsl:text>v</xsl:text>
                    </option>
                </xsl:for-each>
                <option value="http://bdinski.obdurodon.org/pages/bdinski077r.html">77r</option>
                <option value="http://bdinski.obdurodon.org/pages/bdinski242r.html">242r</option>
            </select>
        </form>
    </xsl:template>
</xsl:stylesheet>
