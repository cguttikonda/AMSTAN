function setFocus()
{
	if(isNaN(document.myForm.DefDesc.length))
		document.myForm.DefDesc.focus()
	else
		document.myForm.DefDesc[0].focus()
}

function checkAll()
	{
	fRows = document.forms[0].CheckBox.length;
	var selBox = 0;
	for ( i=0; i < fRows; i++ )
		{
		if ( document.forms[0].CheckBox[i].checked==true )
			{
			selBox = 1;
			break;
			}
		}
	if ( selBox == 0 )
		{
		alert('Select atleast one site default to update');
		document.returnValue = false;
		}
	else
		{
		setCheck(i)
		if(document.returnValue == true)
			document.returnValue = true;
		else			
			document.returnValue = false;
		}
	}

function setCheck(i) 
	{
	var len = document.forms[0].CheckBox.length;
	if(isNaN(len))
		{
		document.forms[0].CheckBox.checked = true;
		var desc = document.forms[0].DefDesc.value;
		if(desc == "")
			{
			alert("Please Enter Description.");
			document.forms[0].DefDesc.focus();
			document.returnValue = false;
			}
		else
			{
			document.returnValue = true;
			}
		}
	else
		{
		document.forms[0].CheckBox[i].checked = true;
		var desc = document.forms[0].DefDesc[i].value;
		if(desc == "")
			{
			alert("Please Enter Description.");
			document.forms[0].DefDesc[i].focus();
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
