$(".dropdown dt a").click(function() {

        // Change the behaviour of onclick states for links within the menu.
	var toggleId = "#" + this.id.replace(/^link/,"ul");

        // Hides all other menus depending on JQuery id assigned to them
	$(".dropdown dd ul").not(toggleId).hide();

        //Only toggles the menu we want since the menu could be showing and we want to hide it.
	$(toggleId).toggle();

        //Change the css class on the menu header to show the selected class.
	if($(toggleId).css("display") == "none"){
		$(this).removeClass("selected");
	}else{
		$(this).addClass("selected");
	}

});

$(".dropdown dd ul li a").click(function() {

    // This is the default behaviour for all links within the menus
    var text = $(this).html();
    $(".dropdown dt a span").html(text);
    $(".dropdown dd ul").hide();
});

$(document).bind('click', function(e) {

    // Lets hide the menu when the page is clicked anywhere but the menu.
    var $clicked = $(e.target);
    if (! $clicked.parents().hasClass("dropdown")){
        $(".dropdown dd ul").hide();
		$(".dropdown dt a").removeClass("selected");
	}

});