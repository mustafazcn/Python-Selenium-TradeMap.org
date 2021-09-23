$(document).ready(function () {
    var buttonadd = "";//'<span><button class="btn btn-success btn-add" type="button"><span class="glyphicon glyphicon-plus"></span></button></span>';
    //var fvrhtmlclone = '<div class="fvrclonned">' + $(".fvrduplicate").html() + buttonadd + '</div>';
    var fvrhtmlclone = $(".fvrduplicate").html() + buttonadd;
    //$(".fvrduplicate").html(fvrhtmlclone);
    //$(".fvrduplicate").after('<div class="fvrclone"></div>');

    $(document).on('click', '.btn-add', function (e) {
        e.preventDefault();
        fvrhtmlclone = $(".fvrduplicate").html() + buttonadd;
        $(".fvrclone").append(fvrhtmlclone.replace("remove", "add").replace("danger", "success").replace("minus", "plus").replace('title="Sil"', 'title="Yeni"'));

        $(this).removeClass('btn-add').addClass('btn-remove')
            .removeClass('btn-success').addClass('btn-danger')
            .html('<span class="glyphicon glyphicon-minus"></span>').attr("title","Sil");
    }).on('click', '.btn-remove', function (e) {
        $(this).parents('.fvrclonned').remove();
        e.preventDefault();
        return false;
    });

});

function showValues() {
    var fields = $(":input").serializeArray();
    $("#results").empty();
    jQuery.each(fields, function (i, field) {
        $("#results").append(field.value + " ");
    });
}
//Duplicate grup end