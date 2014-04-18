var FieldName=new Array();
var CheckType=new Array();
var Messages=new Array();



function chk()
{
if(document.myForm.rolenumber.value=="")
{
       	alert("Please enter Role.");
 	document.myForm.rolenumber.focus()
	return false;
}
else
{
	var s=document.myForm.rolenumber.value;
	if(s.length>0)
	{
	   	for (i = 0; i < s.length; i++)
	   	{
			c = s.charCodeAt(i);
			if (!((c>=48 && c<=57) || (c>=65 && c<=90) || (c>=97 && c<=122) || c==95) )
			{
	  		     	alert("Please enter valid Role.");
		     		document.myForm.rolenumber.focus()
		     		return false;
			}
	    	}
	}
}

FieldName[0] = "roleDesc";
CheckType[0] = "MNull";
Messages[0] = "Please enter Role Description";

if(document.myForm.roleType.selectedIndex!=0)
{
	var s= funCheckFormFields(document.myForm,FieldName,CheckType,Messages);
	return s;
}
else
{
	alert("Please select role type");
	document.myForm.roleType.focus();
	return false;
}

}
