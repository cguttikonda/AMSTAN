//var tabHeadWidth=90
 function init()
 {
 	var InnerdivId1=document.getElementById("InnerBox1Div")
 	//var OuterdivId1=document.getElementById("OuterBox1Div")
 	//var ScrollBoxDiv=document.getElementById("ScrollBoxDiv");
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
	document.myForm.BusinessPartner.options[0].selected=true;
	document.myForm.action="ezBPAuthListBySysKey.jsp";
	document.myForm.submit();
}

function funsubmit1()
{
	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel" && document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select <%=areaLabel.substring(0,areaLabel.length()-1)%> and BussinessPartner");
		return;
	}

	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.myForm.action="ezBPAuthListBySysKey.jsp";
		document.myForm.submit();
	}
}

function myalert(){
	myurl = document.URL;
	index = myurl.indexOf(".jsp");
 	newurl = myurl.substring(0, index);
	mUrl1 =  newurl + ".jsp?";
	mUrl2 = "BusinessPartner=" + document.myForm.BusPartner.value;
	mUrl =  mUrl1 + mUrl2;
	location.href= mUrl;
}

function setChecked(val) {
	dml=document.forms[0];
	len = dml.elements.length;
	var i=0;
	for( i=0 ; i<len ; i++) {
		dml.elements[i].checked=val;
	}
}

function selectAll(){
		  	
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