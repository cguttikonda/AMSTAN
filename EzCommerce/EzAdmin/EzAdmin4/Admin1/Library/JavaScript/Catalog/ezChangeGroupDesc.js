
var usetOption=0

function setFocus()
{
	document.myForm.SystemKey.focus()
}
function setOption(opt)
{
 	userOption=opt
}
function submitForm()
{
      	if(userOption==1)
       	{
          	document.myForm.action="ezChangeGroupDesc.jsp"
          	document.myForm.submit()
          	return true
       	}
       	else if(userOption==2)
       	{
          	if(checkSelection())
          	{
            		document.myForm.action="ezSaveGroupDesc.jsp"
           		return true
          	}
          	else
           		return false
       	}
}

function checkSelection()
{
    	var chkBoxNum=document.myForm.CheckBox.length
    	var selectedCount=0
    
    	if(isNaN(chkBoxNum)) //if only one checkbox is available
      	{
        	if(document.myForm.CheckBox.checked)
         		selectedCount++
      	}
      	else //if more than one checkbox is available
      	{
        	for(i=0;i<chkBoxNum;i++)
         	{
           		if(document.myForm.CheckBox[i].checked)
           		  	selectedCount++
         	}
      	}
      
     	if(selectedCount==0) //if user did not select atleast one checkbox
     	{
       		alert("Please select atleast one product to change description")
       		return false
     	}
     
    	//check whether user entered description for selected product
        if(isNaN(chkBoxNum)) //if only one checkbox is available
      	{
		var FieldNames=new Array;
		var CheckType=new Array;
		var Messages=new Array;
		FieldNames[0]="WebDesc";
		CheckType[0]="MNull";
		Messages[0]="Please Enter Web Description";
		if(!(funCheckFormFields(document.myForm,FieldNames,CheckType,Messages)))
		{
                	return false
            	}
            	else
            	{
            		return true;
            	}
      	}
      	else
      	{
        	for(i=0;i<chkBoxNum;i++)
        	{
			var FieldNames=new Array;
			var CheckType=new Array;
			var Messages=new Array;
			FieldNames[0]="WebDesc";
			CheckType[0]="MNull";
			Messages[0]="Please Enter Web Description";
			if(!( funCheckFormFields(document.myForm,FieldNames,CheckType,Messages)))
			{
              			return false;
           		}
           		else
           		{
           			return true;
           		}
        	}
     	}  
   	return true
} //function end

function funSubmit()
{
	if(document.myForm.SystemKey.selectedIndex != 0)
	{
		userOption=1
		submitForm()
	}
}
