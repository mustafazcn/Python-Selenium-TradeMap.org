function IsValidEmailAddress(Text) {
    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
    return pattern.test(Text);
}

function IsValidDate(Text) {
    var pattern = /^(0[1-9]|[12][0-9]|3[01])[\- \/.](?:(0[1-9]|1[012])[\- \/.](201)[2-9]{1})$/;
    return pattern.test(Text);
}

function IsValidTel(Text) {
    var pattern = /^(05)[0-9][0-9][1-9]([0-9]){6}$/;
    return pattern.test(Text.replace(/\D+/g, ""));
}

function IsValidTC(Text) {
    Text = Text.toString();
    var isEleven = /^[0-9]{11}$/.test(Text);
    var totalX = 0;
    for (var i = 0; i < 10; i++) {
        totalX += Number(Text.substr(i, 1));
    }
    var isRuleX = totalX % 10 == Text.substr(10, 1);
    var totalY1 = 0;
    var totalY2 = 0;
    for (var i = 0; i < 10; i += 2) {
        totalY1 += Number(Text.substr(i, 1));
    }
    for (var i = 1; i < 10; i += 2) {
        totalY2 += Number(Text.substr(i, 1));
    }
    var isRuleY = ((totalY1 * 7) - totalY2) % 10 == Text.substr(9, 0);
    return isEleven && isRuleX && isRuleY;
}

////////////////////////

var success_message = "İşleminiz başarıyla tamamlandı";
var error_message = "İşleminiz tamamlanırken bir hata meydana geldi";

var error_message_template = "<span class=\"error\" style=\"color:red;\">{message}</span>";
var success_message_template = "<span class=\"error\" style=\"color:green;\">{message}</span>";

var tc_error_message = "Girilen kimlik numarası formatı yanlış";
var tc_used_error_message = "Girmiş olduğunuz kimlik numarası başka biri tarafından kullanılmaktadır.";
var tc_not_used_error_message = "Girmiş olduğunuz kimlik numarası sistemde kayıtlı bulunmamaktadır.";
var tc_success_message = "Girmiş olduğunuz kimlik numarası uygun.";

var email_error_message = "Girilen email formatı yanlış";
var email_used_error_message = "Girmiş olduğunuz email adresi başka biri tarafından kullanılmaktadır.";
var email_not_used_error_message = "Girmiş olduğunuz email adresi sistemde kayıtlı bulunmamaktadır.";
var email_success_message = "Girmiş olduğunuz email adresi uygun.";

var tel_error_message = "Girilen telefon formatı yanlış";
var date_error_message = "Girilen tarih formatı yanlış";
var text_error_message = "Text alanı boş geçilemez";
var select_error_message = "Seçim alanı boş geçilemez";
var file_error_message = "Dosya seçimi yapınız";
var checkbox_error_message = "Lütfen işaretleyiniz.";
var password_error_message = "Lütfen şifre giriniz.";

function FormValidate(Item) {
    var group_name = $(Item).data("group_name");
    if (group_name == undefined) return true;

    if (group_name == undefined) {
        return false;
    }

    else {
        var is_validate = true;
        var scope_ = 'input,select,textarea';
        var modal_message_template = "";
        var min_error_input_height = 10000;
        var moving_scroll_bar = $(Item).data("moving_scroll_bar");

        $(scope_).each(function () {
            var is_sub_validate = true;
            var value = $(this).val();
            var required = $(this).data("required");
            var sub_group_name = $(this).data("group_name");
            var type = $(this).attr("type");
            var error_message = $(this).data("error_message");

            var error_format_message = $(this).data("error_format_message");
            var max_lenght = $(this).data("max_lenght");
            var error_max_lenght_message = $(this).data("error_max_lenght_message");

            var form_group = $(this).closest("div");//$(this).closest(".form-group");
            var error_message_template_temp = error_message_template;
            var message_type = $(this).data("message_type");

            $(form_group).find(".error").remove();
            if (required === true && sub_group_name === group_name) {
                if (type === "email") {
                    if (value.trim() === "") {
                        error_message = error_message == undefined ? email_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                    else if (!IsValidEmailAddress(value)) {
                        error_format_message = error_format_message == undefined ? email_error_message : error_format_message;
                        error_message = error_format_message == undefined ? error_message : error_format_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }

                    if (max_lenght != undefined && value.length > max_lenght) {
                        error_max_lenght_message = error_max_lenght_message == undefined ? email_error_message : error_max_lenght_message;
                        error_message = error_max_lenght_message == undefined ? error_message : error_max_lenght_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_max_lenght_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                if (type === "tel") {
                    if (value.trim() === "") {
                        error_message = error_message == undefined ? tel_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                    else if (!IsValidTel(value)) {
                        error_message = error_message == undefined ? tel_error_message : error_message;
                        error_message = error_format_message == undefined ? error_message : error_format_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }

                    if (max_lenght != undefined && value.length > max_lenght) {
                        error_max_lenght_message = error_max_lenght_message == undefined ? tel_error_message : error_max_lenght_message;
                        error_message = error_max_lenght_message == undefined ? error_message : error_max_lenght_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_max_lenght_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                else if (type === "date") {
                    if (value.trim() === "") {
                        error_message = error_message == undefined ? date_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                    else if (!IsValidDate(value)) {
                        error_message = error_message == undefined ? date_error_message : error_message;
                        error_message = error_format_message == undefined ? error_message : error_format_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                else if (type === "text" || type === "textarea") {
                    if ($(this).data("sub_type") === "tc") {
                        if (!IsValidTC(value)) {
                            error_message = error_message == undefined ? tc_error_message : error_message;
                            error_message = error_format_message == undefined ? error_message : error_format_message;
                            error_message_template_temp = error_message_template.replace("{message}", error_message);
                            is_validate = false;
                            is_sub_validate = false;
                        }
                    }
                    else {
                        if (value == "") {
                            error_message = error_message == undefined ? text_error_message : error_message;
                            error_message_template_temp = error_message_template.replace("{message}", error_message);
                            is_validate = false;
                            is_sub_validate = false;
                        }

                        if (max_lenght != undefined && value.length > max_lenght) {
                            error_max_lenght_message = error_max_lenght_message == undefined ? email_error_message : error_max_lenght_message;
                            error_message = error_max_lenght_message == undefined ? error_message : error_max_lenght_message;
                            error_message_template_temp = error_message_template.replace("{message}", error_max_lenght_message);
                            is_validate = false;
                            is_sub_validate = false;
                        }
                    }
                }
                else if (type === "password") {
                    if (value === "") {
                        error_message = error_message == undefined ? password_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }

                    if (max_lenght != undefined && value.length > max_lenght) {
                        error_max_lenght_message = error_max_lenght_message == undefined ? email_error_message : error_max_lenght_message;
                        error_message = error_max_lenght_message == undefined ? error_message : error_max_lenght_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_max_lenght_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                else if (type === "select") {
                    if (value === "" || value === undefined || value === null || value === "0") {
                        error_message = error_message == undefined ? select_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                else if (type === "hidden") {
                    if (value === "") {
                        error_message = error_message == undefined ? "" : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                else if (type === "checkbox") {
                    value = $(this).prop('checked');
                    if (value == false) {
                        error_message = error_message == undefined ? checkbox_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }
                else if (type === "file") {
                    value = $(this)[0].files[0];
                    if (value == null || value == undefined) {
                        error_message = error_message == undefined ? file_error_message : error_message;
                        error_message_template_temp = error_message_template.replace("{message}", error_message);
                        is_validate = false;
                        is_sub_validate = false;
                    }
                }




                if (is_sub_validate === false && message_type === "formmessage") {
                    $(form_group).append(error_message_template_temp);
                }
                else if (is_sub_validate === false && message_type === "modal") {
                    modal_message_template += error_message_template_temp + "<br />";
                }
                else if (is_sub_validate === false && message_type === "tooltip") {
                    $(this).attr('title', error_message).tooltip('fixTitle').tooltip('show');
                }
                else if (is_sub_validate === false && error_message != undefined) {
                    alert(error_message);
                }

                if (is_sub_validate === false) {
                    $(this).css("border", "1px solid #ff0505");
                    if ($(this).position().top < min_error_input_height)
                        min_error_input_height = $(this).position().top;
                }
            }
        });

        if (is_validate === false) {
            if (modal_message_template !== "") {
                $("#modaluyaribody").text("");
                $("#modaluyaribody").append(modal_message_template);
                $("#modaluyari").modal("show");
            }
            if (moving_scroll_bar === "1") {
                $('html,body').animate({
                    scrollTop: min_error_input_height
                });
            }
        }

        return is_validate;
    }
}