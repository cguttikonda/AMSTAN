function chkAll()
{
	var count = 0;
	var len = document.myForm.syskey.length
	if(isNaN(len))
	{
		if(document.myForm.syskey.checked)
		{
			count++;
		}
	}
	else
	{
		for(var i=0;i<len;i++)
		{
			if(document.myForm.syskey[i].checked)
			{
				count++
			}
		}
	}
	
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();
			
		
	FieldNames[0]="soldTo";
	CheckType[0]="MNULL";
	Messages[0]="Please enter Sold To";
	
	FieldNames[1]="userId";
	CheckType[1]="MNULL";
	Messages[1]="Please enter User Id.";
	
	
	FieldNames[2]="userName";
	CheckType[2]="MNULL";
	Messages[2]="Please enter Partner / User Name.";
	
	
	FieldNames[3]="catnum";
	CheckType[3]="MNULL";
	Messages[3]="Please Select Catalog.";
	
	FieldNames[4]="plant";
	CheckType[4]="MNULL";
	Messages[4]="Please enter Plant. ";
	
	
	if(! funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
		return false;
	
	if(count==0)
	{
		alert("Please Select atleast one  SalesArea.")
		return false;
	}	
	return true;
}
function funUserId()
{
	var soldTo = document.myForm.soldTo.value;
	if(soldTo!=null)
	{
			document.myForm.userId.value = soldTo;
	}
	
}
function chkUserExists()
{
	if(chkAll())
	{
		userId = document.myForm.userId.value;
		userId = userId.toUpperCase();
		for (var i=0;i<userArray.length;i++)
		{
			if (userId==userArray[i])
			{
				alert("User already Exists with "+userId+", Please Choose another one.");
				document.forms[0].soldTo.focus();
				return false;
			}
		}
		return true;
	}
	return false;
}	
function funFocus()
{
	if(document.myForm.soldTo!=null)
		document.myForm.soldTo.focus();
}
