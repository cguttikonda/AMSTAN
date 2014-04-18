<html>
<head>
	<link type="text/css" rel="stylesheet" href="../../Library/Styles/styleAuto.css" />
	<script type="text/javascript" src="../../Library/Script/jquery-1.4.2.min.js"></script>
	<script src="../../Library/Script/jquery.autocomplete.js"></script>	
	
	<script>
	jQuery(function(){
		$("#prod").autocomplete("list.jsp");
	});
   	
   	function fill(thisValue) {
	$('#prod').val(thisValue);
	$('.ac_results').hide();
	$('#atpqty').focus();	
	}
	
	function fillM(thisValue) {
		$('#prod').val(thisValue);
		
	}
	
	function fillK(thisValue,e) {
	
	var keycode;
		if (window.event) keycode = window.event.keyCode;
		else if (e) keycode = e.which;
		else return true;
		
		
		if (keycode == 13)
		   {
			  $('#prod').val(thisValue);
			  $('.ac_results').hide();
			  $('#atpqty').focus();	

		   	return false;
		   }
		else
	   		return true;		
	}
	</script>
   	
</head>
<body>
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">

<br><br>

	Select Product   :	
	<input type="text" id="prod" name="prod" class="input_text"/>
<br><br>
Qty
	<input type="text" id="atpqty" name="atpqty" />
	

</div>
</div>
</div>
</body>
</html>