
var tabHeadWidth=80

function enableCheck(cFlag, cValue)
{
	alert('These Product Groups are already synchronized\nYou cannot remove them');
	if ( cFlag == 'C' )
	{
		document.forms[0].CheckBox[cValue].focus();
		document.forms[0].CheckBox[cValue].checked = true;
	}
	if ( cFlag == 'S' )
	{
		document.forms[0].ShowAll[cValue].focus();
		document.forms[0].ShowAll[cValue].checked = true;
	}
	if ( cFlag == 'I' )
	{
		document.forms[0].ImageFlag[cValue].focus();
		document.forms[0].ImageFlag[cValue].checked = true;
	}
}

function SyncWH() {
	if (document.forms[0].ProductGroup.value=="")
    	{
	    	alert('Product Group cannot be empty');
		document.returnValue = false;
		document.forms[0].ProductGroup.focus();
     	}
     	else
     	{
 		//If No product hierarchies exist
 		document.forms[0].action='Synchronize.jsp';
		document.returnValue = true;
     	}
}
function AddCheckSelect() {

	var pCount=0;
	var selCount=0;
	var i = 0;

	pCount = document.forms[0].CheckBox.length;
	if(isNaN(pCount))
	{
		if(document.forms[0].CheckBox.checked)
			selCount=1
	}
	else
	{
		for ( i = 0 ; i < pCount; i++ ) 
		{
		  if(document.forms[0].CheckBox[i].checked)
		    {
			selCount = selCount + 1;
			break;
		    }
		}
	}	
	if(selCount<1)
	{
		alert("Select Product Group(s) to Synchronize");
		document.returnValue = false;
	}else
	{
		document.forms[0].action = "Synchronize.jsp";
		document.returnValue = true;
		
	}
	
}

function SelectChk(index, chkBox, str_new, offset, test)
{

	

 	var i;
	try{
	var start_index = index;
	var pCount = document.forms[0].TotalCount.value;
	var testCount = document.myForm.CheckBox.length;
	var length_current = str_new.length;

	
	var c1=(document.myForm.CheckBox[start_index].checked)
	
	for(i = start_index; i < testCount; i++)
	{
		try{
		var str = document.myForm.CheckBox[i].value;
		//var str_act = (str.substring(1,(offset+1)));
		//if (str_act == str_new )
			
	        if(str.indexOf(str_new)==1)
	        {
	        	document.myForm.CheckBox[i].checked = c1;
		}
		else
		{
			// I am pretty sure to break here or not.
			//I guess we can break here.
			break;
			
		}
}catch(myerroe){}
		
	}
}catch(error){}
  
 
}

