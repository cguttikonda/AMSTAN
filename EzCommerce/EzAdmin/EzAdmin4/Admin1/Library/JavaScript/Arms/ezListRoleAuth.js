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


function check()
{
	if(document.forms[0].param.selectedIndex != 0)
	{
  		var len=document.myForm.CheckBox.length;
 		var count=0;
 		for(i=0;i<len;i++)
 		{
      			if(document.myForm.CheckBox[i].checked)
      			{
        	 		count++;
      			}
 		}
      		if(count==0)
      		{
        	   	alert("Please select the checkbox to update")
        	   	return false;
      		}
      		else
      		{
        	  	return true;
      		}
      	}
      	else
      	{
      		alert("Please select role")
      		document.forms[0].param.focus();
      		return false;
      	}
}

function myalert()
{
		myurl = document.URL;
		index = myurl.indexOf(".jsp");
	 	newurl = myurl.substring(0, index);
		mUrl1 =  newurl + ".jsp?";
		mUrl2 = "param=" + document.myForm.param.value;
		mUrl =  mUrl1 + mUrl2;
		location.href= mUrl;
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
	  	{	if(document.myForm.chk1Main.checked)
	  		document.myForm.CheckBox[i].checked=true
	  		else
	  		document.myForm.CheckBox[i].checked=false
	  	}
	  	}
	  }

function funOpen(value)
{
	var returnVal = window.showModalDialog("ezAuthActionsList.jsp",'window.self','center:yes;dialogWidth:40;dialogHeight:30;status:no;minimize:no;close:no;')
	
	var chkobj 	= document.myForm.CheckBox;
	var len 	= chkobj.length;
	
	if(returnVal!= null)
	{
		if(!isNaN(len))
		{
			for(i=0;i<len;i++)
			{
				if(i==value)
				{
					document.myForm.CheckBox[i].value = funTrim(chkobj[i].value)+"#"+funTrim(returnVal);
				}
			}
		}
	}	
}
