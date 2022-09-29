$("#load_arche_metadata").on("click", function() {
    // CSS tansformations to show loader and hide content
    $("#transform").removeClass("active").addClass("fade");
    $("#home").removeClass("active").addClass("fade");
    $("#search").removeClass("active").addClass("fade");
    $("#edition").removeClass("active").addClass("fade");
    $("#about").removeClass("fade").addClass("active");
    $(".nav-link").removeClass("active show");
    var create_spinner =    `<div class="spinner-border active" role="status" 
                                id="xyz_spinner" style="width: 5rem; height: 5rem;"
                            </div>`;
    //$('#loader_wrapper').removeClass("fade").addClass("active"); 
    $('#single_wrapper').prepend(create_spinner); 
    if ($(".loading_animation_head").length !== 0) {
        var arche = "https://vocabs.acdh.oeaw.ac.at/schema#";
        var browser = "/browser/oeaw_detail/";
        var project_title = $('#project-xsl').text().toLowerCase().replace('\\s','_');
        if (localStorage.getItem(project_title.replace(".xsl","") + "_metadata") == null) {
            const query = ARCHEapi.ARCHErdfQuery;
            const downloader = ARCHEapi.ARCHEdownloadResourceIdM;
            var host = "https://arche-dev.acdh-dev.oeaw.ac.at/api";
            var format = "application/n-triples";
            var col_url = $('#child_col_url').text();
            var resourceId = col_url.replace(host + '/','');
            var readMode = 'neighbors';
            downloader(host, resourceId, format, readMode, (rs) => {
                var subject = col_url;  
                var predicate = null;
                var object = null;
                var topCollection = query(subject, predicate, object, rs);
                var accessRestrictions = "<tr><th>Zugriffsbeschränkung</th>";
                var owners = "<tr><th>Principal Investigator</th>";
                var contacts = "<tr><th>Kontakt(e)</th>";
                var contributors = '<tr><th>Mitwirkende(r)</th>';
                var creators = '<tr><th>AutorIn</th>';
                var curators = '<tr><th>KuratorIn</th>';
                var licensors = '<tr><th>LizenzgeberIn</th>';
                var licenses = '<tr><th>Lizenz</th>';
                var relatedDisciplines = '<tr><th>Verwandte Discipline</th>';
                var relatedProjects = '<tr><th>Verwandtes Projekt</th>';
                for (var i = 0; i < topCollection.length; i++) {
                    if (topCollection[i].predicate == arche + "hasTitle") {
                        $("#metadata_title").append(`<h2>${topCollection[i].object}</h2>`);
                    }
                    else if (topCollection[i].predicate == arche + "hasDescription") {
                        $("#metadata_description").append(`<p>${topCollection[i].object}</p>`);
                    }
                    else if (topCollection[i].predicate == arche + "hasSubject") {
                        $("#metadata_keywords").append(`<li>${topCollection[i].object}</li>`);              
                    }
                    else if (topCollection[i].predicate == arche + "hasAccessRestrictionSummary") {
                        accessRestrictions += `<td>${topCollection[i].object}</td>`;          
                    }
                    else if (topCollection[i].predicate == arche + "hasCreatedStartDate") {
                        $("#metadata_others").append(`<tr><th>Erstellungsdatum Anfang</th><td>${topCollection[i].object.replace("^^http://www.w3.org/2001/XMLSchema#date","")}</td></tr>`);
                    }
                    else if (topCollection[i].predicate == arche + "CreatedEndDate") {
                        $("#metadata_others").append(`<tr><th>Erstellungsdatum Ende</th><td>${topCollection[i].object.replace("^^http://www.w3.org/2001/XMLSchema#date","")}</td></tr>`);
                    }
                    else if (topCollection[i].predicate == arche + "hasNumberOfItems") {
                        $("#metadata_others").append(`<tr><th>Anzahl von Resourcen</th><td>${topCollection[i].object.replace("^^http://www.w3.org/2001/XMLSchema#decimal","")}</td></tr>`);
                    }
                    else if (topCollection[i].predicate == arche + "hasOwner") {
                        var owner = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        owners += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${owner[0].object}</a></td>`; 
                    }
                    else if (topCollection[i].predicate == arche + "hasContact") {
                        var contact = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        contacts += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${contact[0].object}</a></td>`;              
                    }
                    else if (topCollection[i].predicate == arche + "hasContributor") {
                        var contributor = query(topCollection[i].object, null, null, rs);
                        for (e = 0; e < contributor.length; e++) {
                            if (contributor[e].predicate == arche + "hasTitle") {
                                contributors += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${contributor[e].object}</a></td>`; 
                            }
                        }             
                    }
                    else if (topCollection[i].predicate == arche + "hasCreator") {
                        var creator = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        creators += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${creator[0].object}</a></td>`;              
                    }
                    else if (topCollection[i].predicate == arche + "hasCurator") {
                        var curator = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        curators += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${curator[0].object}</a></td>`;              
                    }
                    else if (topCollection[i].predicate == arche + "hasLicensor") {
                        var licensor = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        licensors += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${licensor[0].object}</a></td>`;              
                    }
                    else if (topCollection[i].predicate == arche + "hasLicense") {
                        var license = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        licenses += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${license[0].object}</a></td>`;              
                    }
                    else if (topCollection[i].predicate == arche + "hasRelatedDiscipline") {
                        var relatedDiscipline = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        relatedDisciplines += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${relatedDiscipline[0].object}</a></td>`;              
                    }
                    else if (topCollection[i].predicate == arche + "hasRelatedProject") {
                        var relatedProject = query(topCollection[i].object, arche + "hasTitle", null, rs);
                        relatedProjects += `<td><a target="_blank" href="${topCollection[i].object.replace('/api/',browser)}">${relatedProject[0].object}</a></td>`;              
                    }
                }
                $("#metadata_person").append(owners + "</tr>").append(contacts + '</tr>').append(contributors + '</tr>').append(creators + '</tr>').append(curators + '</tr>');   
                $("#metadata_rights").append(accessRestrictions + "</tr>").append(licensors + '</tr>').append(licenses + '</tr>');   
                $("#metadata_others").append(relatedDisciplines + '</tr>').append(relatedProjects + '</tr>');

                $(".loading_animation").remove();
                $(".loading_animation_head").remove();    
                $("#metadata_keyword").append("<h3>Schlagwörter</h3>");    
                $("#metadata_actor").append("<h3>Akteure</h3>");   
                $("#metadata_right").append("<h3>Rechte</h3>");   
                $("#metadata_other").append("<h3>Weitere Informationen</h3>");          

                $(".spinner-border").remove();           
                $("#aboutEnd").removeClass("fade").addClass("active");
                localStorage.setItem(project_title.replace(".xsl","") + "_metadata_titles", JSON.stringify({
                    metadata_titles:[{
                        owners: owners,
                        contacts: contacts,
                        contributors: contributors,
                        creators: creators,
                        curators: curators,
                        licensors: licensors,
                        licenses: licenses,
                        relatedDisciplines: relatedDisciplines,
                        relatedProjects: relatedProjects,
                        accessRestrictions: accessRestrictions
                    }] 
                }));
                localStorage.setItem(project_title.replace(".xsl","") + "_metadata", JSON.stringify({topCollection: topCollection}));
            }); 
        } else {
            var metadata_cache = JSON.parse(localStorage.getItem(project_title.replace(".xsl","") + "_metadata"));
            var metdata_title_cache = JSON.parse(localStorage.getItem(project_title.replace(".xsl","") + "_metadata_titles"));
            for (var i = 0; i < metadata_cache.topCollection.length; i++) {
                if (metadata_cache.topCollection[i].predicate == arche + "hasTitle") {
                    $("#metadata_title").append(`<h2>${metadata_cache.topCollection[i].object}</h2>`);
                }
                else if (metadata_cache.topCollection[i].predicate == arche + "hasDescription") {
                    $("#metadata_description").append(`<p>${metadata_cache.topCollection[i].object}</p>`);
                }
                else if (metadata_cache.topCollection[i].predicate == arche + "hasSubject") {
                    $("#metadata_keywords").append(`<li>${metadata_cache.topCollection[i].object}</li>`);              
                }
                else if (metadata_cache.topCollection[i].predicate == arche + "hasCreatedStartDate") {
                    $("#metadata_others").append(`<tr><th>Erstellungsdatum Anfang</th><td>${metadata_cache.topCollection[i].object.replace("^^http://www.w3.org/2001/XMLSchema#date","")}</td></tr>`);
                }
                else if (metadata_cache.topCollection[i].predicate == arche + "CreatedEndDate") {
                    $("#metadata_others").append(`<tr><th>Erstellungsdatum Ende</th><td>${metadata_cache.topCollection[i].object.replace("^^http://www.w3.org/2001/XMLSchema#date","")}</td></tr>`);
                }
                else if (metadata_cache.topCollection[i].predicate == arche + "hasNumberOfItems") {
                    $("#metadata_others").append(`<tr><th>Anzahl von Resourcen</th><td>${metadata_cache.topCollection[i].object.replace("^^http://www.w3.org/2001/XMLSchema#decimal","")}</td></tr>`);
                }
            }    
            for (var i = 0; i < metdata_title_cache.metadata_titles.length; i++) {
                if (metdata_title_cache.metadata_titles[i].owners) {
                    $("#metadata_person").append(metdata_title_cache.metadata_titles[i].owners);
                }
                if (metdata_title_cache.metadata_titles[i].contacts) {
                    $("#metadata_person").append(metdata_title_cache.metadata_titles[i].contacts);        
                }
                if (metdata_title_cache.metadata_titles[i].accessRestrictions) {
                    $("#metadata_rights").append(metdata_title_cache.metadata_titles[i].accessRestrictions);   
                }
                if (metdata_title_cache.metadata_titles[i].contributors) {
                    $("#metadata_person").append(metdata_title_cache.metadata_titles[i].contributors);     
                }
                if (metdata_title_cache.metadata_titles[i].creators) {
                    $("#metadata_person").append(metdata_title_cache.metadata_titles[i].creators);       
                }
                if (metdata_title_cache.metadata_titles[i].curators) {
                    $("#metadata_person").append(metdata_title_cache.metadata_titles[i].curators);              
                }
                if (metdata_title_cache.metadata_titles[i].licensors) {
                    $("#metadata_rights").append(metdata_title_cache.metadata_titles[i].licensors);              
                }
                if (metdata_title_cache.metadata_titles[i].licenses) {
                    $("#metadata_rights").append(metdata_title_cache.metadata_titles[i].licenses);               
                }
                if (metdata_title_cache.metadata_titles[i].relatedDisciplines) {
                    $("#metadata_others").append(metdata_title_cache.metadata_titles[i].relatedDisciplines);              
                }
                if (metdata_title_cache.metadata_titles[i].relatedProjects) {
                    $("#metadata_others").append(metdata_title_cache.metadata_titles[i].relatedProjects);            
                }
            }
            $(".loading_animation").remove();
            $(".loading_animation_head").remove();    
            $("#metadata_keyword").append("<h3>Schlagwörter</h3>");    
            $("#metadata_actor").append("<h3>Akteure</h3>");   
            $("#metadata_right").append("<h3>Rechte</h3>");   
            $("#metadata_other").append("<h3>Weitere Informationen</h3>");    
            $(".spinner-border").remove();           
            $("#aboutEnd").removeClass("fade").addClass("active");
        }
    }    
});