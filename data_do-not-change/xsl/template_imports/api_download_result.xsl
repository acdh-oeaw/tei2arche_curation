<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:dc11="http://purl.org/dc/elements/1.1/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:arche="https://vocabs.acdh.oeaw.ac.at/schema#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <xsl:template name="api_download_result">
        <div class="tab-pane container fade" id="edition" tabindex="-1">                                                               
            <div id="loaderEnd" class="row fade">                                   
                <div class="col-md-12 content-area" id="edition-area"> 
                    <div class="card border-secondary">
                        <div class="card-header">
                            <h3 class="body_translations" title="Gesamter Bestand">Gesamter Bestand</h3>                                                
                        </div>
                        <div class="card-body table-responsive">
                            <table id="tableAjax" class="table table-striped">

                            </table>                                                                    
                        </div>
                    </div>                                                                                                                                                            
                </div><!-- .content-area -->
            </div> <!-- .row -->
        </div>
    </xsl:template>
    
</xsl:stylesheet>