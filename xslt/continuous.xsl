<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xhtml" indent="yes" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:strip-space elements="root"/>
    <xsl:variable name="basename" select="substring-before(tokenize(base-uri(),'/')[last()],'.')"/>
    <xsl:variable name="titleSet">
        <xsl:text>#set var="title" value="</xsl:text>
        <xsl:value-of select="concat(upper-case(substring($basename,1,1)),substring($basename,2))"/>
        <xsl:text>" </xsl:text>
    </xsl:variable>
    <xsl:variable name="editorSet">
        <xsl:text>#set var="editor" value="</xsl:text>
        <xsl:value-of select="/root/metadata/name"/>
        <xsl:text>" </xsl:text>
    </xsl:variable>
    <xsl:variable name="emailSet">
        <xsl:text>#set var="email" value="</xsl:text>
        <xsl:value-of select="/root/metadata/email"/>
        <xsl:text>" </xsl:text>
    </xsl:variable>
    <xsl:template match="/">
        <html>
            <xsl:comment select="$titleSet"/>
            <xsl:comment select="$editorSet"/>
            <xsl:comment select="$emailSet"/>
            <xsl:comment>#config timefmt="%Y-%m-%dT%X%z" </xsl:comment>
            <head>
                <title>
                    <xsl:comment>#echo var="title" </xsl:comment>
                </title>
                <xsl:comment>#include virtual="inc/bdinski-header.html" </xsl:comment>
                <xsl:text>&#x0a;</xsl:text>
            </head>
            <body>
                <xsl:comment>#include virtual="inc/bdinski-boilerplate.html" </xsl:comment>
                <p class="os">
                    <xsl:apply-templates/>
                </p>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="folio">
        <xsl:variable name="folionumber" select="number(substring(@n,1,string-length(@n) - 1))"/>
        <xsl:variable name="folioletter" select="substring(@n,string-length(@n))"/>
        <strong>
            <xsl:text>|[</xsl:text>
            <a href="pages/bdinski{format-number($folionumber,'000')}{$folioletter}.html">
                <xsl:value-of select="@n"/>
            </a>
            <xsl:text>]|</xsl:text>
        </strong>
    </xsl:template>
    <xsl:template match="line">
        <xsl:if test="not(ends-with(preceding-sibling::line[1],'-'))">
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="not(ends-with(.,'-'))">
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="not(following-sibling::*[1]/self::folio)">
            <xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="sup">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    <xsl:template match="lig">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="translate(.,'-*','')"/>
    </xsl:template>
    <xsl:template match="lacuna"/>
    <xsl:template match="metadata"/>
</xsl:stylesheet>
