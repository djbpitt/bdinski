<?xml version="1.0" encoding="UTF-8"?>
<!-- fix line height to regularize spacing over superscripts -->
<!-- supplied, add, and gap need handling -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:djb="http://www.obdurodon.org" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs djb" version="2.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:include href="page-forward-and-back.xsl"/>
    <xsl:variable name="basename" select="substring-before(tokenize(base-uri(),'/')[last()],'.')"/>
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
    <xsl:template match="root">
        <xsl:for-each-group select="* except (lacuna | metadata)" group-starting-with="folio">
            <xsl:variable name="folio" select="current-group()[self::folio]/@n"/>
            <xsl:variable name="folionumber" select="substring($folio,1,string-length($folio) - 1)"/>
            <xsl:variable name="folioletter" select="substring($folio,string-length($folio))"/>
            <xsl:variable name="filenumber"
                select="concat(format-number(number($folionumber),'000'),$folioletter)"/>
            <xsl:variable name="preceding" select="djb:preceding($folio)"/>
            <xsl:variable name="following" select="djb:following($folio)"/>
            <xsl:result-document method="xml" indent="no"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
                href="{concat('bdinski', $filenumber,'.html')}">
                <xsl:variable name="titleSet">
                    <xsl:text>#set var="title" value="</xsl:text>
                    <xsl:value-of
                        select="concat(upper-case(substring($basename,1,1)),substring($basename,2))"/>
                    <xsl:text>" </xsl:text>
                </xsl:variable>
                <html>
                    <xsl:text>&#x0a;</xsl:text>
                    <xsl:comment select="$titleSet"/>
                    <xsl:text>&#x0a;</xsl:text>
                    <xsl:comment>#config timefmt="%Y-%m-%dT%X%z" </xsl:comment>
                    <xsl:text>&#x0a;</xsl:text>
                    <head>
                        <title>
                            <xsl:text>&#x0a;</xsl:text>
                            <xsl:comment>#echo var="title" </xsl:comment>
                            <xsl:text>&#x0a;</xsl:text>
                        </title>
                        <xsl:text>&#x0a;</xsl:text>
                        <xsl:comment>#include virtual="../inc/bdinski-header.html" </xsl:comment>
                        <xsl:text>&#x0a;</xsl:text>
                        <script type="text/javascript" src="../js/magnifier.js">//</script>
                    </head>
                    <xsl:text>&#x0a;</xsl:text>
                    <body>
                        <xsl:text>&#x0a;</xsl:text>
                        <xsl:comment select="$editorSet"/>
                        <xsl:comment select="$emailSet"/>
                        <xsl:comment>#include virtual="../inc/bdinski-boilerplate-notitle.html" </xsl:comment>
                        <xsl:text>&#x0a;</xsl:text>
                        <div id="text" class="os">
                            <xsl:text>&#x0a;</xsl:text>
                            <xsl:comment>#include virtual="../inc/widgets.xml" </xsl:comment>
                            <h3>
                                <!-- no navigation to preceding or following if it isn't on the site yet -->
                                <xsl:if
                                    test="not($folionumber eq '1' and $folioletter eq 'r') and not($folionumber eq '242')">
                                    <a href="bdinski{$preceding}.html">
                                        <xsl:text>&lt;</xsl:text>
                                    </a>
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="$folio"/>
                                <xsl:if
                                    test="not($folionumber eq '77' and $folioletter eq 'r') and not($folionumber eq '242')">
                                    <xsl:text> </xsl:text>
                                    <a href="bdinski{$following}.html">
                                        <xsl:text>&gt;</xsl:text>
                                    </a>
                                </xsl:if>
                            </h3>
                            <xsl:text>&#x0a;</xsl:text>
                            <ol>
                                <xsl:text>&#x0a;</xsl:text>
                                <xsl:apply-templates select="current-group() except folio"/>
                            </ol>
                            <xsl:text>&#x0a;</xsl:text>
                        </div>
                        <xsl:text>&#x0a;</xsl:text>
                        <div id="image">
                            <img id="smallImage"
                                src="{concat('../images/jpg/bdinski', $filenumber, '.jpg')}"
                                alt="{concat('Image of ', $filenumber)}" onload="setupMagnifier();"/>
                            <div id="largeImage"
                                style="background-image:url({concat('../images/jpg/bdinski',$filenumber, '.jpg')});"
                            />
                        </div>
                        <xsl:text>&#x0a;</xsl:text>
                    </body>
                    <xsl:text>&#x0a;</xsl:text>
                </html>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="line">
        <li>
            <xsl:apply-templates/>
        </li>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="sup">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    <xsl:template match="supplied">
        <xsl:text>&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="add">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="gap">
        <xsl:text>[</xsl:text>
        <xsl:for-each select="1 to @quantity">
            <xsl:text>&#x00a0;.&#x00a0;</xsl:text>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="editionParagraphNo"/>
    <xsl:template match="lig">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="translate(.,'*','')"/>
    </xsl:template>
</xsl:stylesheet>
