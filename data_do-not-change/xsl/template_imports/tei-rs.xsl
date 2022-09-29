<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-rs.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "tei-rs" can handle the tei/xml tag rs.</p> 
            <p>The template verifies if attributes like ref and target is available.</p>
            <p>If a target attribute is found the value is used as URL and a html link is created.</p>
            <p>If a ref attribute is found the template searches for URI, URL,VIAF or GND of a corresponding indo that is part of the same ref number.</p>
            <p>If a target attribute is found the ref value will be used as URL and create a html link if the value starts with http or www.</p>
            <p>The template rules for the tei:body verifies the attribute type value and seperates between place or org and person.</p>
            <p>For place and org an idno URL with the same parameters as mentioned before will be used to create a html link and coordinates via the tei:geo tag are retrieved and formated for further usage.</p>
            <p>For person an idno URL with the same parameters as mentioned before will be used to create a html link.</p>
        </desc>    
    </doc>
    
    <xsl:template match="tei:rs">
        
        <xsl:choose>
            <xsl:when test="@type='work' and starts-with(@ref, 'work')">
                <xsl:variable name="rs_target" select="@ref"/>
                <xsl:variable name="doc_windex" select="doc('../../../tei/manuelle-korrektur/korrigiert/work_index.xml')"/>
                <span class="badge bg-light text-dark">
                    
                    <xsl:call-template name="small"/>
                    
                </span>
                
                <xsl:choose>
                    <xsl:when test="$doc_windex//id($rs_target)">
                        <xsl:for-each select="$doc_windex//id($rs_target)">  
                            <xsl:if test="./tei:title">
                                <span class="badge bg-light text-dark" style="border:1px solid blue !important;">
                                    <small>
                                        <xsl:value-of select="./tei:title/name()"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:for-each select="./tei:title/@*">
                                            <xsl:value-of select="name()"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="."/>
                                        </xsl:for-each>                        
                                    </small>                            
                                    <small>
                                        <span class="{./tei:title/name()}">
                                            <xsl:value-of select="./tei:title"/>
                                        </span>
                                    </small>
                                </span>
                            </xsl:if>
                            <xsl:if test="./tei:note">
                                <span class="badge bg-light text-dark" style="border:1px solid blue !important;">
                                    <small>
                                        <xsl:value-of select="./tei:note/name()"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:for-each select="./tei:note/@*">
                                            <xsl:value-of select="name()"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="."/>
                                        </xsl:for-each>                        
                                    </small>
                                    <small>
                                        <span class="{./tei:note/name()}">
                                            <xsl:value-of select="./tei:note"/>
                                        </span>
                                    </small>
                                </span>
                            </xsl:if>                  
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>

                    </xsl:otherwise>
                </xsl:choose>
                
                <span class="{name()}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="badge bg-light text-dark">
                    
                    <xsl:call-template name="small"/>
                    
                </span>
                
                <span class="{name()}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>