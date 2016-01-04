// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .



function newSearchField(){
    var template = $("#search-template");
    var temp = template.clone();
    var num = "" + (Number(template.attr("num")) + 1);
    template.attr("num", num);
    temp.find(".operator").attr("name", "operator" + num);
    temp.find(".search-box").attr("name", "text" + num);
    temp.find(".field").attr("name", "field" + num);
    $("#number").attr("value", num);
    temp.attr("num", template.attr("num"));

    temp.attr("id", "");
    temp.addClass("field-cont");
    temp.insertBefore("#ghost").show();

}

function submitSearch(){
    $("#search-form").submit();
}
function submitSubmission(){
    var authors = ""
    authors += $("#author1").val();
    if ($("#author2").val()){
        authors +="," + $("#author2").val();
        if ($("#author3").val()){
            authors += "," + $("#author3").val();
        }
    } 
    $("#authors-field").val(authors);
    $('#new_submission').submit()
}

$(document).ready(function() {
    $('.subject-checkbox').change(function() {
        var terms = [];
        $(".subject-checkbox").each(function(index, elem){
            if (elem.checked){
                terms.push($(elem).attr("subject"));
            } 
        });
        $(".entry").each(function(index, elem){
            $(elem).show();
            var inc = true;
            var subjects = $(elem).attr("subjects").split(",");
            for (var i = 0; i < terms.length; i++){
                if (subjects.indexOf(terms[i]) < 0){
                    $(elem).hide();
                    continue;
                }
            }
        });
    });
});