function checkAll()
	{
	var selBox = 0;
	dRows = document.forms[0].CheckBox.length;
	if(isNaN(dRows))
		{
		if ( document.forms[0].CheckBox.checked )
			{
			selBox = 1;
			}
		}
	else
		{
		for ( i=0; i < dRows; i++ )
			{
			var FieldNames=new Array;
			var CheckType=new Array;
			var Messages=new Array;		
			document.forms[0].CheckBox.checked = true;
			var desc = document.forms[0].DefDesc[i].value;
			FieldNames[0]="DefDesc";
			CheckType[0]="MNull";
			Messages[0]="Please Enter Description";
			
			var bool=funCheckFormFields(document.myForm,FieldNames,CheckType,Messages)
			if(!bool)
			{
				document.returnValue=false;
				return;
			}
			
			if ( document.forms[0].CheckBox[i].checked )
				{
				selBox = 1;
				break;
				}
			}
		}			
	if ( selBox == 0 )
		{
		alert('Select atleast one system default to update');
		document.returnValue = false;
		}
	else
		{
		
			document.returnValue = true;
		}
	}

function myalert()
{
	if(document.forms[0].SystemKey.selectedIndex != 0)
	{
		myurl = document.URL;
    	    	index = myurl.indexOf(".jsp");
	 	newurl = myurl.substring(0, index);
		mUrl1 =  newurl + ".jsp?";
		mUrl2 = "SystemKey=" + document.myForm.SystemKey.value;
		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
	}
}	

function setCheck(i) 
	{
	var len = document.forms[0].CheckBox.length;
	if(isNaN(len))
		{
			var FieldNames=new Array;
			var CheckType=new Array;
			var Messages=new Array;		
			document.forms[0].CheckBox.checked = true;
			var desc = document.forms[0].DefDesc.value;
			FieldNames[0]="DefDesc";
			CheckType[0]="MNull";
			Messages[0]="Please Enter Description";
			
			if(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
			{
				document.returnValue = false;
				document.forms[0].CheckBox.checked = false;
			}
			else
			{
				document.returnValue = true;
			}
		}
		else
		{
			var FieldNames=new Array;
			var CheckType=new Array;
			var Messages=new Array;		
			document.forms[0].CheckBox[i].checked = true;
			var desc = document.forms[0].DefDesc[i].value;
			FieldNames[0]="DefDesc";
			CheckType[0]="MNull";
			Messages[0]="Please Enter Description";
			if(!funCheckFormFields(document.myForm,FieldNames,CheckType,Messages))
			{
				document.forms[0].DefDesc[i].focus();
				document.forms[0].CheckBox[i].checked = false;
				document.returnValue = false;
			}
			else
			{
				document.returnValue = true;
			}
		}			
	}

	function selectAll()
	  {
	  	
	  	len=document.myForm.CheckBox.length
		    if(isNaN(len))
		    {
	  		if(document.myForm.chk1Main.checked)
	  		{
	  			document.myForm.CheckBox.checked=true
	  		}else{
	  			document.myForm.CheckBox.checked=false
	  		}
		    }
	  	   else
	  	   {	
	  		for(i=0;i<len;i++)
	  		{	
			  if(document.myForm.chk1Main.checked)
	  		  document.myForm.CheckBox[i].checked=true
	  		  else
	  		  document.myForm.CheckBox[i].checked=false
	  		}
	  	   }
	  }
