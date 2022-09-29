<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:dc="http://purl.org/dc/terms/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:sparql="http://www.w3.org/2005/sparql-results#"
    xmlns:my="http://test.org/"
    xmlns:arche="https://vocabs.acdh.oeaw.ac.at/schema#"
    exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <!-- ########### html head ########### -->
    <xsl:import href="template_imports/add_base_scripts_and_styles_to_head.xsl"/>
    <xsl:import href="template_imports/add_metadata_to_head.xsl"/>   
    
    <!-- ########### fundament (footer/navigation) ########### -->
    <xsl:import href="template_imports/add_footer_to_body.xsl"/>
    <xsl:import href="template_imports/add_navbar_to_body.xsl"/>
    <!-- ########### general imports ########### -->    
    <xsl:import href="template_imports/add_modal-metadata.xsl"/>
    <xsl:import href="template_imports/tei-ref.xsl"/>
    <xsl:import href="template_imports/tei-rs.xsl"/>
    <xsl:import href="template_imports/tei-ptr.xsl"/> <!-- the ptr template contains the search for bibl IDs in the external bibl.xml files -->
    <xsl:import href="template_imports/doc_bibl.xsl"/> <!-- the doc_bibl template holds the code used in tei-ptr to avoid multiplying code lines -->
    <xsl:import href="template_imports/doc_bibl_2.xsl"/> <!-- the doc_bibl_2 template holds the code used in nested tei-ptr to avoid multiplying code lines -->
    <xsl:import href="template_imports/span_child.xsl"/> <!-- creates a small badge with node name and attribute name and value -->
    <xsl:import href="template_imports/div_card_badge_block.xsl"/> <!-- hold template for cards and badges with display block -->
    <xsl:import href="template_imports/div_card_badge_inline.xsl"/> <!-- hold template for cards and badges with display inline -->
    <xsl:import href="template_imports/tei-title.xsl"/>    
    <xsl:import href="template_imports/tei-placeName.xsl"/>
    <xsl:import href="template_imports/tei-name.xsl"/>
    <xsl:import href="template_imports/tei-persName.xsl"/>
    <xsl:import href="template_imports/tei-pubPlace.xsl"/>
    <xsl:import href="template_imports/tei-publisher.xsl"/>
    <xsl:import href="template_imports/tei-date.xsl"/>
    <xsl:import href="template_imports/tei-time.xsl"/>
    <xsl:import href="template_imports/tei-entities.xsl"/>    
    <xsl:import href="template_imports/tei-choice.xsl"/>    
    <xsl:import href="template_imports/tei-list.xsl"/>
    <!-- ############### general imports for content_block template ################# -->
    <xsl:import href="template_imports/add_header-navigation-custom-title.xsl"/>
    <xsl:import href="template_imports/add_html_xsl_data_transform_info.xsl"/>
    <xsl:import href="template_imports/content_block_project.xsl"/>   
    
    <!-- ########### ARCHE metadata ########### -->
    <!--<xsl:import href="arche_templates/root_col.xsl"/>-->
        
    <!-- ############################################## -->
    <!-- ########### project specific imports ######### -->
    <!-- ############################################## -->
    <!-- ############# START HERE ##################### -->
    <!-- ############################################## -->    
    <xsl:import href="jelinek/content_block.xsl"/>
    <xsl:import href="jelinek/navbar-links.xsl"/>
    
    <!-- ########### parameters ########### -->
    <xsl:param name="app-name">tei2arche</xsl:param>
    <xsl:param name="document" select="tei:TEI/@xml:id"/>    
    <xsl:param name="transform">?format=customTei2Html</xsl:param>
    <xsl:param name="collection-name">Jelinek online. Elfriede Jelinek: Werk und Rezeption</xsl:param>
    <xsl:param name="project-xsl">test.xsl</xsl:param><!-- add main xsl name with file-extention -->
    <xsl:param name="path2source"></xsl:param>
    <xsl:param name="tei-source" select="concat($baseURL,'/',$document)"/>    
    <xsl:param name="image-url"></xsl:param>
    <xsl:param name="navbar-color">navbar-dark bg-dark</xsl:param>
    <xsl:param name="title" select="//tei:titleStmt//tei:title"/>
    <xsl:param name="arche_root_col_url"></xsl:param>
    <xsl:param name="arche_child_col_url"></xsl:param>
    <xsl:param name="baseURL" select="//@xml:base"/>
    <xsl:param name="next" select="//@next"/>
    <xsl:param name="prev" select ="//@prev"/>
    
    <!-- ######################################################### --> 
    <!-- ##################### html structure #################### --> 
    <!-- ######################################################### --> 
    
    <xsl:template match="/">
        <html lang="en">
            <!-- ############### head ################ -->
            <head>
                <xsl:call-template name="add_metadata_to_head"/>
                <xsl:call-template name="add_base_scripts_and_styles"/>
                <title>
                    <xsl:value-of select="$title"/>
                </title>
                <!-- ************** project specific static css stylesheet ************** -->
                <style type="text/css">
                    .Bold {
                        font-weight:bold;
                    }
                    .SmallCaps {
                        text-transform:lowercase;
                    }
                    .AllCaps {
                        text-transform:uppercase;
                    }
                    .Italic {
                        font-style:italic;
                    }
                    .card {
                        margin-top: .5em;
                        margin-bottom:.5em;
                        border:1px solid lightgrey;
                        border-radius:5px;
                    }
                    p {
                        padding:.5em;
                        line-height: 2em;
                        display: block;
                        text-align: justify;
                    }
                    .note {
                        display:block;
                        line-height: 1em;
                        text-align: justify;
                    }
                    .series, .pubPlace, .publisher, .date {                    
                        line-height: 1em;
                        text-align: justify;
                    }
                    .badge-block, .biblScope {
                        display:block !important;
                        text-align:right;
                    }       
                    .relatedItem {
                        display:block;
                    }
                    .title, .head {
                        font-size:16px !important;
                        font-weight:normal !important;
                        text-decoration:underline;
                    }
                </style>
            </head>
            <!-- ############### body ################ -->
            <body>
                <div class="hfeed site" id="page">
                    <!-- ******************* The Navbar Area ******************* -->                    
                    <xsl:call-template name="navbar"/>
                    
                    <div class="wrapper" id="single-wrapper">                        
                        
                        <!-- ************ bootstrap tab-content start ************* -->
                        <div class="tab-content">                          
                            
                            <!-- ****************** content cards ****************** -->                         
                            <xsl:call-template name="cards"/>                             
                            
                            <xsl:call-template name="cards-project"/>                             
                            
                        </div><!-- bootstrap end -->
                        
                        <!-- ***************** creating a modal window ************* -->
                        <xsl:call-template name="modal-metadata"/>
                        
                    </div><!-- #single-wrapper -->
                    
                    <!-- ******************* footer ******************* -->
                    <xsl:call-template name="fundament-footer"/>
                    
                </div><!-- hfeed site end -->
                <!-- ****************** loads DataTable and Leaflet css and js via cdn ****************** --> 
                <!-- ****************** static scripts ****************** -->         
                <script type="text/javascript" src="../data_do-not-change/static/js/change_color_theme.js"/>  
            </body>
        </html>        
    </xsl:template>
    
</xsl:stylesheet>