$(document).ready(function() {
	
    $('.tarihkisa').simpleMask({ 'mask': '##/####', 'nextInput': $('#frDtel') });
    $('.frDtel').simpleMask({ 'mask': ['(##) ####-####', '(##) #####-####'], 'nextInput': $('#frTel') });
    $('.frTel').simpleMask({ 'mask': ['####-####', '#####-####'], 'nextInput': $('#frData') });
    $('.frData').simpleMask({ 'mask': '##/##/####', 'nextInput': $('#frCpf') });
    $('.frCpf').simpleMask({ 'mask': '###.###.###-##', 'nextInput': $('#frCnpj') });
    $('.frCnpj').simpleMask({ 'mask': '##.###.###/####-##' });

});