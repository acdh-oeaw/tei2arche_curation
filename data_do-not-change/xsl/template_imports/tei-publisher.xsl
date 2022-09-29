<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget tei-persName.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "tei-persName" can handle the tei/xml tag persName.</p> 
            <p>The template rules are seperate for teiHeader and tei:body while first will additionally add html list tags (dt, dd).</p>
            <p>The template verifies if attributes like ref and key are available.</p>
            <p>If a ref attribute is found the template searches for URI or URL of a corresponding indo that is part of the same ref number.</p>
            <p>If a key attribute is found the template will use the value of this attribute as URL.</p>
            <p>If a ref attribute is found that does not have a corresponding idno the template will use the value of this attribute as URL unless the ref starts with an #.</p>
        </desc>    
    </doc>
    
    <xsl:template match="tei:publisher">
        
        <span class="badge bg-light text-dark">
            
            <xsl:call-template name="small"/>
            
        </span>
        
        <span class="{concat(./name(),' ',@*)}"><xsl:apply-templates/></span>
        
    </xsl:template>
</xsl:stylesheet>