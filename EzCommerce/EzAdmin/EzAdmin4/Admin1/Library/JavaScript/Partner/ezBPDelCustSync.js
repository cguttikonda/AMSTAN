function trim( inputStringTrim)
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
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
	return fixedTrim
}

function delsync(sCnt)
{
	var selCnt = 0;
	for ( i = 0; i < sCnt; i++ )
	{
		if ( document.myForm.elements['CheckBox_'+i].checked )
		{
			selCnt = 1;
			break;
		}
	}

	if ( selCnt == 0 )
	{
		alert('Select one Partner Function to Delete');
		document.returnValue = false;
		document.myForm.elements['CheckBox_0'].focus();
	}
	else
	{
		document.returnValue = true;
	}
}

function custalert()
{
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
      mUrl2 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2+"&FUNCTION=" + document.myForm.FUNCTION.value;
	location.href= mUrl;
}
