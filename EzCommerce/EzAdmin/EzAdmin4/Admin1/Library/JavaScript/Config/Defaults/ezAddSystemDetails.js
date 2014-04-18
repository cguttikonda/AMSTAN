function trim( inputStringTrim) {
fixedTrim = "";
lastCh = " ";
for( x=0;x < inputStringTrim.length; x++)
{
   ch = inputStringTrim.charAt(x);
 if ((ch != " ") || (lastCh != " ")) { fixedTrim += ch; }
lastCh = ch;
}
if (fixedTrim.charAt(fixedTrim.length - 1) == " ") {
fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); }
return fixedTrim
}


function placeFocus() {
	if (document.forms.length > 0) {
	var field = document.forms[0];
		for (i = 0; i < field.length; i++) {
			if (field.elements[i].name == "key") {
		 	document.forms[0].elements[i].focus();
			break;
	 		}
	 	}
 	}
}


function CheckValue() {

	Key = trim(document.forms[0].key.value);
	Desc = trim(document.forms[0].Desc.value);

	if((Key == "")||(Desc == "")){
		alert("Please Enter Defaults Key and Description to Continue");
		document.returnValue = false;
	}else{

		if(document.forms[0].SysKey.selectedIndex==0 )
		{
			alert("Please Select Bussiness Area");
			document.returnValue=false;
		}
		else
		{
			if( document.forms[0].DefType.selectedIndex==0)
			{
				alert("Please Select Default Type");
				document.returnValue = false;
			}
			else
			{
				document.returnValue = true;
			}
		}
	}
}
