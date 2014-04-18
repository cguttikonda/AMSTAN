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
		document.returnValue = false;
		return;
	}
	else if((cc!="") && (cc.indexOf("@")<0))
	{
           
          
		alert("Please select/enter Cc and include @ in your address.");
		document.forms[0].ccUser.focus();
		document.returnValue = false;
		return;
             
	}
        else if ((bcc!="") && (bcc.indexOf("@")<0))
	{
            
		alert("Please select/enter Bcc and include @ in your address.");
		document.forms[0].bccUser.focus();
		document.returnValue = false;
		return;
          
	}
	else if (trim(msg) == "" )
	{
            
		alert("Please enter Message.");
		document.forms[0].msgText.focus();
		document.returnValue = false;
		return;
           
	}
        else
	{
	     document.returnValue = true;
	}
	
}


function VerifyEmptyFields() 
{
	
    var to=document.myForm.toUser.value;
    var msg=document.myForm.msgSubject.value;
	if ( to == "" )
	{
		alert("Please Select/Enter To Address");
		document.myForm.toUser.focus();
		document.returnValue = false;
		return false;
	}
	else if(msg=="")
	{
		alert("Please Enter Subject");
		document.myForm.msgSubject.focus();
		document.returnValue = false;
		return false;
	
	}
	else
	{
		document.returnValue=true;
	}
	
}


function cancelMsg() {
	document.forms[0].action = "../Inbox/ezListPersMsgs.jsp";
	document.returnValue = true;
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
	   var bool="false"
           if(document.doneattach.attfile.value!="")
	   {
	   	for(var i=0;i<document.temp.attachlist.length;i++)
	   	{
	   		var cfile=document.doneattach.attfile.value;
			 ffile=cfile.split("\\");
	   		var finalfile=ffile[ffile.length-1];
	   		if(finalfile==document.temp.attachlist.options[i].text)
	   		{
	   			bool="true"
	   			alert("A File is already attached with the same name");
	   			break;	
	   			
	   		}
	   	}
	   
	   	if(bool=='false')
	   	{
	   		 document.doneattach.action="ezUploadFiles.jsp";
	   		 document.doneattach.submit();
	   	}
           }
           else
	   {
               alert("please select the file to upload");
           }
        }

function doRemove()
{
   var count=0;
    if(document.temp.attachlist.length==0)
    {
         alert("currenty no attachments in your list");
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
         alert("pls select the option to remove");
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


   