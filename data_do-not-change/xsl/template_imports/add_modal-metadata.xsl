<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:foo="foo.com" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dc="http://purl.org/dc/terms/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:sparql="http://www.w3.org/2005/sparql-results#" xmlns:my="http://test.org/" exclude-result-prefixes="tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget add_modal-metadata.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with apply-templates in html:body.</p>
            <p>The template "add_modal-metadata" creates a modal window that uses bootstrap fade and show.</p> 
            <p>The modal window contant contains metadata from the teiHeader.</p> 
        </desc>    
    </doc>
    
    <xsl:template name="modal-metadata">
        
        <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    
                    <div class="modal-header">                        
                        <h5 class="modal-title" id="exampleModalLongTitle">
                            <span style="margin-right:.25em;" class="body_translations" title="{$title}"><xsl:value-of select="$title"/></span>
                        </h5>
                        <button type="button" class="ml-2 mb-1 close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">x</span></button>
                    </div>
                    
                    <div class="modal-body">                        
                        <table class="table table-striped">
                            <tbody>
                                
                                <xsl:if test="//tei:titleStmt/tei:editor">
                                    <xsl:for-each select="//tei:titleStmt/tei:editor">
                                        <tr>
                                            <th style="text-transform:uppercase;">
                                                <abbr class="body_translations" title="name(.)"><xsl:value-of select="name(.)"/></abbr>
                                            </th>
                                            <td>
                                                <xsl:for-each select=".">                                                
                                                    <xsl:apply-templates/>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:if>
                                
                                <xsl:if test="//tei:respStmt">
                                    <xsl:for-each select="//tei:respStmt">
                                        <tr>
                                            <th style="text-transform:uppercase;">
                                                <xsl:for-each select="./tei:resp">
                                                    <span class="body_translations" title="{.}"><xsl:apply-templates/></span>
                                                </xsl:for-each>
                                            </th>
                                            
                                            <td>
                                                <xsl:for-each select="./tei:persName">                                                    
                                                    <xsl:variable name="refId">
                                                        <xsl:value-of select="substring-after(data(@ref), '#')"/>
                                                    </xsl:variable>
                                                    
                                                    <xsl:choose>
                                                        <xsl:when test="//id($refId)//tei:idno">
                                                            <xsl:for-each select="//id($refId)//tei:idno">
                                                                <a target="_blank">
                                                                    <xsl:attribute name="href">
                                                                        <xsl:value-of select="."/>
                                                                    </xsl:attribute>
                                                                    <xsl:apply-templates/>           
                                                                </a> 
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        
                                                        <xsl:when test="@key">
                                                            <xsl:choose>
                                                                <xsl:when test="starts-with(@key,'#')">
                                                                    <xsl:apply-templates/>  
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <a target="_blank">
                                                                        <xsl:attribute name="href">
                                                                            <xsl:value-of select="@key"/>
                                                                        </xsl:attribute>
                                                                        <xsl:apply-templates/>           
                                                                    </a> 
                                                                </xsl:otherwise>
                                                            </xsl:choose>                                                                                         
                                                        </xsl:when>
                                                        
                                                        <xsl:when test="@ref">
                                                            <xsl:choose>
                                                                <xsl:when test="starts-with(@ref,'#')">
                                                                    <xsl:apply-templates/>  
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <a target="_blank">
                                                                        <xsl:attribute name="href">
                                                                            <xsl:value-of select="@ref"/>
                                                                        </xsl:attribute>
                                                                        <xsl:apply-templates/>           
                                                                    </a> 
                                                                </xsl:otherwise>
                                                            </xsl:choose>                               
                                                        </xsl:when>
                                                        
                                                        <xsl:otherwise>
                                                            <xsl:apply-templates/>
                                                        </xsl:otherwise>
                                                        
                                                    </xsl:choose>
                                                </xsl:for-each>
                                                
                                                <xsl:for-each select="./tei:name">
                                                    <xsl:variable name="refId">
                                                        <xsl:value-of select="substring-after(data(@ref), '#')"/>
                                                    </xsl:variable>
                                                    
                                                    <xsl:choose>
                                                        <xsl:when test="//id($refId)//tei:idno">
                                                            <xsl:for-each select="//id($refId)//tei:idno">
                                                                <a target="_blank">
                                                                    <xsl:attribute name="href">
                                                                        <xsl:value-of select="."/>
                                                                    </xsl:attribute>
                                                                    <xsl:apply-templates/>           
                                                                </a> 
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        
                                                        <xsl:when test="@key">
                                                            <xsl:choose>
                                                                <xsl:when test="starts-with(@key,'#')">
                                                                    <xsl:apply-templates/>  
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <a target="_blank">
                                                                        <xsl:attribute name="href">
                                                                            <xsl:value-of select="@key"/>
                                                                        </xsl:attribute>
                                                                        <xsl:apply-templates/>           
                                                                    </a> 
                                                                </xsl:otherwise>
                                                            </xsl:choose>                                                                                         
                                                        </xsl:when>
                                                        
                                                        <xsl:when test="@ref">
                                                            <xsl:choose>
                                                                <xsl:when test="starts-with(@ref,'#')">
                                                                    <xsl:apply-templates/>  
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <a target="_blank">
                                                                        <xsl:attribute name="href">
                                                                            <xsl:value-of select="@ref"/>
                                                                        </xsl:attribute>
                                                                        <xsl:apply-templates/>           
                                                                    </a> 
                                                                </xsl:otherwise>
                                                            </xsl:choose>                               
                                                        </xsl:when>  
                                                        
                                                        <xsl:when test="./tei:rs"> 
                                                            <xsl:for-each select="./tei:rs">
                                                                <xsl:choose>
                                                                    <xsl:when test="starts-with(@ref,'#')">
                                                                        <xsl:apply-templates/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <a target="_blank">
                                                                            <xsl:attribute name="href">
                                                                                <xsl:value-of select="@ref"/>
                                                                            </xsl:attribute>
                                                                            <xsl:apply-templates/>           
                                                                        </a>                                                                        
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:for-each>
                                                        </xsl:when>
                                                        
                                                        <xsl:otherwise>
                                                            <xsl:apply-templates/>
                                                        </xsl:otherwise>
                                                        
                                                    </xsl:choose>                                                    
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:if>
                                
                                <xsl:if test="//tei:abstract">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <abbr class="body_translations" title="Zusammenfassung">Zusammenfassung</abbr>
                                        </th>
                                        <td>
                                            <xsl:for-each select="//tei:abstract/child::*">                                                
                                                <xsl:value-of select="."/>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:creation">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <abbr class="body_translations" title="name(.)"><xsl:value-of select="//tei:creation/tei:date/name(.)"/></abbr>
                                        </th>
                                        <td>
                                            <xsl:for-each select="//tei:creation">     
                                                <ul>
                                                    <xsl:for-each select="./tei:date">
                                                        <li><strong>Original</strong></li>
                                                        <li><xsl:value-of select="."/></li>
                                                        <li><strong><xsl:value-of select="@notBefore/name()"/></strong></li>
                                                        <li><xsl:value-of select="@notBefore"/></li>
                                                        <li><strong><xsl:value-of select="@notAfter/name()"/></strong></li>
                                                        <li><xsl:value-of select="@notAfter"/></li>
                                                    </xsl:for-each>                                                    
                                                </ul>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:msIdentifier">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <abbr class="body_translations" title="Signatur">Signatur</abbr>
                                        </th>
                                        <td>
                                            <xsl:for-each select="//tei:msIdentifier/child::*">
                                                <abbr>
                                                    <xsl:attribute name="title">
                                                        <xsl:value-of select="name()"/>
                                                    </xsl:attribute>
                                                    <xsl:value-of select="."/>
                                                </abbr>
                                                <br/>
                                            </xsl:for-each><!--<xsl:apply-templates select="//tei:msIdentifier"/>-->
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:publicationStmt">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <span class="body_translations" title="Publikation">Publikation</span>
                                        </th>
                                        <td>
                                            
                                            <xsl:if test="//tei:publicationStmt/tei:p">
                                                <xsl:value-of select="//tei:publicationStmt/tei:p"/>
                                            </xsl:if>
                                            
                                            <xsl:if test="//tei:publicationStmt/tei:publisher">
                                                <xsl:apply-templates select="//tei:publicationStmt/tei:publisher"/>
                                            </xsl:if>
                                            
                                            <xsl:if test="//tei:publicationStmt/tei:idno">
                                                <xsl:for-each select="//tei:publicationStmt/tei:idno">
                                                    <br/>
                                                    <a class="navlink" target="_blank">
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="."/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="."/>
                                                    </a>
                                                </xsl:for-each>                                                
                                            </xsl:if>
                                            
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:sourceDesc">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <span class="body_translations" title="Datenbeschreibung">Datenbeschreibung</span>
                                        </th>
                                        <td>
                                            <xsl:value-of select="//tei:sourceDesc"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:encodingDesc">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <span class="body_translations" title="Datenverarbeitung">Datenverarbeitung</span>
                                        </th>
                                        <td>
                                            <xsl:apply-templates select="//tei:encodingDesc"/>
                                        </td>
                                    </tr>
                                </xsl:if>   
                                
                                <xsl:if test="//tei:msContents">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <abbr class="body_translations" title="Regest">Regest</abbr>
                                        </th>
                                        <td>
                                            <xsl:apply-templates select="//tei:msContents"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:supportDesc/tei:extent">
                                    <tr>
                                        <th style="text-transform:uppercase;">
                                            <abbr class="body_translations" title="Extent">Extent</abbr>
                                        </th>
                                        <td>
                                            <xsl:apply-templates select="//tei:supportDesc/tei:extent"/>
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:if test="//tei:index/tei:term">
                                    <tr>
                                        <th style="text-transform:uppercase;" class="body_translations" title="Schlagworte">Schlagworte</th>
                                        <td>
                                            <xsl:for-each select="//tei:index/tei:term">
                                                <li>
                                                    <xsl:value-of select="."/>
                                                </li>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                </xsl:if>
                                
                                <xsl:choose>
                                    <xsl:when test="//tei:availability">
                                        <tr>
                                            <th style="text-transform:uppercase;">
                                                <abbr class="body_translations" title="Lizenz">Lizenz</abbr>
                                            </th>
                                            <td>
                                                <a class="navlink" target="_blank">
                                                    <xsl:attribute name="href">
                                                        <xsl:value-of select="//tei:licence/@target"/>
                                                    </xsl:attribute>
                                                    <xsl:apply-templates select="//tei:licence"/>
                                                </a>
                                            </td>
                                        </tr>
                                    </xsl:when>
                                    
                                    <xsl:otherwise>
                                        <tr>
                                            <th style="text-transform:uppercase;">
                                                <abbr class="body_translations" title="Lizenz">Lizenz</abbr>
                                            </th>
                                            <td>
                                                NA
                                            </td>
                                        </tr>
                                    </xsl:otherwise>
                                    
                                </xsl:choose>
                                
                                <xsl:if test="//tei:profileDesc">
                                    <xsl:for-each select="//tei:profileDesc/tei:textClass/tei:keywords">
                                        <tr>
                                            <th><xsl:value-of select="upper-case(@ana)"/></th>
                                            <td>
                                                <ul>
                                                    <xsl:for-each select="./tei:term">
                                                        <li><xsl:value-of select="@n"/><xsl:text> </xsl:text><xsl:value-of select="."/></li>
                                                    </xsl:for-each>   
                                                </ul>                                                
                                            </td>                                                                                       
                                        </tr>
                                    </xsl:for-each>
                                </xsl:if>       
                                
                            </tbody>
                        </table>                        
                    </div>
                    
                    <div class="modal-footer">
                        
                    </div>
                    
                </div>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>