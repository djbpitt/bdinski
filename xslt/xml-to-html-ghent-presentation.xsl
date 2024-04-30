<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xhtml" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="root">
        <html>
            <xsl:comment>#set var="title" value="1. Abraham (ff. 1-17v)" </xsl:comment>
            <xsl:comment>#config timefmt="%Y-%m-%dT%X%z" </xsl:comment>
            <head>
                <title>
                    <xsl:comment>#echo var="title" </xsl:comment>
                </title>
                <xsl:comment>#include virtual="inc/bdinski-header.html" </xsl:comment>
            </head>
            <body>
                <xsl:comment>#include virtual="inc/bdinski-boilerplate.html" </xsl:comment>
                <xsl:for-each-group select="* except lacuna" group-starting-with="pb">
                    <h3>
                        <xsl:apply-templates select="current-group()//folio"/>
                        <xsl:if test="not(ends-with(current-group()//folio,'v'))">
                            <xsl:text>r</xsl:text>
                        </xsl:if>
                    </h3>
                    <xsl:text>&#x0a;</xsl:text>
                    <ol>
                        <xsl:apply-templates select="current-group()"/>
                    </ol>
                    <xsl:text>&#x0a;</xsl:text>
                </xsl:for-each-group>
            </body>
        </html>
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
