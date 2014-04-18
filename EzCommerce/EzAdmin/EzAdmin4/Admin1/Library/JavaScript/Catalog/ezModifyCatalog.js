
function SelectChk(index, chkBox, str_new, offset, test)
{
 
  	var i;
 	
 	var start_index = index;
 	
 	var testCount = document.myForm.CheckBox.length;
 	var length_current = str_new.length;
 
 	var obj=document.myForm.CheckBox.length
 	var c1="" 
 	if(isNaN(obj))
 		c1=(document.myForm.CheckBox.checked)
 	else	
 		c1=(document.myForm.CheckBox[start_index].checked)
 	
 	
 	for(i = start_index; i < testCount; i++)
 	{
 		
 		var str = document.myForm.CheckBox[i].value;
 		var str_act = (str.substring(1,(offset)));
 			
 		
 		if (str_act == str_new )
 		{
 			document.myForm.CheckBox[i].checked = c1;
 			
 		}
 		
	}
}

var userOption=0
function setOption(opt)
{
   userOption=opt
}

function submitForm()
{
	  //check whether user selected valid option or not
	/*  if(document.myForm.CatalogNumber.value=="sel")
	   {
	      alert("Please select catalog")
	      document.myForm.CatalogNumber.focus()
	      return false
	   }
	   if(document.myForm.SystemKey.value=="sel")
	   {
		      alert("Please select sales area")
		      document.myForm.SystemKey.focus()
		      return false
           }
        */
        
	 if(userOption==1) //if user clicks on show button
	 {
	       
	    document.myForm.action="ezModifyCatalog.jsp"
	    document.myForm.submit()
	    return true
	    
	 }//if userOption==1
	 else
	 if(userOption==2) //if user clicks on update button
	 {
		var  pCount = document.forms[0].CheckBox.length;
		var selCount=0
		if(isNaN(pCount))
		{
			if(document.forms[0].CheckBox.checked)
				selCount=1;
		}
		else
		{
			for ( i = 0 ; i < pCount; i++ ) 
			{
				if(document.forms[0].CheckBox[i].checked)
				selCount = selCount + 1;
			}
		}	
		
		if(selCount<1)
		{
			alert("Select Product Group(s) Before Modifing Catalog");
			return  false;
		}
	 	
		document.myForm.action="ezSaveModifyCatalog.jsp"
		return true
	 }
	
	}

function funSubmit()
{
	if(document.myForm.CatalogNumber.selectedIndex != 0 && document.myForm.SystemKey.selectedIndex != 0)
	{
		userOption=1
		submitForm()
	}
}