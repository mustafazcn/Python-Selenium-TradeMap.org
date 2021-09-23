$(document).ready(function () {
    $("#selectYillar").on('change', function () {
        var yil = $("#selectYillar :selected").val();
        var tblDosyalar = $("#dosyalar").DataTable();
        if (yil == "Tümü")
            location.reload();
        else
            tblDosyalar.search(yil).draw();
    });

    $("body").on("click", "a[data-mode]", function () {
        var mode = $(this).data("mode");
        var formData = new FormData();
        var buton = $(this);


        if (mode === "AkrediteMaddeGuncelle")
        {
            $(buton).data('url', "/Partial/GetAkrediteForm");
            formData.append("AkrediteMaddeID", $(buton).data("data1"));
            ButtonExecute("partial", "", this, formData, function () {
                $("#mdl").modal("show");
            }, function () { }, "false", "#dvMdlDialog");
        }
        else if (mode === "AkrediteMaddeIslem") {
            $(buton).data('url', "/Home/AkrediteMaddeIslem/");
            formData.append("AkrediteMaddeID", $(buton).data("data1"));
            formData.append("type", "Kaydet");
            if (FormValidate(buton)) {
                ButtonExecute("post", "#mdlForm", this, formData, function (result) {
                    if (result.split("|")[0] === "Ok") {
                        location.reload();
                    }
                    else {
                        alert_v1("Hata", result.split("|")[1], function () { });
                    }
                }, function () { }, "false", "");
            }
        }
        else if (mode === "AkrediteSil") {
            $(buton).data('url', "/Partial/GetAkrediteSil/");
            ButtonExecute("modal", "#", buton, formData, function () {
            }, function () { }, "true", "#");
        }
        else if (mode === "AkrediteSilTamamla") {
            $(buton).data('url', "/Home/AkrediteMaddeIslem/");
            formData.append("AkrediteMaddeID", $(buton).data("data1"));
            formData.append("type", "Sil");
            if (FormValidate(buton)) {
                ButtonExecute("post", "#mdlForm", this, formData, function (result) {
                    if (result.split("|")[0] === "Ok") {
                        location.reload();
                    }
                    else {
                        alert_v1("Hata", result.split("|")[1], function () { });
                    }
                }, function () { }, "false", "");
            }
        }



        if (mode === "DosyaGuncelle") {
            $(buton).data('url', "/Partial/GetDosyaForm");
            formData.append("DosyaID", $(buton).data("data1"));
            ButtonExecute("partial", "", this, formData, function () {
                $("#mdl").modal("show");
            }, function () { }, "false", "#dvMdlDialog");
        }
        else if (mode === "DosyaIslem") {
            $(buton).data('url', "/Home/DosyaIslem/");
            formData.append("DosyaID", $(buton).data("data1"));
            formData.append("type", "Kaydet");
            if (FormValidate(buton)) {
                ButtonExecute("post", "#mdlForm", this, formData, function (result) {
                    if (result.split("|")[0] === "Ok") {
                        location.reload();
                    }
                    else {
                        alert_v1("Hata", result.split("|")[1], function () { });
                    }
                }, function () { }, "false", "");
            }
        }
        else if (mode === "DosyaSil") {
            $(buton).data('url', "/Partial/GetDosyaSil/");
            ButtonExecute("modal", "#", buton, formData, function () {
            }, function () { }, "true", "#");
        }
        else if (mode === "DosyaSilTamamla") {
            $(buton).data('url', "/Home/DosyaIslem/");
            formData.append("DosyaID", $(buton).data("data1"));
            formData.append("type", "Sil");
            if (FormValidate(buton)) {
                ButtonExecute("post", "#mdlForm", this, formData, function (result) {
                    if (result.split("|")[0] === "Ok") {
                        location.reload();
                    }
                    else {
                        alert_v1("Hata", result.split("|")[1], function () { });
                    }
                }, function () { }, "false", "");
            }
        }
        
    });
});