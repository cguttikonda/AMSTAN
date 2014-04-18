function chkValid(strValue)
{
	var validChars="0123456789.";
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

function checksubmit()
{
	var fieldNames = new Array()
	var checkType = new Array()
	var messages = new Array()

	fieldNames[0] = "version"
	checkType[0] = "MNULL"
	messages[0] = "Component Version Not Entered"

	fieldNames[1] = "desc"
	checkType[1] = "MNULL"
	messages[1] = "Component Description Not Entered"


	if(funCheckFormFields(document.myForm,fieldNames,checkType,messages))
	{
		if(chkValid(document.myForm.version.value))
		{
			if((document.myForm.version.value).indexOf(".") == -1)
				document.myForm.version.value = document.myForm.version.value + ".0"
			else
			{
				var pointCount = 0;
				var versionString = document.myForm.version.value
				for(i=0;i<versionString.length;i++)
				{
					if(versionString.charAt(i) == '.')
						pointCount++			
				}
				if(pointCount > 1)
				{
					alert("Only One Decimal To Be Entered For Version Code Ex: 1.0");
					document.myForm.version.focus();
					return;
				}	
			}
			document.myForm.action="ezAddSaveComponent.jsp";
			document.myForm.submit()
			
		}
		else
		{
			alert("Invalid Charactors In Versions..Please Enter Only Numbers")
			document.myForm.version.focus()
			return;
		}
	}
	else
		return;
}

