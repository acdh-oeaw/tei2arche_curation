$("#ajax_request").on("click", function() {
    // CSS tansformations to show loader and hide content   
    $("#about").removeClass("active").addClass("fade");
    $("#transform").removeClass("active").addClass("fade");
    $("#home").removeClass("active").addClass("fade");
    $("#search").removeClass("active").addClass("fade");
    $("#edition").removeClass("fade").addClass("active");
    $(".nav-link").removeClass("active show");
    var project_title = $('#project-xsl').text().toLowerCase().replace('\\s','_');
    // building the html table
    var teiSource = $('#tei_source').text() + '/';
    var browser = "/browser/oeaw_detail/";
    var rdfxml = "/metadata?format=application/rdf%2Bxml";
    var transform = "?format=customTei2Html";
    var turtle = "/metadata";
    if ($('#tableAjax_wrapper').length == 0) { 
        var create_spinner =    `<div id="loader_wrapper" class="text-center"> 
                                    <div class="spinner-border active" role="status" 
                                        id="xyz_spinner" style="width: 5rem; height: 5rem;"
                                    </div>
                                </div>`;        
        $('#single-wrapper').prepend(create_spinner);
        if (localStorage.getItem(project_title.replace(".xsl","")) == null) {
            const downloader = ARCHEapi.ARCHEdownloadResourceIdM;
            const query = ARCHEapi.ARCHErdfQuery;
            const left_join = ARCHEapi.ARCHEmatchJSON;
            var host = "https://arche.acdh.oeaw.ac.at/api";
            var format = "application/n-triples";
            var col_url = $('#child_col_url').text();
            var resourceId = col_url.replace(host + '/','');
            var readMode = 'neighbors';
            downloader(host, resourceId, format, readMode, function(rs) {
                var subject = null;
                var predicate = "https://vocabs.acdh.oeaw.ac.at/schema#isPartOf";
                var object = col_url;
                var resources = query(subject, predicate, object, rs);   
                var subject = null;
                var predicate = "https://vocabs.acdh.oeaw.ac.at/schema#hasTitle";
                var object = null;
                var titles = query(subject, predicate, object, rs);  
                var predicate = "https://vocabs.acdh.oeaw.ac.at/schema#hasFilename";
                var files = query(subject, predicate, object, rs);                          
                var result = left_join(resources, titles);
                var result2 = left_join(resources, files);
                var tbodyOpen = "<tbody>";
                var tbodyClose = "</tbody>";
                if (result2.length !== 0) {
                    var thead = `<thead>
                                    <tr>
                                        <th class="body_translations" title="Dokumenttitel">Dokumenttitel</th>
                                        <th class="body_translations" title="TEI/XML zu HTML">TEI/XML zu HTML</th>
                                        <th title="ARCHE">ARCHE</th>
                                        <th title="RDF/XML">RDF/XML</th>
                                        <th title="RDF/TURTLE">RDF/TURTLE</th>
                                    </tr>
                                </thead>`; 
                    for (var i = 0; i < result.length; i++) {
                        tbodyOpen += `<tr>
                        <td>${result[i].object}</td>
                        <td><a href=${teiSource + result2[i].object + transform} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                        <td><a href=${result[i].subject.replace('/api/', browser)} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                        <td><a href=${result[i].subject + rdfxml} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>            
                        <td><a href=${result[i].subject + turtle} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                        </tr>`; 
                    } 
                } else {
                    var thead = `<thead>
                                    <tr>
                                        <th class="body_translations" title="klicken um zu aktivieren"><a style="color: #3E91BB !important;" onclick="load_resources()"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                                        </svg>Download</a></th>
                                        <th class="body_translations" title="Dokumenttitel">Dokumenttitel</th>
                                        <th title="ARCHE">ARCHE</th>
                                        <th title="RDF/XML">RDF/XML</th>
                                        <th title="RDF/TURTLE">RDF/TURTLE</th>
                                    </tr>
                                </thead>`; 
                    for (var i = 0; i < result.length; i++) {
                        var dl_id = "resource_" + Math.ceil(Math.random() * 10) + Math.ceil(Math.random() * 10) +Math.ceil(Math.random() * 10);
                        tbodyOpen += `<tr>
                        <td><a class="load_resources fade" id="${dl_id}" title="${result[i].object}" data-target="${result[i].subject}"  href="${'#liveToast_anchor_' + dl_id}"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                        </svg></a></td>
                        <td>${result[i].object}</td>
                        <td><a href=${result[i].subject.replace('/api/', browser)} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                        <td><a href=${result[i].subject + rdfxml} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>            
                        <td><a href=${result[i].subject + turtle} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                        </tr>`; 
                    } 
                }  
                var tbody = tbodyOpen.concat(tbodyClose); 
                $("#tableAjax").append(thead);      
                $("#tableAjax").append(tbody);
                if (document.getElementById("tableAjax_wrapper") === null) {
                    // Transform table to DataTable
                    $('#tableAjax').DataTable({
                        "language": {
                            "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json"
                        },
                        dom: 'fpBirtp',
                        buttons:['copy', 'excel', 'pdf'],
                        "lengthMenu":[25, 50, 75, 100, "All"],
                        responsive: true,
                        orderCellsTop: true,
                        "pageLength": 50,
                        keepConditions: true                    
                    }); 
                }
                $("#loader_wrapper").remove();              
                $("#loaderEnd").removeClass("fade").addClass("active");         
                localStorage.setItem(project_title.replace(".xsl",""), JSON.stringify({title: result}));
                localStorage.setItem(project_title.replace(".xsl","") + '_2', JSON.stringify({file: result2})); 
            });
        } else {
            var storage = JSON.parse(localStorage.getItem(project_title.replace(".xsl","")));
            var storage2 = JSON.parse(localStorage.getItem(project_title.replace(".xsl","") + '_2')); 
            var tbodyOpen = "<tbody>";
            var tbodyClose = "</tbody>";           
            if (storage2.file.length !== 0) {
                var thead = `<thead>
                                <tr>
                                    <th class="body_translations" title="Dokumenttitel">Dokumenttitel</th>
                                    <th class="body_translations" title="TEI/XML zu HTML">TEI/XML zu HTML</th>
                                    <th title="ARCHE">ARCHE</th>
                                    <th title="RDF/XML">RDF/XML</th>
                                    <th title="RDF/TURTLE">RDF/TURTLE</th>
                                </tr>
                            </thead>`;
                for (var i = 0; i < storage.title.length; i++) {                
                    tbodyOpen += `<tr>
                    <td>${storage.title[i].object}</td>
                    <td><a href=${teiSource + storage2.file[i].object + transform} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                    <td><a href=${storage.title[i].subject.replace('/api/', browser)} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                    <td><a href=${storage.title[i].subject + rdfxml} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>            
                    <td><a href=${storage.title[i].subject + turtle} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                    </tr>`;  
                }
                    
            } else {
                var thead = `<thead>
                                <tr>
                                    <th class="body_translations" title="klicken um zu aktivieren"><a style="color: #3E91BB !important;" onclick="load_resources()"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                                    </svg>Download</a></a></th>
                                    <th class="body_translations" title="Dokumenttitel">Dokumenttitel</th>
                                    <th title="ARCHE">ARCHE</th>
                                    <th title="RDF/XML">RDF/XML</th>
                                    <th title="RDF/TURTLE">RDF/TURTLE</th>
                                </tr>
                            </thead>`;
                for (var i = 0; i < storage.title.length; i++) { 
                    var dl_id = "resource_" + Math.ceil(Math.random() * 10) + Math.ceil(Math.random() * 10) +Math.ceil(Math.random() * 10);               
                    tbodyOpen += `<tr>
                    <td><a class="load_resources fade" id="${dl_id}" title="${storage.title[i].object}" data-target="${storage.title[i].subject}" href="${'#liveToast_anchor_' + dl_id}"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
                    </svg></a></td>
                    <td>${storage.title[i].object}</td>
                    <td><a href=${storage.title[i].subject.replace('/api/', browser)} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                    <td><a href=${storage.title[i].subject + rdfxml} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>            
                    <td><a href=${storage.title[i].subject + turtle} target="_blank" class="body_translations" title="Öffnen">Öffnen</a></td>
                    </tr>`; 
                }
            }     
            var tbody = tbodyOpen.concat(tbodyClose);
            $("#tableAjax").append(thead);       
            $("#tableAjax").append(tbody);
            if (document.getElementById("tableAjax_wrapper") === null) {
                // Transform table to DataTable
                $('#tableAjax').DataTable({
                    "language": {
                        "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json"
                    },
                    dom: 'fpBirtp',
                    buttons:['copy', 'excel', 'pdf'],
                    "lengthMenu":[25, 50, 75, 100, "All"],
                    responsive: true,
                    orderCellsTop: true,
                    "pageLength": 50,
                    keepConditions: true                    
                }); 
            }
            $("#loader_wrapper").remove();           
            $("#loaderEnd").removeClass("fade").addClass("active");
        }  
    }         
});