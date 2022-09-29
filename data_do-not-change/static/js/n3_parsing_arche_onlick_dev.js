function load_resources() {
    $(".load_resources").removeClass("fade").addClass("active");
    $(".load_resources").on("click", function() {
        var rs_id = $(this).attr('id');
        $('#' + "liveToast_" + rs_id).toast('show');       
        if ($("#" + "liveToast_" + rs_id).length == 0) {
            var rs_title = $(this).attr('title');
            $(this).children('svg').remove();
            var spinner = `<div id="${rs_id + "_spinner"}" class="spinner-border spinner-border-sm" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>` 
            $(this).append(spinner);
            var toast = `<div class="anchor" id="${"liveToast_anchor_" + rs_id}"/>
                        <div class="toast" id="${"liveToast_" + rs_id}" role="alert" aria-live="assertive" aria-atomic="true">
                            <div class="toast-header">
                                <strong class="me-auto">ARCHE Download</strong>
                                <small>${rs_title}</small>
                                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="toast-body" id="${rs_id + "_toast_body"}">
                                <div id="${rs_id + "_toast_progress_wrapper"}" class="text-center">
                                    ${spinner}
                                </div>
                            </div>
                        </div>`;                       
            $('#toast_styles').css('min-height', '1px');
            $('#toast_wrapper').prepend(toast);
            $(".toast").toast({ autohide: false });
            $('#' + "liveToast_" + rs_id).toast('show'); 
            //var project_title = $('#project-xsl').text().toLowerCase().replace('\\s','_');
            const downloader = ARCHEapi.ARCHEdownloadResourceIdM;
            const query = ARCHEapi.ARCHErdfQuery;
            const left_join = ARCHEapi.ARCHEmatchJSON;
            const full_join = ARCHEapi.ARCHEmatchJSON1;
            var host = "https://arche-dev.acdh-dev.oeaw.ac.at/api";
            var format = "application/n-triples";
            var col_url = $(this).attr('data-target');
            var resourceId = col_url.replace(host + '/','');
            var readMode = 'neighbors';
            var browser = "/browser/oeaw_detail/";
            var transform = "?format=customTei2Html";
            var arche = "https://vocabs.acdh.oeaw.ac.at/schema#";
            var tei_source = $('#tei_source').text();
            downloader(host, resourceId, format, readMode, function(rs) {
                var subject = null;
                var predicate = arche + "isPartOf";
                var object = col_url;
                var resources = query(subject, predicate, object, rs);
                var predicate = arche + "hasTitle";
                var object = null;
                var titles = query(subject, predicate, object, rs);
                var predicate = arche + "hasFilename";
                var files = query(subject, predicate, object, rs);
                var left_joined = left_join(resources, titles);
                var full_joined = full_join(left_joined, files);
                var resourceFiles = "";
                for (var i = 0; i < full_joined.length; i++) {
                    resourceFiles +=   `<tr>
                                            <td>
                                                <a title="${full_joined[i].object}" alt="${full_joined[i].object}" target="_blank" 
                                                    href="${tei_source + "/" + full_joined[i].object1 + transform}">
                                                    ${full_joined[i].object}
                                                </a>
                                            </td>
                                            <td>
                                                <a title="ARCHE" alt="ARCHE" target="_blank" 
                                                    href="${full_joined[i].subject.replace('/api/', browser)}">
                                                    Öffnen
                                                </a>
                                            </td>
                                            <td>
                                                <a title="RDF/Turtle" alt="RDF/Turtle" target="_blank" 
                                                    href="${full_joined[i].subject + "/metadata"}">
                                                    Öffnen
                                                </a>
                                            </td>
                                            <td>
                                                <a title="RDF/XML" alt="RDF/XML" target="_blank" 
                                                    href="${full_joined[i].subject + "/metadata?format=application/rdf%2Bxml"}">
                                                    Öffnen
                                                </a>
                                            </td>
                                        </tr>`;
                }
                var rs_modal = `<div class="modal fade" id="${rs_id + '_toast_rs_link'}" tabindex="-1" aria-labelledby="downloadModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="downloadModalLabel">${rs_title}</h5>
                                                <button type="button" class="ml-2 mb-1 close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body table-responsive">
                                                <table id="${rs_id + '_modal_table'}" class="table table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th>Name</th>
                                                            <th>ARCHE</th>
                                                            <th>RDF/Turtle</turtle>
                                                            <th>RDF/XML</turtle>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        ${resourceFiles}
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>`;
                var rs_link = `<button class="btn btn-primary" type="button" data-target="${'#' + rs_id + '_toast_rs_link'}" data-toggle="modal" title="Resourcen anzeigen" alt="Resourcen anzeigen">
                                <span>Einträge anzeigen</span>
                                </button>`
                $('#' + rs_id + '_toast_progress_wrapper').remove();
                $('#single-wrapper').append(rs_modal);
                $('#' + rs_id + '_modal_table').DataTable({
                    "language": {
                        "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/German.json"
                    },
                    dom: 'fpBirtp',
                    buttons:['copy', 'excel', 'pdf'],
                    "lengthMenu":[25, 50, 75, 100, "All"],
                    responsive: false,
                    orderCellsTop: true,
                    "pageLength": 25,
                    keepConditions: true                    
                });
                $('#' + rs_id + '_toast_body').append(rs_link);
                $('#' + rs_id + "_spinner").remove();
                $('#' + rs_id).append('anzeigen');
            });
        }
    });  
};