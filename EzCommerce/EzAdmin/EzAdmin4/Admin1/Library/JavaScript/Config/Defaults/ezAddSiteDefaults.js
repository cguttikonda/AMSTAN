function isSpecial(s)
{
	var i;
	// Search through string's characters one by one
	// until we find a non-numeric character.
	// When we do, return false; if we don't, return true.
	var a = '';
	for (i = 0; i < s.length; i++)
	{
		// Check that current character is number.
		var c = s.charAt(i);
		if (c == "\'")
		{
			a = a+"'"+c;
		}
		else
		{
			a = a + c;
		}
	}
	return a;
}
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
function placeFocus() 
{
	if (document.forms.length > 0) 
	{
		var field = document.forms[0];
		for (i = 0; i < field.length; i++) 
		{
			if (field.elements[i].name == "key") 
			{
				document.forms[0].elements[i].focus();
				break;
			}
		}
	}
}
function CheckValue() 
{
	var Key = document.forms[0].key.value;
	var Desc = document.forms[0].Desc.value;
	Key = trim(Key);
	Desc = trim(Desc);
	if(document.forms[0].DefType.selectedIndex==0)
	{
		alert("Please Select Default Level.");
		document.forms[0].DefType.focus();				
		document.returnValue=false;
	}
	else if(Key == "")
	{
		alert("Please enter Defaults Key.");
		document.forms[0].key.focus();
		document.returnValue = false;
	}
	else if(Desc == "")
	{
		alert("Please enter Description.");	
		document.forms[0].Desc.focus();
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}