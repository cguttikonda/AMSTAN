function chkSubmit()
{
	var myFlag=true
	var myFlag1=true
	var FieldNames=new Array();
	var CheckType=new Array();
	var Messages=new Array();

	var ctr=0
	if(document.myForm.toUser.value=="")
	{
		FieldNames[0]="toUser";
		CheckType[0]="MNull";
		Messages[0]="Please enter TO";
		ctr++
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
					//alert("Please enter valid mail ids for CC")
					alert(msgString)
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
						//alert("Please enter valid mail ids for CC")
						alert(msgString)
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
				FieldNames[ctr]="ccUser";
				CheckType[ctr]="MEmail";
				Messages[ctr]="Please enter valid mail id for CC";
			}

		}
	}

	if(myFlag && myFlag1 && (funCheckFormFields(document.myForm,FieldNames,CheckType,Messages)))
	{
		//document.myForm.action=action="ezSendPersMsg.jsp"
		return true
	}
	return false
}
function funReset(){
	document.myForm.toUser.value="";
	document.myForm.ccUser.value="";
	document.myForm.bccUser.value="";
	document.myForm.msgSubject.value="";
	document.myForm.msgText.value="";
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
	}
	else
	{
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
		alert("Please select/enter To address");
		document.myForm.toUser.focus();
		return false;
	}
	else if((cc!="") || (bcc!=""))
	{
	  if(cc!="")
	  {
	   if(funEmail(cc))
	  {
	     if(bcc!="")
	     {
	        if(funEmail(bcc))
	        {
	   	     return true;
	   	}
	   	else
	   	{
	   	document.myForm.bccUser.focus();
	   	   return false;
	   	}
	     }
	     
	  }
	  else
	  {
	     if((bcc!="") && (cc==""))
	     {
	        if(funEmail(bcc))
	        {
	   	     return true;
	   	}
	   	else
	   	{
	   	document.myForm.bccUser.focus();
	   	   return false;
	   	}
	     }
	     else
	     {
	       document.myForm.ccUser.focus();
	        return false;
	     }
	  }
	 }
	 
	 
	 if(bcc!="")
	 {
	   
	   if(funEmail(bcc))
	  {
	     if(cc!="")
	     {
	        if(funEmail(cc))
	        {
	   	     return true;
	   	}
	   	else
	   	{
	   	document.myForm.ccUser.focus();
	   	   return false;
	   	}
	     }
	     
	  }
	  else
	  {
	     if(cc!="")
	     {
	        if(funEmail(cc))
	        {
	   	     return true;
	   	}
	   	else
	   	{
                  document.myForm.ccUser.focus();	   	
	   	   return false;
	   	}
	     }
	     else
	     {
                document.myForm.bccUser.focus();	     
	        return false;
	     }
	  }
	 }
	 
	 
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

function getAddressWindow()
{
	var url = "ezSelectUsers.jsp";
	var hWnd = 	window.open(url,"UserWindow","width=400,height=400,left=150,top=100,resizable=false,scrollbars=yes,toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}




function getAttachWindow()
{
	var attachedFiles="";
	var val=document.myForm.attachs.value
	if(val != "")
	{
		var arr=val.split('\n')
		for(var i=0;i<arr.length;i++)
		{
			if(arr[i] != "")
			{
				if(attachedFiles == "")
					attachedFiles = arr[i]
				else
					attachedFiles += "&attachedFiles="+arr[i];
			}
		}

	}

	var url = "ezAttachment.jsp?attachedFiles="+attachedFiles;
	var hWnd = 	window.open(url,"UserWindow","width=600,height=325,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}


function doAttach()
{
	var s="";
	if(document.myForm.attachList.length > 0)
		s=s+document.myForm.attachList.options[0].value;
	for(var i=1;i<document.myForm.attachList.length;i++)
	{
		s = s +"\n"+document.myForm.attachList.options[i].value;
	}
	parent.opener.myForm.attachs.value=s;
	window.close();
}


function doAttachFile()
{

	var val=document.myForm.attachFile.value
	if(val.indexOf('\\') > 0)
		val=val.substring(val.lastIndexOf('\\')+1,val.length)
	else if(val.indexOf('/') > 0)
		val=val.substring(val.lastIndexOf('/')+1,val.length)


	if(document.myForm.attachFile.value!="")
	{
		var attachedFiles="";
		var flag=false
		if(document.myForm.attachList.length > 0)
		{
			attachedFiles=document.myForm.attachList.options[0].value
			if(val == document.myForm.attachList.options[0].value)
				flag=true
		}
		for(var i=1;i<document.myForm.attachList.length;i++)
		{
			attachedFiles += "&attachList="+document.myForm.attachList.options[i].value
			if(val == document.myForm.attachList.options[i].value)
				flag=true
		}

		if(flag)
		{
			alert("File with this name is already attached")
		}
		else
		{
			document.myForm.action="ezUploadFiles.jsp?attachList="+attachedFiles;
			document.myForm.submit();
		}	
	}
	else
	{
		alert("Please select the file to attach");
	}
}

function doRemove()
{
	var count=0;
	if(document.myForm.attachList.length==0)
	{
		alert("Currently no attachments in your list");
	}
	else
	{
		for(var i=0;i<document.myForm.attachList.length;i++)
		{
			if(document.myForm.attachList.options[i].selected)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please select the files to remove");
		}
		else
		{
			var attachedFiles="";
			var toBeDelFiles="";
			if(document.myForm.attachList.length > 0)
			{
				attachedFiles=document.myForm.attachList.options[0].value
				if(document.myForm.attachList.options[0].selected)
					toBeDelFiles=document.myForm.attachList.options[0].value
			}
			for(var i=1;i<document.myForm.attachList.length;i++)
			{
				attachedFiles += "&allAttachedList="+document.myForm.attachList.options[i].value
				if(document.myForm.attachList.options[i].selected)
				{
					if(toBeDelFiles == "")
						toBeDelFiles = document.myForm.attachList.options[i].value
					else
						toBeDelFiles += "&toBeDelFiles="+document.myForm.attachList.options[i].value
				}
			}

			document.myForm.action="ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles;
			document.myForm.submit();
		}
	}
}

function doCancel()
{
   document.temp1.action="ezAttachment.jsp?operation=cancel";
   document.temp1.submit();
}
