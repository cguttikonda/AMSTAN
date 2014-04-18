function trim ( inputStringTrim ) 
{
	fixedTrim = "";
	lastCh = " ";
	for (x=0; x < inputStringTrim.length; x++) 
	{
	  ch = inputStringTrim.charAt(x);
	  if ((ch != " ") || (lastCh != " ")) 
	  { fixedTrim += ch; } //end if
	  lastCh = ch;
	} //end for
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ") 
	{
	   fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); 
	} //end if
   	return fixedTrim;
}  //end function trim

function checkEmpty()
{
	var pCount = 0;
	pCount = document.ChgRep.TotalCount.value;
	for ( i = 0 ; i < pCount; i++ ) 
	{
		paramvalue = document.ChgRep.elements['ParamValueFrom_' + i].value;
		paramvalue = trim( paramvalue );
		if(paramvalue == "")
		{
			alert("Please enter Parameter From Values");
			//document.ChgRep.elements['ParamValueFrom_' + i].focus();
			document.returnValue = false;
			break;
		}
		else
		{
			document.returnValue = true;
		}
	}
}