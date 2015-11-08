$(document).ready(function(){
  $('.card').draggable({
    snap:'#favorites-wrapper',
    snapMode:"inner",
    revert:"invalid",
    snapTolerance:50,
  });
  $('#favorites-wrapper').droppable({
    drop: function(event, ui){
      $("#favorites").append(ui.draggable);
      ui.draggable.removeAttr("style");
      ui.draggable.addClass("favoriteCard");
    }
    //tolerance:"touch"
  });
  $('#favorites-wrapper').click(function(){
    alert("clicked");
    $.ajax({
      url:'/api/users/563ec9ee853d9855d5000000/search/',
      type: 'PUT',
      data: {search: {origin_airport: 'BOS'}}
    }).done(function(response){
      console.log("success?");
      console.log(response);
      //true
      $.get(
        '/api/users/563ec9ee853d9855d5000000/search/packages?'
      )
    }).fail(function(responseObject){
      console.log("error :(");
      console.log(responseObject);
    });

  })

});
