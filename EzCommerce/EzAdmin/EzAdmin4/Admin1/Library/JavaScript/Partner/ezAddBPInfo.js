function trim( inputStringTrim)
{
	fixedTrim = "";
	lastCh = " ";

	for( x=0;x < inputStringTrim.length; x++)
	{
   		ch = inputStringTrim.charAt(x);
 		if ((ch != " ") || (lastCh != " "))
 		{ fixedTrim += ch; }
		lastCh = ch;
	}

	if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
	return fixedTrim
}

function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}

function isInteger (s)

{   var i;


    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {
        // Check that current character is number.
        var c = s.charAt(i);

        if (!isDigit(c)) return false;
    }

    // All characters are numbers.
    return true;
}

function checkAll()
{
	var form = document.forms[0]
		var FieldNames=new Array;
		var CheckType=new Array;
		var Messages=new Array;
		FieldNames[0]="Company";
		CheckType[0]="MNull";
		Messages[0]="Please enter Company Name";
		FieldNames[1]="BPDescription";
		CheckType[1]="MNull";
		Messages[1]="Please enter Description";
		if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
		{
			document.returnValue = false;
			return;
		}

	for (i = 0; i < form.elements.length; i++)
	{
		var name = form.elements[i].name;
		if(name.charAt(0) == "*") continue;
                        	if(!document.myForm.UnlimitedUsers[0].checked && trim(form.elements[i].value) == "" )
                        	{
					alert("Please Enter Number Of Users.")
					form.NumUsers.focus();
					document.returnValue = false;
                                        //break;
                                        return;
				}//End if
                  	
                        	if(form.elements[i].name == "NumUsers" && !document.myForm.UnlimitedUsers[0].checked)
                        	{
					if ( !isInteger(trim(form.elements[i].value)) )
					{
						alert("Number of Users should be a valid number")
						form.NumUsers.focus();
						document.returnValue = false;
                                        	//break;
                                        	return;
                                        }
				}//End if

				document.returnValue = true;
	}

}



function VerifyNumUsers()
{
        if (document.myForm.UnlimitedUsers[0].checked && document.myForm.NumUsers.value != "")
        {
                alert ("Opted Unlimited, Please do not enter Number of Users")
		document.myForm.NumUsers.focus();
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}

function checkThis(textbox)
{
	var name = textbox.name;
	var value = textbox.value;
	if(textbox.value == "")
	{
		alert("Please enter: " + name);
		textbox.focus();
		document.returnValue = false;
	}
	else
	{
		document.returnValue = true;
	}
}

function setFocus()
{
	if(document.myForm.UnlimitedUsers.checked)
	{
		document.myForm.CatalogNumber.focus();
		document.returnValue = true;
	}
	else
	{
		document.myForm.NumUsers.focus();
		document.returnValue = true;
	}
}

function setChange() {
	if(document.myForm.UnlimitedUsers.checked)
	{
		document.myForm.NumUsers.blur();
		document.returnValue = true;
	}
	else
	{
		document.returnValue = true;
	}
}
function ezCopyCName()
{

	if(document.myForm.BPDescription.value=="")
	{
		document.myForm.BPDescription.value=document.myForm.Company.value
	}



}
function funReadOnly()
{
	if(document.myForm.UnlimitedUsers[1].checked)
	{
		document.myForm.NumUsers.readOnly=false;
		document.myForm.NumUsers.focus();
	}
	else
	{
		document.myForm.NumUsers.readOnly=true;
	}
}
