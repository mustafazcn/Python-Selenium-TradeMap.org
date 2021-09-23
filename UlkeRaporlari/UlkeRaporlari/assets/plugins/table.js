(function ($) {
    function get_Button(mode, primary_keys, text, data_field) {
        if (primary_keys.length == 1) {
            return {
                "width": "100px",
                "render": function (data2, data1, data) {
                    if (data[data_field] == undefined) {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '">' + text + '</a>';
                    }
                    else {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '">' + data[data_field] + text + '</a>';
                    }

                }
            }
        }
        else if (primary_keys.length == 2) {
            return {
                "width": "100px",
                "render": function (data2, data1, data) {
                    if (data[data_field] == undefined) {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '">' + text + '</a>';
                    }
                    else {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '">' + data[data_field] + text + '</a>';
                    }
                }
            }
        }
        else if (primary_keys.length == 3) {
            return {
                "data": "",
                "width": "100px",
                "render": function (data2, data1, data) {
                    if (data[data_field] == undefined) {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '" data-data3="' + data[primary_keys[2]] + '">' + text + '</a>';
                    }
                    else {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '" data-data3="' + data[primary_keys[2]] + '">' + data[data_field] + text + '</a>';
                    }
                }
            }
        }
        else if (primary_keys.length == 4) {
            return {
                "width": "100px",
                "render": function (data2, data1, data) {
                    if (data[data_field] == undefined) {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '" data-data3="' + data[primary_keys[2]] + '" data-data4="' + data[primary_keys[3]] + '">' + text + '</a>';
                    }
                    else {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '" data-data3="' + data[primary_keys[2]] + '" data-data4="' + data[primary_keys[3]] + '">' + data[data_field] + text + '</a>';
                    }

                }
            }
        }
        else if (primary_keys.length == 5) {
            return {
                "width": "100px",
                "render": function (data2, data1, data) {
                    if (data[data_field] == undefined) {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '" data-data3="' + data[primary_keys[2]] + '" data-data4="' + data[primary_keys[3]] + '" data-data5="' + data[primary_keys[4]] + '" >' + text + '</a>';
                    }
                    else {
                        return '<a class="popup" data-add-tab="" data-mode="' + mode + '" data-data1="' + data[primary_keys[0]] + '"  data-data2="' + data[primary_keys[1]] + '" data-data3="' + data[primary_keys[2]] + '" data-data4="' + data[primary_keys[3]] + '" data-data5="' + data[primary_keys[4]] + '" >' + data[data_field] + text + '</a>';
                    }

                }
            }
        }
    }

    $.fn.DataTableT = function (properties) {
        columns = [];
        for (var i = 0; i < properties.columns.length; i++) {
            if (properties.columns[i].column_type === "data") {
                columns.push({
                    "data": properties.columns[i].column_data_field, "autoWidth": true,
                    "render": function (value, x) {
                        if (value == null) return "";
                        if (value == undefined) return "";
                        //Kaan Kandemir
                        if ($.isNumeric(value)) return value;
                        if (value.indexOf("Date") != -1) {
                            return moment(value).format('DD/MM/YYYY');
                        }
                        else {
                            return value;
                        }
                    }
                });
            }
            else if (properties.columns[i].column_type == "button") {
                columns.push(get_Button(properties.columns[i].column_mode, properties.columns[i].column_primarykeys, properties.columns[i].column_text, properties.columns[i].column_data_field));
            }
        }
        var oTable = $(this).DataTable({
            "ajax": {
                "url": properties.url,
                "type": "get",
                "datatype": "json"
            },
            destroy: true,
            "columns": columns,
            "language": {
                "url": "/Content/plugins/datatable/Turkish.json"
            },
            dom: 'Bfrtip'
            ,
            buttons: [
                //'excel', 'pdf', 'print'
            ]
        });
    }
}(jQuery));