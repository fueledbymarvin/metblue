$(document).ready(function() {
    var $window = $(window);
    if ($(".static_pages.flights").length > 0) {
        var cache = [];
        var pageCount = 0;
        var perPage = 25;
        var minCached = 10;
        var scrollDist = 400;

        $("body").css({height: $window.height() + scrollDist*1.2 + "px"});
        $window.resize(function() {
            $("body").css({height: $window.height() + scrollDist*1.2 + "px"});
        });

        //populate user data
        $.ajax({
            url:'/api/users/'+currentUser+'/search/',
            type: 'PUT',
            data: {search: {"destination_regions[0]": ["Caribbean"]}}
        }).done(function(response){
            //dummy switching cards. call this when animating
            $(document).keydown(function(e){
                if(e.keyCode === 39){
                    generateNewCard();
                }
            });

            //get data//
            var getData = function() {
                $.get('/api/users/'+currentUser+'/search/packages',
                      { page: ++pageCount, per_page: perPage })
                    .done(function(response){
                        cache = cache.concat(response);
                    });
            };

            $.get('/api/users/'+currentUser+'/search/packages',
                  { page: ++pageCount, per_page: perPage })
                .done(function(response){
                    cache = cache.concat(response);
                    generateNewCard();
                });

            $window.scroll(function() {
                if ($window.scrollTop() > scrollDist) {
                    generateNewCard();
                    $window.scrollTop(0);
                }
            });

            var generateNewCard = function() {

                var obj = cache.pop();
                if (obj === undefined) {
                    return;
                }

                if (cache.length < 10) {
                    getData();
                }

                //generate new card
                var check_in = obj['check_in'].split('-')[1]+"/"+ obj['check_in'].split('-')[2];
                var check_out = obj['check_out'].split('-')[1]+"/"+ obj['check_out'].split('-')[2];
                var dest_airport = obj['destination_airport'];
                var origin_airport = obj['origin_airport'];
                var hotel  = obj['hotel'];
                var exp_price = obj['expedia_price'].toString();
                var jb_price = obj['jetblue_price'].toString();
                var percent = (100*(obj['expedia_price'] - obj['jetblue_price'])/obj['expedia_price']).toString().slice(0,4);
                var nights = obj['nights'].toString();

                var HTMLString = '<li class="card newCard"><div class="box"><ul class="left"><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li></ul><ul class="right"><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li></ul><div class="ticket"><span class="airline">'+origin_airport+' to '+dest_airport+' Trip</span><span class="airline airlineslip">Details</span><div class="content"><span class="origin">'+origin_airport+'</span><span class="plane"><?xml version="1.0" ?><svg clip-rule="evenodd" fill-rule="evenodd" height="60" width="60" image-rendering="optimizeQuality" shape-rendering="geometricPrecision" text-rendering="geometricPrecision" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg"><g stroke="#222"><line fill="none" stroke-linecap="round" stroke-width="30" x1="300" x2="55" y1="390" y2="390"/><path d="M98 325c-9 10 10 16 25 6l311-156c24-17 35-25 42-50 2-15-46-11-78-7-15 1-34 10-42 16l-56 35 1-1-169-31c-14-3-24-5-37-1-10 5-18 10-27 18l122 72c4 3 5 7 1 9l-44 27-75-15c-10-2-18-4-28 0-8 4-14 9-20 15l74 63z" fill="#222" stroke-linejoin="round" stroke-width="10"/></g></svg></span><span class="dest">'+dest_airport+'</span><span class="origin jfkslip">'+origin_airport+'</span><span class="plane planeslip"><?xml version="1.0" ?><svg clip-rule="evenodd" fill-rule="evenodd" height="50" width="50" image-rendering="optimizeQuality" shape-rendering="geometricPrecision" text-rendering="geometricPrecision" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg"><g stroke="#222"><line fill="none" stroke-linecap="round" stroke-width="30" x1="300" x2="55" y1="390" y2="390"/><path d="M98 325c-9 10 10 16 25 6l311-156c24-17 35-25 42-50 2-15-46-11-78-7-15 1-34 10-42 16l-56 35 1-1-169-31c-14-3-24-5-37-1-10 5-18 10-27 18l122 72c4 3 5 7 1 9l-44 27-75-15c-10-2-18-4-28 0-8 4-14 9-20 15l74 63z" fill="#222" stroke-linejoin="round" stroke-width="10"/></g></svg></span><span class="dest sfoslip">'+dest_airport+'</span><div class="sub-content"><span class="watermark">Jetblue</span><span class="name">HOTEL<br><span style="width: 120px; display: block;">'+hotel+'</span></span><span class="flight">NIGHTS<br><span>'+nights+'</span></span><span class="gate">BEGIN<br><span>'+check_in+'</span></span><span class="seat">END<br><span>'+check_out+'</span></span><span class="flight flightslip">JETBLUE PRICE<br><span>$'+jb_price+'</span></span><span class="seat seatslip">PERCENT SAVINGS<br><span>'+percent+'%</span></span><span class="name nameslip">EXPEDIA PRICE<br><span>$'+exp_price+'</span></span></div></div><div class="barcode"></div><div class="barcode slip"><a href="#" class="myButton">Check Out</a></div></div></div></li>';

                var newCard = $(HTMLString);
                var oldCard = $(".currentCard");
                newCard.css({
                    left: "300px",
                    opacity: 0
                });
                $('#cardContainer').append(newCard);
                newCard.animate({
                    left: "0px",
                    opacity: 1
                });
                newCard.addClass("currentCard");
                oldCard.animate({
                    left: "-300px",
                    opacity: 0
                }, 600, "swing", function() {
                    oldCard.remove();
                });
                $('.card').draggable({
                    snap:'#favorites-wrapper',
                    snapMode:"inner",
                    revert:"invalid",
                    snapTolerance:50
                });
            };
        });
    }
});
