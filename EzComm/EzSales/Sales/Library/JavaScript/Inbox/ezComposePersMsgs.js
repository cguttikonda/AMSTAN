

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
    		document.composeform.elements[fieldName].value = newChar;
	}
    	return true;

}

function VerifyEmptyFields() {
	if (document.forms[0].toUser.value == "" )
	{
		alert("Please select To address.");
		document.forms[0].toUser.focus();
		document.returnValue = false;
		return;
	}
        
	else{
		document.returnValue = true;
	}

	if (trim(document.forms[0].msgSubject.value) == "" )
	{
		alert("Please enter Subject.");
		document.forms[0].msgSubject.focus();
		document.returnValue = false;
		return;
	}else{
		document.returnValue = true;
	}
	

      
}

//added on 17/12/02
function NewVerifyEmptyFields() {
    var to=document.myForm.toUser.value;
    var cc=document.myForm.ccUser.value;
    var bcc=document.myForm.bccUser.value;
    var msg=document.myForm.msgText.value;
	if (( to == "" ) || (to.charAt(0) == " "))
	{
		alert("Please select/enter To address don't include spaces");
		document.myForm.toUser.focus();
		
		return false;
	}
	else if((cc!=""))
	{
	   var s=funEmail(cc);
	   document.myForm.ccUser.focus();
	   return s;
	}
        else if (bcc!="")
	{
            
	   var s=funEmail(bcc);
	   document.myForm.bccUser.focus();
	   return s;
	}
	else if (trim(msg) == "" )
	{
            
		alert("Please enter Message.");
		document.forms[0].msgText.focus();
		return false;           
	}
        else
	{
	     return true;
	}
	
}


function funEmail(cc)
{	
          var s=""
	invalidChars = "' /:,;"
	
	if(cc.indexOf("..")>=0)
	{
		alert("MailId with .. is invalid");
		return false
	}
	if(cc.indexOf(".@")>=0 || cc.indexOf("@.")>=0)
	{
		alert("MailId with .@ or @. is invalid");
		return false
	}

	for (i = 0; i< invalidChars.length; i++)
	{
		badChar = invalidChars.charAt(i)
		if (cc.indexOf(badChar,0) != -1)
		{
			alert("You can't use following characters " + invalidChars +" in your Email address.");
			return false;
		}
	}
	atPos = cc.indexOf("@",1)
	if (atPos == -1)
	{
		alert("You need to provide your Email UserId. i.e  your email should be in this format info@DataEdgeInc.com .");
		return false;
	}
	if (cc.indexOf("@",atPos+1) != -1)
	{
       		alert("The Email address you have provided does not have @ symbol. Please enter valid Email address.");
		return false;
	}

	periodPos = cc.lastIndexOf(".")	
		if (periodPos == -1)
	{
		alert("The Email address you have provided does not have .com or .net etc. Please provide a valid Email address.");
		return false;
	}
	if (! ( (periodPos+3 == cc.length) || (periodPos+4  == cc.length) ))
	{
		alert("The Email address you have provided does not have .com or .net etc. Please provide a valid Email address.");
		return false;
	}
	return true;	
}




function cancelMsg() {
	document.forms[0].action = "../Inbox/ezListPersMsgs.jsp";
	document.returnValue = true;
}

function getAddressWindow(type)
{
	var url = "ezSelectUsers.jsp?type="+type;
	
	var hWnd = 	window.open(url,"UserWindow","width=700,height=500,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
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
               alert("Please select the file to upload");
           }
        }

function doRemove()
{
   var count=0;
    if(document.temp.attachlist.length==0)
    {
         alert("Currently no attachments in your list");
    }
    else
    {
    for(var i=0;i<document.temp.attachlist.length;i++)
    {
        if(document.temp.attachlist.options[i].selected)
        {
            count++;
        }
    }
    if(count==0)
    {
         alert("Please select the option to remove");
    }
    else if(count > 1)
    {
       alert("Please don't select more than one option to remove");
    }
    else
    {

        document.temp.action="ezAttachment.jsp";
	  document.temp.target="_self"
        document.temp.submit();
    }
    }
}

function doCancel()
{
  document.temp1.action="ezAttachment.jsp?operation=cancel";
  document.temp1.submit();
}
