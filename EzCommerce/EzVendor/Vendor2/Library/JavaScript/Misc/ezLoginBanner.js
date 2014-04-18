var ctrlKeyFlag = false
document.onkeyup = function()
{
    if(window.event && window.event.keyCode == 17)
		ctrlKeyFlag = false
}
document.onkeydown = function()
{
	    if(window.event && window.event.keyCode == '17')
	    {
			ctrlKeyFlag = true
	    }
	    if(window.event && window.event.keyCode == 78 && ctrlKeyFlag)
	    {
			return false; // Must return false or the browser will execute old code
	    }
}
function focusOnTxt()
{
	document.myForm.Vndr.value='';
}	
function defTxtVal()
{
	if(document.myForm.Vndr.value=="")
		document.myForm.Vndr.value = "Search Vendor";
}

function KeySubmit()
{
	if (event.keyCode==13)
	{
		OpenVendorSearchWin();
	}
}

function getVndr()
{
	var vndrName = funTrim(document.myForm.Vndr.value);
	var soldToLen = document.myForm.SoldTo.length;
	var selFlag = false
	for(var i=0;i<soldToLen;i++)
	{
		var vndrFrmList = document.myForm.SoldTo[i].text;
		var vndrFullNm = vndrFrmList.substring(vndrFrmList.indexOf("-->")+4,vndrFrmList.length);

		vndrFullNm = funTrim(vndrFullNm);

		vndrFullNm = vndrFullNm.toUpperCase();
		vndrName  =  vndrName.toUpperCase();

		if(vndrFullNm.indexOf(vndrName)==0)
		{
			document.myForm.SoldTo.selectedIndex=i;
			selFlag = true
			break;
		}
	}

	if(selFlag)
		changeVendor('Y')
}


function OpenVendorSearchWin()
{
	var vndrName = funTrim(document.myForm.Vndr.value);
	if(vndrName=="Search Vendor" || vndrName=="")
	{
		alert("Please Enter Search String.");
		document.myForm.Vndr.focus();
		return false;
	}
	var retValue = window.showModalDialog("ezVendorSearchPopUp.jsp?CatalogArea="+document.myForm.CatalogArea.value+"&VENDCODE="+document.myForm.Vndr.value,window.self,"center=yes;dialogHeight=28;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
	if(retValue!=null)
	{
		var args = retValue.split("¥")
		document.myForm.Vndr.value = args[0]+"("+args[1]+")";
		document.myForm.VENDOR_CODE.value = args[0]
		document.myForm.VENDOR_NAME.value = args[1]
		changeVendor('Y')
	}
	else
	{
		document.myForm.Vndr.value=document.myForm.VENDOR_CODE.value+" --> "+document.myForm.VENDOR_NAME.value;
	}
}

