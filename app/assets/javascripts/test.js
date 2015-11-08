$(document).ready(function() {
    $(window).scroll(function() {
        if ($(window).scrollTop() > 300) {
            alert("new deal!");
            $(window).scrollTop(0);
        }
    });
});
