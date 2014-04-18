function funNum(sValue)
{
	var nValue=parseFloat(sValue);
	nValue=nValue+"";
	if ((sValue != nValue) || nValue < 0)
	{
		return false;
	}
	return true;
}
function searchMaterial()
{

	var matNo = document.myForm.matNum.value; 
	
	if(matNo=="")
	{
		alert("Please enter Material Number.");
		document.myForm.matNum.focus();
		return;
	}
	
	var maxRows= prompt("Please enter Maximum Rows ('0' for all)", '0');
	
	//alert(maxRows);
	if(isNaN(maxRows))
	{
		alert("Please enter Number");
		var maxRows= prompt("Please enter Maximum Rows ('0' for all)", '0');
		
	}	
	
	if(maxRows=="" || maxRows==null || isNaN(maxRows))
		maxRows = 0;
	
	
	var url="ezListMaterials.jsp?matCode="+matNo+"&maxRows="+maxRows;
	newWindow=window.open(url,"ReportWin","width=700,height=500,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

}
function getMaterialDesc()
{
	var matNo = document.myForm.matNum.value; 
	
	if(matNo=="")
	{
		alert("Please enter Material Number.");
		document.myForm.matNum.focus();
		return;
	}
	
	var url="ezGetMaterialDetails.jsp?matCode="+matNo;
	newWindow=window.open(url,"ReportWin","width=550,height=150,left=100,top=300,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	
}
function materialSearch()
{
	var matDesc = document.myForm.matDescScrh.value; 
	
	if(matDesc=="")
	{
		alert("Please enter Material Description.");
		document.myForm.matDescScrh.focus();
		return;
	}
	
	var url="ezSearchMaterial.jsp?matDesc="+matDesc;
	newWindow=window.open(url,"ReportWin","width=700,height=500,left=100,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function vendorList()
{



	if(!checkRoleAuthorizations("VIEW_SOURCE"))
	{
		alert("You are not authorized to view Source List");
		return;
	}
	
	
	var matNo 	  = document.myForm.matNo.value; 
	var Plant	  = document.myForm.plant.value;	
	var deliveryDate  = document.myForm.deliveryDate.value;
	var qty	  	  = document.myForm.qty.value;
	var uom	  	  = document.myForm.uom.value;	
	var matDesc   	  = document.myForm.matDesc.value;
	
	var purreq = matNo+"$$"+Plant+"$$"+deliveryDate+"$$"+qty+"$$"+uom+"$$"+matDesc;
	document.myForm.purchReq.value = purreq;
	document.myForm.purchaseHidden.value	= matNo+"$$"+Plant+"$$"+deliveryDate+"$$"+qty+"$$"+uom+"$$"+matDesc;

	if(chk4empty())
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
		     buttonsSpan.style.display		= "none"
		     buttonsMsgSpan.style.display	= "block"
    	 	}
    	 	
		document.myForm.action="ezVendorViewList.jsp";
		document.myForm.submit();
	}	
}

function chk4empty()
{
	if(document.myForm.matNo.value=="")
	{
		alert("Please get the  Material No.")
		document.myForm.matNum.focus()
		return false;
	}
	if(document.myForm.matDesc.value=="")
	{
		alert("Please adopt Material Desc")
		document.myForm.matDesc.focus()
		return false;
	}
	
	if(document.myForm.qty.value=="")
	{
		alert("Please Enter Quantity")
		document.myForm.qty.focus()
		return false;
	}
	else if(isNaN(document.myForm.qty.value))
	     {
			alert("Please enter valid Quantity ")
			document.myForm.qty.focus();
			return;
	     }
	if(document.myForm.uom.value=="")
	{
		alert("Please Enter UOM")
		document.myForm.uom.focus()
		return false;
	}
	/*if(document.myForm.plant.selectedIndex==0)
	{
		alert("Please Select Plant")
		document.myForm.plant.focus()
		return false;
	}*/
	/*
	if(document.myForm.deliveryDate.value=="")
	{
		alert("Please Enter Delivery Date")
		document.myForm.deliveryDate.focus()
		return false;
	}
	
     deldate = eval("document.myForm.deliveryDate");
      	deldateobj = funTrim(deldate.value)
	
	
      	b= deldateobj.split(".");
      	c= today.split(".");
	
      	
      	d2=new Date(b[2],(b[0]-1),b[1])
      	d3=new Date(c[2],(c[0]-1),c[1])
      	
	if(d2<=d3)
	{
		alert("Delivery Date should be more than Today's Date")
	   	return false
	}
	*/
	if(document.myForm.deliveryDate.value=="")
	{
		alert("Please Select Delivery Date  From Calendar");
		document.myForm.deliveryDate.focus();
		return;
	}
	else
	{
		sDate = document.myForm.deliveryDate.value;
		selDate = sDate.split(".");
		var sd = new Date();
		var td = new Date();
		var a1 = parseInt(selDate[1],10)-1;

		sd = new Date(selDate[2],a1,selDate[0]);
		var dd=td.getDate();
		var mm=td.getMonth();
		var yy=td.getYear();

		td  = new Date(yy,mm,dd);

		if(sd<=td)
		{
			alert("Delivery Date should be greater than today's date");
			document.myForm.deliveryDate.focus();
			return;
		}
	}
	return true
}

function KeySubmit()
{
	if (event.keyCode==13)
		searchForMaterial()
}

function searchMatByNumber()
{
	var matNo	= 	document.myForm.matDescScrh.value; 

	if(matNo=="" || matNo=="Enter Search String Here.")
	{
		alert("Please enter Material Number");
		document.myForm.matDescScrh.focus();
		return;
	}	

	var url="ezMtrlSearch.jsp?matCode="+matNo;
	newWindow=window.open(url,"ReportWin","width=700,height=500,left=160,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

}

function searchMatByDesc()
{	
	var matDesc = document.myForm.matDescScrh.value; 
	

	if(matDesc=="" || matDesc=="Enter Search String Here.")
	{
		alert("Please enter Material Description.");
		document.myForm.matDescScrh.focus();
		return;
	}
	
	var url="ezSearchMaterial.jsp?matDesc="+matDesc;
	newWindow=window.open(url,"ReportWin","width=700,height=500,left=160,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function searchForMaterial()
{
	if(document.myForm.SearchMat[0].checked)
		searchMatByNumber();

	if(document.myForm.SearchMat[1].checked)
		searchMatByDesc();
		
	//if(document.myForm.SearchMat[2].checked)
		//getMaterialDesc();	
}


function setEmpty()
{
	if(document.myForm.matDescScrh.value=="Enter Search String Here.")
		document.myForm.matDescScrh.value="";
}

