$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $("#answer_box").on("submit", function(e){

    e.preventDefault();

    $("#question").addClass("hidden");
    $("#answer_box").addClass("hidden");
    $("#answer").removeClass("hidden");
    $("#next_question").removeClass("hidden");


  });

});
