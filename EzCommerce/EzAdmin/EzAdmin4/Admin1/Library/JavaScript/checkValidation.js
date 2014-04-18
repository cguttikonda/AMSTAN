function validateChecks(theField,thisForm,value1)
{

	if(theField!=null)
	{
		var i=0;
		var val=0;
		var checkval = false;
		var checkval1=false;
		var checkednr=0;
		var theInput=theField;

		var theLength=theField.length;     

                                  var nooffields = parent.frames[0].document.forms[0].elements.length;
	        var checkdis=0;
		if(isNaN(theLength))
		{
			if(theInput.checked) 
			{
				checkednr+=1;
				checkval = true;
			}
		}
		else
		{
			for( i=0;i<TheLength;i++)
			{
				if(theInput[i].checked)
				{
					val = i;
					checkednr+=1;
				}
				checkval=true;
			}
		}
	        
		if(checkednr==0)
        	{
        		alert(" Please select an item from the list shown to ' "+value1+" '");      
		}
		else if(checkednr>1)
		{
        		alert(" Please make single selection !!!");
		}
	        else if(checkednr==1)
        	{
                	if(value1=="Delete")
			{
				if(confirm("Are you sure you want to delete the selected record?"))
				{
					checkval=true;
				}
				else
				{
					checkval=false;
                                                                                     if(nooffields>1)
					theInput[val].checked=false;
                                                                                      else
					theInput.checked=false;
				}
			}
			if(value1=="Edit")
 			{   
				checkval=true;
			}
			if(checkval==true)
			{
                		thisForm;
				parent.frames[0].document.forms[0].target="_parent";
				parent.frames[0].document.forms[0].submit();
			}
	
		}
	}
	else
	{
		alert("No Data Found");	
	}
}

function validate(theField,thisForm,value1)
{
		var i=0;
		var val=0;
		var checkval = false;
		var checkednr=0;
		var theInput=theField;
		var theLength=theField.length;     
	        var checkdis=0;
		if(isNaN(theLength))
		{
			if(theInput.checked) 
			{
				checkednr+=1;
				checkval = true;
			}
		}
		else
		{
			for( i=0;i<TheLength;i++)
			{
				if(theInput[i].checked)
				{
					val = i;
					checkednr+=1;
				}
				checkval=true;
			}
		}
	        
		if(checkednr==0)
        	{
        		alert(" Please select one or more items from the list to ' "+value1+" '");      
		}
		else if(value1=="Show Graphical Structure")
 		{   
                		thisForm;
				parent.frames[0].document.forms[0].target="_parent";
				parent.frames[0].document.forms[0].submit();
		}
}