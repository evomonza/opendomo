$(function(){
	$("[type='submit']").hide();
	$("[type='file']").change(function(item){
		if($(this).val()!=""){
			$(this).next().css("background-color","lightgray");
			$("form").submit();
		}else{
			$(this).next().css("background-color","white");
		}
	});	
});