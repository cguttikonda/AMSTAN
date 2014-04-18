function setFocus()
{
	if(document.myForm.SystemDesc!=null)
	{
		if(isNaN(document.myForm.SystemDesc.length))
			document.myForm.SystemDesc.focus()
		else
			document.myForm.SystemDesc[0].focus()
	}
}

function funCheckBoxModify()
{

	var len=document.myForm.chk.length;
	var FieldNames=new Array;
	var CheckType=new Array;
	var Messages=new Array;
	if(isNaN(len))
	{
		if(document.myForm.chk.checked)
		{
			FieldNames[0]="SystemDesc";
			CheckType[0]="MNull";
			Messages[0]="Please enter description";
			
			if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
			{
				document.myForm.chk.value=document.myForm.chk.value+"#"+document.myForm.SystemDesc.value;
				return true
			}
			else
				return false
		}
		else
		{
			alert("Please select checkbox for update");
			return false
		}
	}
	else
	{
		var flag=false;
		
		for(i=0;i<len;i++)
		{
			if(document.myForm.chk[i].checked)
			{
				flag=true
				FieldNames[0]="SystemDesc";
				CheckType[0]="MNull";
				Messages[0]="Please enter description";
							
				if(! funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
					return false
					
				document.myForm.chk[i].value=document.myForm.chk[i].value+"#"+document.myForm.SystemDesc[i].value;	
			}
		}
		if(flag)
		{
			return true
		}	
		else	
		{
			alert("Please select atleast one checkbox to update")
			return false
		}
	}
}

function selectAll()
{
	  	
	  	len=document.myForm.chk.length
		    if(isNaN(len))
		    {
	  		if(document.myForm.chk1Main.checked)
	  		{
	  			document.myForm.chk.checked=true
	  		}else{
	  			document.myForm.chk.checked=false
	  		}
		    }
	  	   else
	  	   {	
	  		for(i=0;i<len;i++)
	  		{	
			  if(document.myForm.chk1Main.checked)
	  		  document.myForm.chk[i].checked=true
	  		  else
	  		  document.myForm.chk[i].checked=false
	  		}
	  	   }
}

