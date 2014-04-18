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


function funsubmit()
{
	//document.myForm.BusUser.options[0].selected=true;
	document.myForm.action="ezUserAuthListBySysKey.jsp";
	document.myForm.submit();
}


function funsubmit1(area)
{
	
	if(document.myForm.WebSysKey.selectedIndex==0 && document.myForm.BusUser.selectedIndex==0)
	{
		alert("Please Select "+area +" and User");
		return;
	}
	
	if(document.myForm.BusUser.selectedIndex==0)
	{
		alert("Please select User");
	}
	else
	{
		document.myForm.action="ezUserAuthListBySysKey.jsp";
		document.myForm.submit();
	}

}


function setRoleCheck(a, b, tAuthCnt )
{

	if ( document.forms[0].elements['Check_'+a+'_0'].checked )
	{
		for( i = 0; i < tAuthCnt-1; i++)
		{

			if ( i != a && document.forms[0].elements['RoleKey_'+i+'_0'].value == ' ' )
			{
				document.forms[0].elements['Check_'+i+'_0'].checked=false;
				document.forms[0].elements['Check_'+i+'_0'].disabled=true;
			}
		}
	}
	else
	{
		for( i = 0; i < tAuthCnt-1; i++ )
		{
			if ( i != a && document.forms[0].elements['RoleKey_'+i+'_0'].value == ' ' )
			{
				document.forms[0].elements['Check_'+i+'_0'].checked=false;
				document.forms[0].elements['Check_'+i+'_0'].disabled=false;
			}
		}

	}
}

function myalert()
{
	document.myForm.action="ezUserAuthList.jsp";
	document.myForm.submit();
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


function selectAll(){
		  	
	  	len=document.myForm.elements.length
		

	  if(isNaN(len))
	  	{
	  		if(document.myForm.chk1Main.checked)
	  		{
	  			document.myForm.elements.checked=true
	  		}else{
	  			document.myForm.elements.checked=false
	  		}
	  	}
	  else
	    {	
	  	for(i=0;i<len;i++)
	  	{	if(document.myForm.chk1Main.checked)
	  		document.myForm.elements[i].checked=true
	  		else
	  		document.myForm.elements[i].checked=false
	  	}
            }
        }