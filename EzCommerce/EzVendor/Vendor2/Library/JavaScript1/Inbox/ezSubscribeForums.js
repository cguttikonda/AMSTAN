function CheckSelect() 
	{
	var pCount=0;
	var selCount=0;
	pCount = document.myForm.CheckBox.length;
	var i = 0;
	if(isNaN(pCount))
		{
		  if(document.myForm.CheckBox.checked)
		  selCount = selCount + 1;
		}			
	else
		{
		for ( i = 0 ; i < pCount; i++ ) 
			{
			if(document.myForm.CheckBox[i].checked)
				selCount = selCount + 1;
			}				
		}
	if(selCount<1)
		{
		alert("Select Forum(s) to subscribe");
		document.returnValue = false;
		}
	else
		{
		document.returnValue = true;
		}
	}
