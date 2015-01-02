$(function($) {
	$("fieldset.foldable").addClass("folded");
	$("fieldset.foldable").on("click",function(){
		if ($(this).hasClass("folded")) {
			$(this).removeClass("folded").addClass("unfolded");
		} else {
			$(this).removeClass("unfolded").addClass("folded");
		}
	});
});

