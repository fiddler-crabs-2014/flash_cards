$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $("#answer_box").on("submit", function(e){

    e.preventDefault();

    var answer_card_id = $(this).serialize();

    $.ajax({
      type: "POST",
      url: "/answer",
      data: answer_card_id
      //data: #card_id and answer
    }).success(function(data){

      console.log(data);

      $("#score_span").empty().append(data);

      console.log(score);

    });

    $("#question").addClass("hidden");
    $("#answer_box").addClass("hidden");
    $("#answer").removeClass("hidden");
    $("#next_question").removeClass("hidden");

    $("#card").addClass("flipped");


  });

  // $("#end_game").on("submit", function(e){

  //   e.preventDefault();

  //   $("#end_game").attr("action", "/decks_display/" + data);



  // });



});
