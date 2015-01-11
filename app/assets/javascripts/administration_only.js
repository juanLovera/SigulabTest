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