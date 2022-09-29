<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget add_navbar_to_body</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied to html:body above page content.</p>
            <p>The template "add_navbar_to_body" containes the basic ACDH-CH fundament navbar.</p>     
        </desc>    
    </doc>
    
    <xsl:param name="transform"/>
    
    <xsl:template name="navbar-links">
        <li class="nav-item">
            <a title="Dokument" href="#home" data-toggle="tab" class="nav-link active body_translations">Dokument</a>
        </li>
        <li class="nav-item">
            <a title="About the Project" href="#about" data-toggle="tab" class="nav-link body_translations">About the Project</a>
        </li>
        <li class="nav-item">
            <a title="DATEN-Repräsentation" href="#transform" data-toggle="tab" class="nav-link body_translations">DATEN-Repräsentation</a>
        </li>
    </xsl:template>

</xsl:stylesheet>