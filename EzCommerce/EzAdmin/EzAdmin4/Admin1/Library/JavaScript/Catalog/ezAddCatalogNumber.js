
var userOption=0

function setOption(opt)
{
  
  userOption=opt
 
}
function submitForm()
{
   /*if(document.myForm.SystemKey.value=="sel")
      {
               alert("Please select sales area")
               document.myForm.SystemKey.focus()
               return false
      }*/
 	
    if(userOption==1)   //if user clicks on show button
    {
       document.myForm.action="ezAddCatalogNumber.jsp"
       document.myForm.submit()
       return true
    }   
    else
     if(userOption==2) //if user clicks on add button
     {
         
	var pCount=0;
	var selCount=0;
	var indexCount=0;
	var i = 0;

	pCount = document.forms[0].CheckBox.length;
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
		alert("Select Product Group(s) Before Adding Catalog");
		return  false;
	}
	
	/*if(indexCount<1)
	{
	   alert("Select Main Index Group Before Adding Catalog");
	   return false;
	}*/
        if(document.forms[0].CatalogName.value=="")
         {
	      alert("Enter Catalog Description");
	      document.forms[0].CatalogName.focus()
	      return false;
	  }
	  
	     document.forms[0].action = "ezAddNewCatalog.jsp";
	      return true;
	}//if(userOption==2)
	
}

function SelectChk(index, chkBox, str_new, offset, test)
{
 	var i;
	
	var start_index = index;
	var pCount = document.forms[0].TotalCount.value;
	var testCount = document.myForm.CheckBox.length;
	var length_current = str_new.length;
	
	if(! isNaN(testCount))
	{
		
		
		var c1=(document.myForm.CheckBox[start_index].checked)
		for(i = start_index; i < testCount; i++)
		{
		
			var str = document.myForm.CheckBox[i].value;
			var str_act = (str.substring(1,(offset)));
		        if (str_act == str_new )
			{
		        	document.myForm.CheckBox[i].checked = c1;
			}
		
		}
		myCheck=document.getElementById(document.myForm.CheckBox[start_index].value)
		myCheck.checked=document.myForm.CheckBox[start_index].checked
		
	}
	else
	{
	
		myCheck=document.getElementById(document.myForm.CheckBox.value)
		myCheck.checked=document.myForm.CheckBox.checked
	}
 
}

function funSubmit()
{
	if(document.myForm.SystemKey.selectedIndex != 0)
	{
		userOption=1
		submitForm()
	}	
}
