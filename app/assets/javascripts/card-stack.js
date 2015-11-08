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
      generateNewCard(cache, false);
      makeDraggable();
    }
    //tolerance:"touch"
  });


});

var makeDraggable = function(){
  $('.card').draggable({
    snap:'#favorites-wrapper',
    snapMode:"inner",
    revert:"invalid",
    snapTolerance:50,
  });
}
