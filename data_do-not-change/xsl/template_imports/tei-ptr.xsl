<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-ptr.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "tei-ptr" can handle the tei/xml tag ptr.</p> 
            <p>The template verifies if attributes like ref and target is available.</p>
            <p>If a target attribute is found the value is used as URL and a html link is created.</p>
            <p>If a ref attribute is found the template searches for URI, URL,VIAF or GND of a corresponding indo that is part of the same ref number.</p>
            <p>If a target attribute is found the ref value will be used as URL and create a html link if the value starts with http or www.</p>
            <p>The template rules for the tei:body verifies the attribute type value and seperates between place or org and person.</p>
            <p>For place and org an idno URL with the same parameters as mentioned before will be used to create a html link and coordinates via the tei:geo tag are retrieved and formated for further usage.</p>
            <p>For person an idno URL with the same parameters as mentioned before will be used to create a html link.</p>
        </desc>    
    </doc>
    
    <xsl:template match="tei:ptr">        
        <xsl:choose>
            <xsl:when test="not(parent::tei:relatedItem)">
                
                <xsl:variable name="ptr_target" select="substring-after(data(@target),'#')"/>
                <!-- musste hier kurz die variable abändern <xsl:variable name="doc_bibl" select="doc('../../../tei/bibls.xml')"/> -->
                <!--<xsl:variable name="doc_bibl" select="doc('../../../JWV-daten/outputs/bibls.xml')"/>-->
                <xsl:variable name="doc_bibl" select="doc('../../../tei/manuelle-korrektur/korrigiert/bibls.xml')"/>
                <xsl:variable name="doc_bibl_2" select="doc('../../../tei/manuelle-korrektur/korrigiert/bibls_fl00.xml')"/>
                <xsl:variable name="doc_bibl_3" select="doc('../../../tei/manuelle-korrektur/korrigiert/bibls_ml96.xml')"/>
                <xsl:variable name="doc_bibl_4" select="doc('../../../tei/manuelle-korrektur/korrigiert/bibls_sw90.xml')"/>
                <xsl:choose>
                    <xsl:when test="$doc_bibl//id($ptr_target)">
                        <xsl:for-each select="$doc_bibl//id($ptr_target)">  
                                           
                            <xsl:call-template name="doc_bibl"/>   
                                         
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="$doc_bibl_2//id($ptr_target)">
                        <xsl:for-each select="$doc_bibl_2//id($ptr_target)">  
                            
                            <xsl:call-template name="doc_bibl"/>   
                            
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="$doc_bibl_3//id($ptr_target)">
                        <xsl:for-each select="$doc_bibl_3//id($ptr_target)">  
                            
                            <xsl:call-template name="doc_bibl"/>   
                            
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="$doc_bibl_4//id($ptr_target)">
                        <xsl:for-each select="$doc_bibl_4//id($ptr_target)">  
                            
                            <xsl:call-template name="doc_bibl"/>   
                            
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="col-md-12">  
                            <div class="card">
                                <div class="card-header">
                                    <span class="badge bg-light text-dark">
                                        
                                        <xsl:call-template name="small"/>
                                        
                                    </span>
                                </div>
                                <div class="card-body">  
                                    <span style="color:red;"><xsl:text>No bibl found with this ptr target ID.</xsl:text></span>
                                </div>
                            </div>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>  
                
            </xsl:when>
            <xsl:otherwise>
                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
</xsl:stylesheet>