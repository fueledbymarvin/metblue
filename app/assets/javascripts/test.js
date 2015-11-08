$(document).ready(function() {
    $(window).scroll(function() {
        if ($(window).scrollTop() > 300) {

          //get data//
          $.get('/api/users/563ec9ee853d9855d5000000/search',
          {search: {budget: 700}}).done(function(response){
            console.log(response);
          })
            $(window).scrollTop(0);
        }
    });
});
