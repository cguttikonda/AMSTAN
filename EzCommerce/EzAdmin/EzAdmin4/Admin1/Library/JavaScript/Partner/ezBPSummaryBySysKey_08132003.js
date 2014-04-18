function funsubmit()
{
	document.myForm.BusinessPartner.options[0].selected=true;
	document.myForm.action="ezBPSummaryBySysKey.jsp";
	document.myForm.submit();
}
function funsubmit1(area)
{
	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel" && document.myForm.WebSysKey.options[document.myForm.WebSysKey.selectedIndex].value=="sel")
	{
		alert("Please Select " +area +" and BussinessPartner");
		return;
	}
	if(document.myForm.BusinessPartner.options[document.myForm.BusinessPartner.selectedIndex].value=="sel")
	{
		alert("Please select Bussiness Partner");
	}
	else
	{
		document.myForm.action="ezBPSummaryBySysKey.jsp";
		document.myForm.submit();
	}
	
}
function UsersSummary()
{
	if(navigator.appName=="Microsoft Internet Explorer")
	{
		if (document.all["bpuser"].style.visibility=="visible")
		{
			document.all["bpuser"].style.visibility="hidden";
			document.all["bparea"].style.visibility="visible";
			document.forms['BPSummary'].userarea.src='../../../Admin1/Images/Buttons/BLUE/viewuserareas.gif'
			
		}
		else
		{
			document.all["bpuser"].style.visibility="visible";
			document.all["bparea"].style.visibility="hidden";
			document.forms['BPSummary'].userarea.src='../../../Admin1/Images/Buttons/BLUE/viewpartnerareas.gif'
			
		}
	}
	else 	if(navigator.appName=="Netscape")
	{

		if (document.layers[1].visibility=="show")
		{
			document.layers[1].visibility="hide";
			document.layers[0].visibility="show";
			document.forms['BPSummary'].userarea.src='../../Images/Buttons/ViewUserAreas.gif'
		}
		else
		{
			document.layers[1].visibility="show";
			document.layers[0].visibility="hide";
			document.forms['BPSummary'].userarea.src='../../Images/buttons/ViewPartnerAreas.gif'
		}
	}
} //end UsersSummary

function myalert()
{
	document.myForm.action = "ezBPSummary.jsp?BusinessPartner=" + document.myForm.BusPartner.options[document.myForm.BusPartner.selectedIndex].value;
	document.myForm.submit();
}//end myalert