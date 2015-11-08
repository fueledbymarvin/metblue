$(document).ready(function() {
    $("#makeMeScrollable").smoothDivScroll({
      mousewheelScrolling: "allDirections",
      manualContinuousScrolling: true,
      autoScrollingMode: "onStart"
    });

    $(window).scroll(function() {
        if ($(window).scrollLeft() > 300) {
            alert("LOL");
          //get data//
          // $.get('/api/users/563ec9ee853d9855d5000000/search/packages',
          // {page: page_count, per_page:5 }).done(function(response){
          //   console.log(response);
          // })
            $(window).scrollLeft(0);
        }
    });
});
