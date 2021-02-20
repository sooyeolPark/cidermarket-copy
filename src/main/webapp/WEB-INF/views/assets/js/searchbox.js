 $(function() {
  $("#btnSearch, #searchClose").click(function(e) { 
    e.preventDefault();
    $("#searchBox").slideToggle(100); 
  });
});