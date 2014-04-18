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



function disNumUsers()
{
	if ( document.forms[0].UnlimitedUsers[0].checked || !document.forms[0].UnlimitedUsers[1].checked)
	{
		document.forms[0].NumUsers.disabled = true;
	}
	
	if ( document.forms[0].UnlimitedUsers[1].checked || !document.forms[0].UnlimitedUsers[0].checked)
	{
		document.forms[0].NumUsers.disabled = false;
	}
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
	for (i = 0; i < form.elements.length; i++) {
		var name = form.elements[i].name;
		if(name.charAt(0) == "*") continue;
			if (form.elements[i].type == "text" && 
      		form.elements[i].value == ""){ 
			if (form.elements[i].name != "NumUsers"){   
			   	alert("Please fill out all the fields.")
		      	form.elements[i].focus();
				document.returnValue = false;
				//break;
				return;
			}else{
                        if(!document.forms[0].UnlimitedUsers[0].checked) {
					alert("Please fill out Number Of Users.")
					form.NumUsers.focus();
					document.returnValue = false;
                                        //break;
                                        return;
			}//End if
                  }      
		}else{
				
                        	if(form.elements[i].name == "NumUsers" && !document.myForm.UnlimitedUsers[0].checked)
                        	{
                        		var nousers=trim(form.elements[i].value);
					if ( !isInteger(nousers) )
					{
						alert("Number of Users should be a valid number")
						form.NumUsers.focus();
						document.returnValue = false;
                                        	return;
                                        }
                                        if(nousers.length==0)
                                        {
						alert("Please Enter The Number of Users")
						form.NumUsers.focus();
						document.returnValue = false;
                                        	return;                                        
                                        
                                        }
				}//End if
		
		
				document.returnValue = true;
		
		}//End if
	}//End for

   
}
