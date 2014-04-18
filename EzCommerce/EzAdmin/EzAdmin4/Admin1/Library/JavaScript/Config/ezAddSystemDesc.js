

function chkVal()
	{
		var FieldNames=new Array;
		var CheckType=new Array;
		var Messages=new Array;
 
 		if(document.myForm.key.value=="")
 		{
 			FieldNames[0]="key";
			CheckType[0]="MNumber";
			Messages[0]="Please enter System ID";
 		}
 		else
 		{
			FieldNames[0]="key";
			CheckType[0]="MNumber";
			Messages[0]="Please enter System ID in Numeric from 100 to 999";
		}	
		FieldNames[1]="Desc";
		CheckType[1]="MNull";
		Messages[1]="Please enter Description";
		
		if(document.myForm.SysType.selectedIndex==0)
		{
			alert("Please select system type");
			document.myForm.SysType.focus()
			return false
		}
		if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
		{
			if(document.myForm.key.value.length != 3)
			{
			
				alert("System ID should be between 100 and 999")
				document.myForm.key.focus()
				return false
			}
			return true
		}
		return false
	}

