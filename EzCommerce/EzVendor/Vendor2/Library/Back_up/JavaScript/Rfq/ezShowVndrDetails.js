function funShowVndrDetails(syskey,soldto)
{
		var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
}