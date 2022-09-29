<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-list.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "tei-list" can handle the tei/xml tag list.</p> 
            <p>The template rules are seperate for teiHeader and tei:body while first will additionally add html list tags (dt, dd).</p>
        </desc>    
    </doc>
    
    <xsl:template match="tei:list">

        <xsl:choose>
            <xsl:when test="parent::tei:div[not(@type='entry')] or ancestor::tei:div[not(@type='entry')]">
                  
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            
                            <span class="badge bg-light text-dark">
                                <small>
                                    <xsl:value-of select="./name()"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:for-each select="@*">
                                        <xsl:value-of select="./name()"/>
                                        <xsl:text> = </xsl:text>
                                        <xsl:value-of select="."/>
                                        <xsl:text> / </xsl:text>
                                    </xsl:for-each>                        
                                </small>
                            </span> 
                        </div>
                                
                        <div class="card-body">
                            <ul style="padding:1em;">
                                <xsl:apply-templates/>
                            </ul>
                        </div>

                    </div>
                </div>         
                
            </xsl:when>
            
            <xsl:otherwise>
                
                <div class="card" style="border:1px solid red">
                    
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                
                                <span class="badge bg-light text-dark">
                                    <small>
                                        <xsl:value-of select="./name()"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:for-each select="@*">
                                            <xsl:value-of select="./name()"/>
                                            <xsl:text> = </xsl:text>
                                            <xsl:value-of select="."/>
                                            <xsl:text> / </xsl:text>
                                        </xsl:for-each>                        
                                    </small>
                                </span> 
                            </div>
                            
                            <div class="card-body">
                                <ul style="padding:1em;">
                                    <xsl:apply-templates/>
                                </ul>
                            </div>
                            
                        </div>
                    </div>
                    
                </div>
                
            </xsl:otherwise>
            
        </xsl:choose>
        
</xsl:template>
</xsl:stylesheet>