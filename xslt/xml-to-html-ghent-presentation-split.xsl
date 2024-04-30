<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="root">
        <xsl:for-each-group select="* except lacuna" group-starting-with="pb">
            <xsl:variable name="folioLabel">
                <xsl:value-of select="current-group()//folio"/>
                <xsl:if test="not(ends-with(current-group()//folio,'v'))">
                    <xsl:text>r</xsl:text>
                </xsl:if>
            </xsl:variable>
            <xsl:result-document encoding="UTF-8" method="xml" indent="no"
                href="text{$folioLabel}" omit-xml-declaration="yes">
                <div>
                    <h3>
                        <xsl:value-of select="$folioLabel"/>
                    </h3>
                    <xsl:text>&#x0a;</xsl:text>
                    <ol>
                        <xsl:apply-templates select="current-group()"/>
                    </ol>
                    <xsl:text>&#x0a;</xsl:text>
                </div>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="line">
        <li>
            <xsl:apply-templates select="node() except (folio | editionLineNo)"/>
        </li>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="sup">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
</xsl:stylesheet>
