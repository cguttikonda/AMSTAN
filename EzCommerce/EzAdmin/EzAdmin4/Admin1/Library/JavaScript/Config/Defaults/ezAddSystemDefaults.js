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



function CheckValue() 
	{
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();
	FieldNames[0]="key";
	CheckType[0]="MNull";
	Messages[0]="Please enter Default";
	FieldNames[1]="Desc";
	CheckType[1]="MNull"; 
	Messages[1]="Please enter Description";
	if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
	{
		document.returnValue = false;
	}
	else
		{
		if(document.forms[0].SysKey.selectedIndex==0 )
			{
			alert("Please Select Bussiness Area.");
			document.forms[0].SysKey.focus();
			document.returnValue=false;
			}
		else
			{
			if( document.forms[0].DefType.selectedIndex==0)
				{
				alert("Please Select Default Level.");
				document.forms[0].DefType.focus();				
				document.returnValue = false;
				}
				else
				{
						document.returnValue = true;
				}
			}
		}
	}
	
