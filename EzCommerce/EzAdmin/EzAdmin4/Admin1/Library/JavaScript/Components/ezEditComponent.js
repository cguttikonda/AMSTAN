function formrst()
{
	document.myForm.reset()
}
function chkValid(strValue)
{
	var validChars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.";
	var nLoop=0;
	var nLength=strValue.length;
	for(nLoop=0;nLoop<nLength;nLoop++)
	{
		cChar=strValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			return false;
		}
	}
	return true;
}

function checkForm()
{
	var fmObj = document.myForm;
	var chkd;
	var FieldNames= new Array();
	var CheckType= new Array();
	var Messages= new Array();

	FieldNames[0]="compVersion"
	CheckType[0]="MNull"
	Messages[0]="Component Version Not Entered"

	FieldNames[1]="compDesc"
	CheckType[1]="MNull"
	Messages[1]="Component Description Not Entered"

	if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		if(chkValid(document.myForm.compVersion.value))
		{
			if((document.myForm.compVersion.value).indexOf(".") == -1)
				document.myForm.compVersion.value = document.myForm.compVersion.value + ".0"
			else
			{
				var pointCount = 0;
				var versionString = document.myForm.compVersion.value
				for(i=0;i<versionString.length;i++)
				{
					if(versionString.charAt(i) == '.')
						pointCount++			
				}
				if(pointCount > 1)
				{
					alert("Only One Decimal To Be Entered For Version Code Ex: 1.0");
					document.myForm.compVersion.focus();
					return;
				}	
			}
			
			document.myForm.action = 'ezEditSaveComponent.jsp'
			document.myForm.submit()
		}
		else
		{
			alert("Invalid Charactors In Versions")
			document.myForm.compVersion.focus()
			return
		}

	}
	else
		return
}
