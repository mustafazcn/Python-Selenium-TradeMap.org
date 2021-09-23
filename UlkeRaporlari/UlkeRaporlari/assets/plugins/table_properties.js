var hoca_bolum_getir = {
    url: '/Academician/Home/GetHocaBolumler_/',
    columns: [
        { column_type: "data", column_data_field: "universiteAdi" }
        , { column_type: "data", column_data_field: "fakulteAdi" }
        , { column_type: "data", column_data_field: "bolumAdi" }
        , { column_type: "data", column_data_field: "hocaBolumBasTarih" }
        , { column_type: "data", column_data_field: "hocaBolumBitTarih" }
        , { column_type: "button", column_mode: "HocaBolumGuncelle", column_text: "Güncelle", column_primarykeys: ["hocaBolumID"] }
        , { column_type: "button", column_mode: "HocaBolumSil", column_text: "Sil", column_primarykeys: ["hocaBolumID"] }
    ]
};

var hoca_egitimBilgi_getir = {
    url: '/Academician/Home/GetHocaEgitimBilgi_/' + $("#hdnHocaID").val(),
    columns: [
        { column_type: "data", column_data_field: "hocaEgitimBilgiUniversiteAdi" }
        , { column_type: "data", column_data_field: "hocaEgitimBilgiFakulteAdi" }
        , { column_type: "data", column_data_field: "hocaEgitimBilgiBolumAdi" }
        , { column_type: "data", column_data_field: "akademikUnvanAdi" }
        , { column_type: "data", column_data_field: "hocaEgitimBilgiBasTarih" }
        , { column_type: "data", column_data_field: "hocaEgitimBilgiBitTarih" }
        , { column_type: "button", column_mode: "HocaEgitimBilgiGuncelle", column_text: "Güncelle", column_primarykeys: ["hocaEgitimBilgiID", "HocaID"] }
        , { column_type: "button", column_mode: "HocaEgitimBilgiSil", column_text: "Sil", column_primarykeys: ["hocaEgitimBilgiID"] }
    ]
};
