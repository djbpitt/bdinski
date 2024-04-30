<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:djb="http://www.obdurodon.org" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs djb" version="2.0">
    <xsl:variable name="folios" select="'1r','2v','3r','260r','260v'"/>
    <xsl:function name="djb:preceding" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:variable name="oldnumeric"
            select="xs:integer(substring($input,1,string-length($input) - 1))" as="xs:integer"/>
        <xsl:variable name="oldside" select="substring($input,string-length($input))" as="xs:string"/>
        <xsl:variable name="newnumeric">
            <xsl:choose>
                <xsl:when test="$oldside eq 'v'">
                    <xsl:value-of select="format-number($oldnumeric,'000')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="format-number($oldnumeric - 1,'000')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="newside">
            <xsl:choose>
                <xsl:when test="$oldside eq 'v'">
                    <xsl:text>r</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>v</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($newnumeric,$newside)"/>
    </xsl:function>
    <xsl:function name="djb:following" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:variable name="oldnumeric"
            select="xs:integer(substring($input,1,string-length($input) - 1))" as="xs:integer"/>
        <xsl:variable name="oldside" select="substring($input,string-length($input))" as="xs:string"/>
        <xsl:variable name="newnumeric">
            <xsl:choose>
                <xsl:when test="$oldside eq 'r'">
                    <xsl:value-of select="format-number($oldnumeric,'000')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="format-number($oldnumeric + 1,'000')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="newside">
            <xsl:choose>
                <xsl:when test="$oldside eq 'r'">
                    <xsl:text>v</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>r</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($newnumeric,$newside)"/>
    </xsl:function>
    <!--    <xsl:template match="/">
        <root>
            <xsl:for-each select="$folios">
                <folio>
                    <actual>
                        <xsl:value-of select="."/>
                    </actual>
                    <preceding>
                        <xsl:value-of select="djb:preceding(.)"/>
                    </preceding>
                    <following>
                        <xsl:value-of select="djb:following(.)"/>
                    </following>
                </folio>
            </xsl:for-each>
        </root>
    </xsl:template>
-->
</xsl:stylesheet>
