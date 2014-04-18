function funReset(){
	document.myForm.reset();
}
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
	return fixedTrim;
}   

function isValidChar (c)
{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")))
}

function checkSpecialUser(s, fieldName)
{
    var i;
    var newChar = '';
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
	newChar += c;
	if ( 	c == '&' || c == ',' || c == '"' || c == ' ' || c == '.' ||
	     	c == '%' || c == '$' || c == '>' || c == '<' || c == '?' ||
	     	c == '#' || c == '@' || c == '!' || c == '`' || c == '~' ||
		c == '*' || c == '(' || c == ')' || c == '-' || c == '_' ||
		c == '=' || c == '+' || c == ':' || c == ';' || c == '}' ||
		c == '{' || c == '[' || c == ']' || c == '|' || c == '^' ||
		c == '.'  || c == '/' || c == '\\'
         )
	{
		continue;
	}
	if ( c == '\'' )
	{
		newChar += '\'';
		continue;
	}

      if (!isValidChar(c)) return false;
    }

    	// All characters are numbers or alphabets.
    	if ( fieldName == 'msgSubject' )
	{
    		document.myForm.elements[fieldName].value = newChar;
	}
    	return true;

}

function VerifyEmptyFields() {
    
    var to=document.myForm.toUser.value;
    var cc=document.myForm.ccUser.value;
    var bcc=document.myForm.bccUser.value;
    var msg=document.myForm.msgText.value;

	if (( to == "" ) || (to.charAt(0) == " "))
	{
		alert("Please Select/Enter To address don't include spaces");
		document.myForm.toUser.focus();
		return false;
	}
	else if((cc!="") && (cc.indexOf("@")<0))
	{
           	alert("Please Enter Cc and include @ in your address.");
		document.forms[0].ccUser.focus();
		return false;             
	}
        else if ((bcc!="") && (bcc.indexOf("@")<0))
	{
		alert("Please Enter Bcc and include @ in your address.");
		document.forms[0].bccUser.focus();
		return false;          
	}
	/*else if (trim(msg) == "" )
	{
            
		alert("Please enter Message.");
		document.forms[0].msgText.focus();
		return false;           
	}*/
	return true;	
}


function getAddressWindow()
{
	var url = "ezSelectUsers.jsp";
	var hWnd = 	window.open(url,"UserWindow","width=300,height=300,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}




function getAttachWindow()
{
	var url = "ezAttachment.jsp";
	var hWnd = 	window.open(url,"UserWindow","width=650,height=350,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}

function doAttach()
{
       var s="";
   	for(a=0;a<document.temp.attachlist.length;a++)
       {
	    s=s+document.temp.attachlist.options[a].value+"\n";
       }
       parent.opener.myForm.attachs.value=s;
       window.close();
}


function doClose()
{
     if(document.doneattach.attfile.value!="")
     {
 	    document.doneattach.action="ezUploadFiles.jsp";
	    document.doneattach.submit();
     }
     else
     {
           alert("Please Select a file to Upload");
     }
}

function doRemove()
{
   var count=0;
    if(document.temp.attachlist.length==0)
    {
         alert("There are no files Attached");
    }
    for(var i=0;i<document.temp.attachlist.length;i++)
    {
        if(document.temp.attachlist.options[i].selected)
        {
            count++;
        }
    }
    if(count==0)
    {
         alert("Please Select a file to Remove");
    }
    else
    {
        document.temp.action="ezAttachment.jsp";
        document.temp.submit();
    }
}

function doCancel()
{
    document.temp.cancel.value="cancel";
    document.temp.action="ezAttachment.jsp"
    document.temp.submit();
}

