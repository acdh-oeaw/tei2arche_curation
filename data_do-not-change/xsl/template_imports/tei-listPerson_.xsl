<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>

    <xsl:import href="add_modal_custom.xsl"/>

    <xsl:template name="listPerson">  
        <xsl:param name="transform"></xsl:param>
        <xsl:for-each select="//tei:listPerson">
            <div class="table-responsive">     
                <table class="table table-striped table-hover" id="tableOne">
                    <thead>
                        <tr>
                            <th>
                                <span class="body_translations" title="Name"><xsl:text>Name</xsl:text></span>
                            </th>
                            <th>
                                <span class="body_translations" title="Vorname"><xsl:text>Vorname</xsl:text></span>
                            </th>
                            <xsl:if test="./tei:person/tei:persName/tei:roleName">
                                <th>
                                    <span class="body_translations" title="Rollenname"><xsl:text>Rollenname</xsl:text></span>
                                </th>
                            </xsl:if>
                            <th>
                                <span class="body_translations" title="Lebensdaten"><xsl:text>Lebensdaten</xsl:text></span>
                            </th>
                            <xsl:if test="./tei:person/tei:note/tei:p[2]">
                                <th>
                                    <span class="body_translations" title="Kurzbiographie"><xsl:text>Kurzbiographie</xsl:text></span>
                                </th>
                            </xsl:if>                            
                            <th>
                                <xsl:text>URI</xsl:text>
                            </th>             
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="./tei:person">
                            <xsl:choose>
                                <xsl:when test="./not(node())">
                                    <!-- if tei:person does not have any nodes it does not include them -->
                                </xsl:when>
                                <xsl:otherwise>
                                    <tr>
                                        <xsl:choose>
                                            <xsl:when test="./tei:note/tei:p">
                                                <td>
                                                    <a href="#" data-toggle="modal" >
                                                        <xsl:attribute name="data-target">
                                                            <xsl:value-of select="concat('#',@xml:id)"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="./tei:persName/tei:surname"/>                                  
                                                    </a>
                                                    <xsl:call-template name="modal-custom">
                                                        <xsl:with-param name="ref-ID" select="@xml:id"/>
                                                        <xsl:with-param name="transform" select="$transform"/>
                                                        <xsl:with-param name="title">
                                                            <xsl:value-of select="concat(./tei:persName/tei:forename,' ',./tei:persName/tei:surname,' ',./tei:persName/tei:roleName)"/> 
                                                        </xsl:with-param>
                                                    </xsl:call-template>                            
                                                </td>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <td>
                                                    <xsl:value-of select="./tei:persName/tei:surname"/>
                                                </td> 
                                            </xsl:otherwise>
                                        </xsl:choose>                                        
                                        <td>
                                            <xsl:value-of select="./tei:persName/tei:forename"/>
                                        </td> 
                                        <xsl:if test="./tei:persName/tei:roleName">
                                            <td>
                                                <xsl:value-of select="./tei:persName/tei:roleName"/>
                                            </td>
                                        </xsl:if>                                        
                                        <td>
                                            <xsl:if test="./tei:note/tei:p[1] or ./tei:birth or ./tei:death">
                                            <ul>
                                                <xsl:if test="./tei:note/tei:p[1]">
                                                    <li>
                                                        <xsl:value-of select="./tei:note/tei:p[1]"/>
                                                    </li> 
                                                </xsl:if>
                                                <xsl:if test="./tei:birth">
                                                    <li><strong>Birth</strong></li>
                                                    <li><xsl:value-of select="./tei:birth/@when"/></li>                                
                                                </xsl:if>
                                                <xsl:if test="./tei:birth/tei:placeName">
                                                    <li><strong>Birthplace</strong></li>
                                                    <li><xsl:value-of select="./tei:birth/tei:placeName"/></li>  
                                                </xsl:if>
                                                <xsl:if test="./tei:death">                                                    
                                                    <li><strong>Death</strong></li>
                                                    <li><xsl:value-of select="./tei:death/@when"/></li>
                                                </xsl:if>
                                                <xsl:if test="./tei:death/tei:placeName">
                                                    <li><strong>Deathplace</strong></li>
                                                    <li><xsl:value-of select="./tei:death/tei:placeName"/></li> 
                                                </xsl:if>                                                
                                            </ul>  
                                            </xsl:if>
                                        </td>                                        
                                        <xsl:if test="./tei:note/tei:p[2]">
                                            <td>
                                                <xsl:value-of select="./tei:note/tei:p[2]"/>
                                            </td>
                                        </xsl:if>                                        
                                        <td>
                                            <xsl:if test="./tei:idno">
                                                <xsl:for-each select="./tei:idno">
                                                    <ul>
                                                        <li>                                                
                                                            <a target="_blank">
                                                                <xsl:attribute name="href">
                                                                    <xsl:value-of select="."/>
                                                                </xsl:attribute>
                                                                <xsl:apply-templates/>                                                             
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </xsl:for-each>   
                                            </xsl:if>
                                        </td>                                                                                
                                    </tr>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>