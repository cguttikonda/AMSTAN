function chkSubmit()
{
	
	var myFlag=true
	var myFlag1=true
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();
	
    	var msg=document.myForm.msgText.value;
    	
    	
	/* if(document.myForm.attachs.length>0)
	{
		document.myForm.attachflag.value="true";
		var astring=""
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			astring=astring+document.myForm.attachs.options[i].value+",";
		}
		astring=astring.substring(0,astring.length-1);
		document.myForm.attachString.value=astring;

	} */
	if(((document.myForm.toUser.value).indexOf("@")>=0))
	{
		var val=document.myForm.toUser.value
		alert("sorry external mails are not allowed")
		//myFlag1=false;
		document.myForm.toUser.focus();
		return false;
		
	}
	/**** CC*******/
	if(document.myForm.ccUser.value != "")
	{
		if(((document.myForm.ccUser.value).indexOf("@")>=0))
		{
			var val=document.myForm.ccUser.value
			alert("sorry external mails are not allowed")
			//myFlag1=false;
			document.myForm.ccUser.focus();
			return false;									
		}
	}
	
	/**** BCC*******/
	if(document.myForm.ccUser.value != "")
	{
		if(((document.myForm.bccUser.value).indexOf("@")>=0))
		{
			var val=document.myForm.bccUser.value
			alert("sorry external mails are not allowed")
			//myFlag1=false;
			document.myForm.bccUser.focus();
			return flase;									
		}
	}
	if (trim(msg) == "" )
	{
		alert(plzEnMsg_L);
		document.forms[0].msgText.focus();
		return false;
	}

	var ctr=0
	
	
	if(document.myForm.toUser.value=="")
	{
		alert(plzSelEntAdd_L);
		document.myForm.toUser.focus();
		return false;
	}
	else if(((document.myForm.toUser.value).indexOf("@")>=0) || (((document.myForm.toUser.value).indexOf(".")>=0)))
	{
		
		
		var val=document.myForm.toUser.value
		
		
		
		var obj=val.split(",");
		
		
		for(var i=0;i<obj.length;i++)
		{
			if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
			{
				myFlag1 = funEmail(obj[i])
				if(! myFlag)
				{
					document.myForm.toUser.focus()
					break;
				}
			}
		}

	}
	if(document.myForm.ccUser.value != "" && myFlag1)
	{
		if((document.myForm.ccUser.value).indexOf(",")>0)
		{
			var val=document.myForm.ccUser.value
			var obj=val.split(",")
			for(var i=0;i<obj.length;i++)
			{
				if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
				{
					myFlag = funEmail(obj[i])
					if(! myFlag)
					{
						document.myForm.ccUser.focus()
						break;
					}
				}
			}
		}
		else
		{
			if(((document.myForm.ccUser.value).indexOf("@")>=0) || (((document.myForm.ccUser.value).indexOf(".")>=0)))
			{
				myFlag1 = funEmail(document.myForm.ccUser.value)
				
				if(!myFlag1)
				{
					document.myForm.ccUser.focus()
					return false;
				}
			}

		}
	}

	if(document.myForm.bccUser.value != "" && myFlag1)
	{
		if((document.myForm.bccUser.value).indexOf(",")>0)
		{
			var val=document.myForm.bccUser.value
			var obj=val.split(",")
			for(var i=0;i<obj.length;i++)
			{
				if((obj[i].indexOf("@")>=0) || ((obj[i].indexOf(".")>=0)))
				{
					myFlag = funEmail(obj[i])
					if(! myFlag)
					{
						document.myForm.bccUser.focus()
						break;
					}
				}
			}
		}
		else
		{
			if(((document.myForm.bccUser.value).indexOf("@")>=0) || (((document.myForm.bccUser.value).indexOf(".")>=0)))
			{
				myFlag1 = funEmail(document.myForm.bccUser.value)
				if(!myFlag1)
				{
					document.myForm.bccUser.focus()
					return false;
				}
			}

		}
	}


	if(myFlag && myFlag1)
	{
		//document.myForm.action=action="ezSendPersMsg.jsp"
		return true
	}
	return false
}


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
		alert(plzSelToAdd_L);
		document.forms[0].toUser.focus();
		document.returnValue = false;
		return;
	}

	else{
		document.returnValue = true;
	}
}

//added on 17/12/02
function NewVerifyEmptyFields() {
    var to=document.myForm.toUser.value;
    var cc=document.myForm.ccUser.value;
    var bcc=document.myForm.bccUser.value;
    var msg=document.myForm.msgText.value;
    var myFlag1 = true;
    
    	if(((document.myForm.toUser.value).indexOf("@")>=0))
	{
		var val=document.myForm.toUser.value
		alert("sorry external mails are not allowed")
		myFlag1=false;
		document.myForm.toUser.focus();
		return false;
			
	}
	/**** CC*******/
	if(document.myForm.ccUser.value != "")
	{
		if(((document.myForm.ccUser.value).indexOf("@")>=0))
		{
			var val=document.myForm.ccUser.value
			alert("sorry external mails are not allowed")
			myFlag1=false;
			document.myForm.ccUser.focus();
			return false;									
		}
	}
	
	/**** BCC*******/
	if(document.myForm.ccUser.value != "")
	{
		if(((document.myForm.bccUser.value).indexOf("@")>=0))
		{
			var val=document.myForm.bccUser.value
			alert("sorry external mails are not allowed")
			myFlag1=false;
			document.myForm.bccUser.focus();
			return false;									
		}
	}
    
	/* if(document.myForm.attachs.length>0)
	{
		document.myForm.attachflag.value="true";
		var astring=""
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			astring=astring+document.myForm.attachs.options[i].value+",";
		}
		astring=astring.substring(0,astring.length-1);
		document.myForm.attachString.value=astring;

	} */

	else if (( to == "" ) || (to.charAt(0) == " "))
	{
		alert(plzSelToAddNoSp_L);
		document.myForm.toUser.focus();
		myFlag1 = false;
		return false;
	}
	/*else if((cc!=""))
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
	}*/
	else if (trim(msg) == "" )
	{

		alert(plzEnMsg_L);
		document.forms[0].msgText.focus();
		myFlag1 = false;
		return false;
	}
        if(myFlag1)
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
		alert(mailIdInv_L);
		return false
	}
	if(cc.indexOf(".@")>=0 || cc.indexOf("@.")>=0)
	{
		alert(mailAtInv_L);
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
		alert(mailIdFormat_L);
		return false;
	}
	if (cc.indexOf("@",atPos+1) != -1)
	{
       		alert(mailNoAt_L);
		return false;
	}

	periodPos = cc.lastIndexOf(".")
		if (periodPos == -1)
	{
		alert(mailNoCom_L);
		return false;
	}
	if (! ( (periodPos+3 == cc.length) || (periodPos+4  == cc.length) ))
	{
		alert(mailNoCom_L);
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
	var hWnd = 	window.open(url,"UserWindow","width=600,height=400,left=150,top=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no");
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

       window.opener.document.myForm.attachs.value=s;
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
               alert(plzSelFile_L);
           }
        }

function doRemove()
{
   var count=0;
   
    if(document.temp.attachlist.length==0)
    {
         alert(curNoAttach_L);
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
         alert(plzSelOptRem_L);
    }
    else if(count > 1)
    {
       alert(plzNotSelMore_L);
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
	window.close();
	alert(document.temp1.fname.value);
	document.temp1.fname.value="";
	alert(document.temp1.fname.value);
  //document.temp1.action="ezAttachment.jsp?operation=cancel";
  //document.temp1.submit();
}
