<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="* | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="(.)[єе]">
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
            <xsl:matching-substring>
                <xsl:value-of select="regex-group(1)"/>
                <xsl:choose>
                    <xsl:when test="matches(' аеиоуяыюъыьяꙋꙍꙙꙩꙫꙭꙥҥ',regex-group(1))">
                        <xsl:text>є</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>е</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>
</xsl:stylesheet>
