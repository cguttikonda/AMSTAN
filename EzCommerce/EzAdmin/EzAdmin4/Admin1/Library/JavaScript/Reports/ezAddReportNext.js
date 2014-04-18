function trim ( inputStringTrim )
{
	fixedTrim = "";
	lastCh = " ";
	for (x=0; x < inputStringTrim.length; x++)
	{
	  	ch = inputStringTrim.charAt(x);
	  	if ((ch != " ") || (lastCh != " "))
	  	{
	  		fixedTrim += ch; 
	  	}
	  	lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
	{
	   	fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
   	return fixedTrim;
}

function setAction()
{
	var tempfrom = null;
	var tempto = null;
	var pCount = 0;
	var paramType = null;
	pCount = document.myForm.SetFlag.value;
	for ( i = 0 ; i < pCount; i++ ) 
	{
		tempfrom = document.myForm.elements['ParamValueFrom' + i].value;
		paramType = document.myForm.elements['ParamType' + i].value;
		if (tempto != null && paramType.equals("S") )
		{
			tempto = document.myForm.elements['ParamValueTo' +i].value;
			if (tempto != null && paramType.equals("S") )
			{
				if (tempfrom > tempto)
				{
					alert("Invalid Range for "+document.myForm.elements['ParamKey'+i].value);
				}
			}
		}
	}
	document.myForm.action = "ezSaveExecuteReport.jsp";
	document.returnValue = true;
}

function checkSelect()
{
	var pCount = 0;
	var selCount = 0;
	pCount = document.myForm.SetFlag.length;
	for ( i = 0 ; i < pCount; i++ ) 
	{
		if(document.myForm.SetFlag[i].checked)
		{
			selCount = selCount + 1;
			document.myForm.FinalFlag[i].value = "Y";
		}
		else
			document.myForm.FinalFlag[i].value = "N";
	}
	if(selCount>1)
	{
		alert("Only one parameter can be selected");
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}

function setHiddenFlag()
{
	for ( i = 0 ; i < document.myForm.SetHiddenFlag.length; i++ ) 
	{
		if(document.myForm.SetHiddenFlag[i].checked)
		{
			document.myForm.FinalHiddenFlag[i].value = "Y";
		}
		else
			document.myForm.FinalHiddenFlag[i].value = "N";
	}
}

function checkEmpty()
{
	setHiddenFlag()
	var i = 0;
	var pCount = 0;
	pCount = document.myForm.SetFlag.length;
	selCount = 0;
	for ( i = 0 ; i < pCount; i++ )
	{
		paramdesc = trim( document.myForm.ParamDesc[i].value);
		paramFrom = trim( document.myForm.ParamValueFrom[i].value );
		paramTo = "INIT";

		numofElements = document.myForm.elements.length;
		if ( document.myForm.SetFlag[i].checked )
		{
			toVal = "ParamValueTo"+i;
			for (k = 0;k<numofElements;k++)
			{
				if (document.myForm.elements[k].name == toVal) paramTo = document.myForm.elements['ParamValueTo' + i].value;
			}
			selCount = selCount + 1;
			if (document.myForm.SetHiddenFlag[i].checked)
			{
				if (paramFrom == "")
				{
					alert ("With hidden selected field you need to provide the From Value.");
					document.returnValue = false;
					document.myForm.ParamValueFrom[i].focus();
					return;
				}
				if (paramTo == "")
				{
					alert ("With hidden selected field you need to provide the To Value.");
					document.returnValue = false;
					document.myForm.ParamValueTo[i].focus();
					return;
				}
			} 
			else 
			{
			 	if(paramdesc == "" && paramFrom == "" && selCount == 0)
				{
					alert("Please enter Parameter Description & From Value");
					document.myForm.ParamDesc[i].focus();
					document.returnValue = false;
					break;
				}
				else
				{
					document.returnValue = true;
				}
			}
		}
	}
	if ( selCount == 0 )
	{
		alert('Select one type of report');
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}
