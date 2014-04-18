function funFoucs()
{
	if(document.myForm.SystemNumber!=null)
		document.myForm.SystemNumber.focus()
}
function checkAll(aRows)
	{
	if(document.forms[0].SystemNumber.selectedIndex==0)
		{
			alert("Please Select System.");
			document.forms[0].SystemNumber.focus();				
			document.returnValue=false;
		}	
	else
		{
			document.returnValue = true;
		}
	}

function myalert()
	{
	if(document.forms[0].SystemNumber.selectedIndex==0)
		{
			alert("Please Select System.");
			document.forms[0].SystemNumber.focus();				
			document.returnValue=false;
		}	
	else
		{
			document.myForm.action="ezListSystemAuth.jsp?sysnum="+document.myForm.SystemNumber.value
			document.myForm.submit();
		}
	}		

function setChecked(val) 
	{
	dml=document.forms[0];
	len = dml.elements.length;
	var i=0;
	for( i=0 ; i<len ; i++) 
		{
		dml.elements[i].checked=val;
		}
	}	


function init()
	{
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	//var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 		{
		myInit(2)
		if(getposition())
			{
			ScrollBox.show()
			}
		}
	}


	function selectAll()
	  {
	  	
	  	len=document.myForm.Check.length
	    	if(isNaN(len))
	  	{
	  		if(document.myForm.chk1Main.checked)
	  		{
	  			document.myForm.Check.checked=true
	  		}else{
	  			document.myForm.Check.checked=false
	  		}
	  	}
	  	else
	  	{	
	  	for(i=0;i<len;i++)
	  	{	if(document.myForm.chk1Main.checked)
	  		document.myForm.Check[i].checked=true
	  		else
	  		document.myForm.Check[i].checked=false
	  	}
	  	}
	  }


