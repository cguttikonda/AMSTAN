function funSubmit(from)
{
	if(chkMail())
	{
		document.myForm.action="ezAddSaveSalesDocMails.jsp?From="+from;
		document.myForm.submit()
	}
}

function chkMail()
{
	var FieldName=new Array();
	var CheckType=new Array();
	var Messages=new Array();

	FieldName[0] = "PCode";
	CheckType[0] = "MNULL";
	Messages[0] = "Please enter Product Code.";
        
                
        var cnt=0;
		
	if(document.myForm.To.value!="")
	{
	    	var value1="";
		var ccc=document.myForm.To.value;	
		if(ccc.indexOf(",")!=-1)
		{
			value1=ccc.split(",");			
			for(var i=0;i<value1.length;i++)
			{		
			 	if(!funEmail(value1[i]))
			 	{
			 		alert("Please Enter Valid Email Address.")
			 		document.myForm.To.focus();
			 		return false;
			 	}
	                }
		}
		else
		{
			
			
			FieldName[cnt] = "To";	
			CheckType[cnt] = "MEMAIL";
			Messages[cnt] = "Please enter Valid Email Address.";
			cnt++;		
		}
	}

		
	if(document.myForm.Cc.value!="")
	{
		var value1="";
		var ccc=document.myForm.Cc.value;		
		if(ccc.indexOf(",")!=-1)
		{
			value1=ccc.split(",");			
		   	for(var i=0;i<value1.length;i++)
		   	{		
		 		if(!funEmail(value1[i]))
		 		{
		 			alert("Please Enter Valid Email Address.")
		 			document.myForm.Cc.focus();
		 			return false;
		 		}
                	}
		}
		else
		{
			FieldName[cnt] = "Cc";
			CheckType[cnt] = "MEMAIL";
			Messages[cnt] = "Please enter Valid Email Address.";
			cnt++;
		}
	}
	

	if(document.myForm.Plant.value!="")
	{
		FieldName[cnt] = "Plant";
		CheckType[cnt] = "MNULL";
		Messages[cnt] = "Please enter Plant.";
		cnt++
	}
		
	var s= funCheckFormFields(document.myForm,FieldName,CheckType,Messages);
	
	return s;
}
