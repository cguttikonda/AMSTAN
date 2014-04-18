function wait(msecs)
{
	var start = new Date().getTime();
	var cur = start
	while(cur - start < msecs)
	{
		cur = new Date().getTime();
	}	
} 

function funSave()
{
	var email = document.myForm.email.value
	var firstName = '<%=userFName%>'
	var lastName  = '<%=userLName%>'
	var userMail  = '<%=userEmail%>'
	var formFName = document.myForm.ufname.value
	var formLName = document.myForm.ulname.value
	if(formFName!=firstName || formLName!=lastName || userMail!=email) 
	{
		if(email!='' && userMail!=email)
		{	funChkEmail(email)
			//setTimeout(funChkEmail(email), 5000);
		}	
		var emailVal = document.myForm.emailVal.value	
		alert("emailVal:::::"+emailVal)
		if(emailVal=='Y')
			return;
		else if((emailVal=='N' || emailVal=='') && email!='' && echeck(email))	
			document.myForm.submit();
	}
	if(formFName=='')
	{
		$( "#dialog-fName" ).dialog('open');
	}
	if(formLName=='')
	{
		$( "#dialog-lName" ).dialog('open');
	}		
	if(formFName!='' && formLName!='' && echeck(email))
	{
		//Popup.showModal('modal1');
		document.myForm.submit();
	}		
}
function echeck(str) 
{

	var at="@"
	var dot="."
	var lat=str.indexOf(at)
	var lstr=str.length
	var ldot=str.indexOf(dot)
	if (str==''){
	    $( "#dialog-invalidEmail" ).dialog('open');
	   return false
	}	
	if (str.indexOf(at)==-1){
	    $( "#dialog-invalidEmail" ).dialog('open');
	   return false
	}

	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
	   $( "#dialog-invalidEmail" ).dialog('open');
	   return false
	}

	if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
	    $( "#dialog-invalidEmail" ).dialog('open');
	    return false
	}

	 if (str.indexOf(at,(lat+1))!=-1){
	   $( "#dialog-invalidEmail" ).dialog('open');
	    return false
	 }

	 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
	   $( "#dialog-invalidEmail" ).dialog('open');
	    return false
	 }

	 if (str.indexOf(dot,(lat+2))==-1){
	    $( "#dialog-invalidEmail" ).dialog('open');
	    return false
	 }

	 if (str.indexOf(" ")!=-1){
	    $( "#dialog-invalidEmail" ).dialog('open');
	    return false
	 }

	 return true					
}
$(function() {
	
	$("#ezForm").validate();
	
	$( "#dialog-emailAlert" ).dialog({
		autoOpen: false,
		resizable: true,
		height:220,
		width:425,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});
	$( "#dialog-invalidEmail" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});	
	$( "#dialog-updated" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});
	$( "#dialog-fName" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});	
	$( "#dialog-lName" ).dialog({
		autoOpen: false,
		resizable: true,
		height:150,
		width:400,
		modal: true,
		buttons: {
			"Ok": function() {
			$( this ).dialog( "close" ); 
		}
	}
	});	
});	
