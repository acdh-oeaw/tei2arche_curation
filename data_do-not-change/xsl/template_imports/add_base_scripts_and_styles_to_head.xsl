<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget add_base_scripts_and_styles</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied to html:head.</p>
            <p>The template "add_base_scripts_and_styles" container links to shared css styles from ACDH-CH fundament.</p>
            <p>The template containes links to shared scripts from ACDH-CH fundament.</p>
            <p>The template containes links to static css styles.</p>
            <p>The template containes links to shared scripts and css styles for Bootstrap implementation.</p>
        </desc>        
    </doc>
    
    <xsl:template name="add_base_scripts_and_styles">
        <link rel="profile" href="http://gmpg.org/xfn/11"/>       

        <!-- ############ Bootstrap latest compiled minified js ############ -->
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"/>

        <!-- ############ shared templates fundament ############ -->
        <!--<link rel="stylesheet" id="fundament-styles" href="https://shared.acdh.oeaw.ac.at/maechtekongresse/resources/css/style.css" type="text/css"/>-->
        <link rel="stylesheet" id="fundament-styles" href="https://shared.acdh.oeaw.ac.at/fundament/dist/fundament/css/fundament.min.css" type="text/css"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"/>                                                                      
        
        <!-- ############ static stylesheet ############ -->
        <link rel="stylesheet" type="text/css" href="../data_do-not-change/static/css/style.css"/>
        
        <!-- ############ shared scripts fundament ############ -->
        <!--<script type="text/javascript" src="https://shared.acdh.oeaw.ac.at/fundament/dist/fundament/vendor/jquery/jquery.min.js"></script>-->
        <!--<script type="text/javascript" src="https://shared.acdh.oeaw.ac.at/fundament/dist/fundament/js/fundament.min.js"></script>-->
        
        <!-- ############ JQuery ################ -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

        <!-- ############ Popper JS ############ -->    
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <!-- ########## Bootstrap cdn 4.6 ######### -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>        
       
        <!-- ############ JStree ############ -->    
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
        
        <!-- ############ arche-api package ############ --> 
        <script src="https://unpkg.com/arche-api@1.0.6-beta/lib/arche-api.min.js"></script>
    </xsl:template>
</xsl:stylesheet>