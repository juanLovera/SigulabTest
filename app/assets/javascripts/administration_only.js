// Bootstrap Datepicker by eternicode
datepicking = function() {
    $(".bootlayout-date").datepicker({
        format: "dd/mm/yyyy",
        todayBtn: "linked",
        language: "es",
        todayHighlight: true
    });
};

$(document).ready(datepicking);
$(document).on('page:load', datepicking);

function setSAECodeIncomes() {

	saeCode = "";

	if ($('#income_lab_id').val()==1)
		saeCode = "U01";

	if ($('#income_lab_id').val()==2)
		saeCode = "U02";

	if ($('#income_lab_id').val()==3)
		saeCode = "U03";

	if ($('#income_lab_id').val()==4)
		saeCode = "U04";

	if ($('#income_lab_id').val()==5)
		saeCode = "U05";

	if ($('#income_lab_id').val()==6)
		saeCode = "U06";

	if ($('#income_lab_id').val()==7)
		saeCode = "U07";

	if ($('#income_lab_id').val()==8)
		saeCode = "U08";

	$('#income_sae_code').val(saeCode);

}

function setSAECodeCommitments() {

	saeCode = "";

	if ($('#commitment_lab_id').val()==1)
		saeCode = "U01";

	if ($('#commitment_lab_id').val()==2)
		saeCode = "U02";

	if ($('#commitment_lab_id').val()==3)
		saeCode = "U03";

	if ($('#commitment_lab_id').val()==4)
		saeCode = "U04";

	if ($('#commitment_lab_id').val()==5)
		saeCode = "U05";

	if ($('#commitment_lab_id').val()==6)
		saeCode = "U06";

	if ($('#commitment_lab_id').val()==7)
		saeCode = "U07";

	if ($('#commitment_lab_id').val()==8)
		saeCode = "U08";

	$('#commitment_sae_code').val(saeCode);

}

function setSAECode() {

	saeCode = "";

	if ($('#project_admin').val()=="marquez")
		saeCode = "1.05.03.11";

	if ($('#project_admin').val()=="villa")
		saeCode = "1.05.03.10";

	$('#project_sae_code').val(saeCode);

}

function calculateAmount() {

	if (isNaN(parseFloat($('#project_equipments').val()))) {
		$('#project_equipments').val(0);
    	equipments = 0;
	} else {
		equipments = parseFloat($('#project_equipments').val()) };

	if (isNaN(parseFloat($('#project_services').val()))){
		$('#project_services').val(0);
    	services = 0;
	} else {
		services = parseFloat($('#project_services').val()) };

	if (isNaN(parseFloat($('#project_infrastructure').val()))) {
		$('#project_infrastructure').val(0);
    	infrastructure = 0;
	} else {
		infrastructure = parseFloat($('#project_infrastructure').val()) };

	if (isNaN(parseFloat($('#project_hhrr').val()))) {
		$('#project_hhrr').val(0);
    	hhrr = 0;
	} else {
		hhrr = parseFloat($('#project_hhrr').val()) };

	if (isNaN(parseFloat($('#project_consumables').val()))) {
		$('#project_consumables').val(0);
    	consumables = 0;
	} else {
		consumables = parseFloat($('#project_consumables').val()) };

	if (isNaN(parseFloat($('#project_furniture').val()))) {
		$('#project_furniture').val(0);
    	furniture = 0;
	} else {
		furniture = parseFloat($('#project_furniture').val()) };		

	if (isNaN(parseFloat($('#project_other_amount').val()))) {
		$('#project_other_amount').val(0);
    	other_amount = 0;
	} else {
		other_amount = parseFloat($('#project_other_amount').val()) };

	total = equipments+services+infrastructure+hhrr+consumables+furniture+other_amount;

	$('#project_amount').val(total);

}

function changeAnnulledDate() {

	if ($('#project_status').val()== "annulled") {
		$(".hidden_option1").fadeIn('fast');
	} else {
		$(".hidden_option1").fadeOut('fast');		
	}

}
