
//var tabHeadWidth=80
function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 //	var OuterdivId1=document.getElementById("OuterBox1Div")
 	if(InnerdivId1!=null)
 	{
		myInit(2)
		if(getposition())
		{
			ScrollBox.show()
		}
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

function setChecked(val) {
	dml=document.forms[0];
	len = dml.elements.length;
	var i=0;
	for( i=0 ; i<len ; i++) {
		dml.elements[i].checked=val;
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