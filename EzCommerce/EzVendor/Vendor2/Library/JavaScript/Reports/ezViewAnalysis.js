

function openReportWindow()
{
	var chkLength = document.myForm.chk1.length
	var chkd = 0
	var radChkd = 0
	for(i=0;i<chkLength;i++)
	{
		if(document.myForm.chk1[i].checked)
		{
			chkd++;
			radChkd = i;
		}
	}
	if(chkd == 0)
	{
		alert("Please select the report");
		return;
	}
	else
	{
		var selValue = document.myForm.chk1[radChkd].value
		var winHeight = screen.height
		var winWidth = screen.width
		window.open("ezViewAnalysis.jsp?SELVALUE="+selValue,"Reports","fullscreen=yes")
	}	
}
function checkAuth()
{
	if(!checkRoleAuthorizations("VIEW_REPORT_DATA"))
	{
		alert("You are not authorized to view reports");
		location.href='../Misc/ezSBUWelcomeWait.jsp'
	}
	else
	{
		document.getElementById("repDiv").style.visibility="visible"
	}
}

function viewAnalysisReport()
{
	var purchaseGroup  = document.myForm.purchaseGroup
	var purchaseGroup1 = document.myForm.purchaseGroup1
	
	var materialFrom   = document.myForm.materialFrom
	var materialTo 	   = document.myForm.materialTo	
	
	var collectiveRfq  = document.myForm.collectiveRfq
	var collectiveRfq1 = document.myForm.collectiveRfq1
	
	if(chkDates())
	{
	
		if(purchaseGroup != null)
		{
			if(document.myForm.selrep.value == 'DOCDEL')
			{
				/*if(document.myForm.fromDate.value=="")
				{
					alert("Please select From Date from calendar.");
					document.myForm.fromDate.focus();
					return;
				}
				if(document.myForm.toDate.value=="")
				{
					alert("Please select To Date from calendar.");
					document.myForm.toDate.focus();
					return;
				}
				if(purchaseGroup.value == "")
				{
					alert("Please select Purchase Group.");
					purchaseGroup.focus();
					return
				}*/
				if(document.myForm.delegator.value == "")
				{
					alert("Please select Delegated From.");
					document.myForm.delegator.focus();
					return
				}
				if(document.myForm.delegatedto.value == "")
				{
					alert("Please select Delegated To.");
					document.myForm.delegatedto.focus();
					return
				}
			}
			else	
			if(purchaseGroup.value != "" || purchaseGroup1.value != "")
			{
				if(purchaseGroup.value != "" && purchaseGroup1.value == "")
				{
					purchaseGroup1.value = purchaseGroup.value
				}
				if(purchaseGroup.value == "" && purchaseGroup1.value != "")
				{
					purchaseGroup.value = purchaseGroup1.value
				}
			}
		}	
	
		if(materialFrom != null)
		{
			if(materialFrom.value != "" || materialTo.value != "")
			{
				if(materialFrom.value != "" && materialTo.value == "")
				{
					materialTo.value = materialFrom.value
				}
				if(materialFrom.value == "" && materialTo.value != "")
				{
					materialFrom.value = materialTo.value
				}
			}
		}
		
		if(collectiveRfq != null)
		{
			if(collectiveRfq.value != "" || collectiveRfq1.value != "")
			{
				if(collectiveRfq.value != "" && collectiveRfq1.value == "")
				{
					collectiveRfq1.value = collectiveRfq.value
				}
				if(collectiveRfq.value == "" && collectiveRfq1.value != "")
				{
					collectiveRfq.value = collectiveRfq1.value
				}
			}
		}
		
		if(document.myForm.selrep.value == 'DOCVAL')
		{
			var frVal = document.myForm.valuefrom
			var valType = document.myForm.valcriteria.options[document.myForm.valcriteria.selectedIndex]
			
			if(frVal==undefined || frVal==null || frVal.value=="")
			{
				alert("Please enter value");
				frVal.focus();
				return false;
			}
			
			if(isNaN(frVal.value))
			{
				alert("Please enter only numbers for value");
				frVal.value=""
				frVal.focus();
				return false;
			}
			
			if(valType!=undefined && valType!=null && valType.value=="between")
			{
				var toVal = document.myForm.valueto
				if(toVal==undefined || toVal==null || toVal.value=="")
				{
					alert("Please enter To value");					
					toVal.focus();
					return false;
				}
				if(isNaN(toVal.value))
				{
					alert("Please enter only numbers for To value");
					toVal.value="";
					toVal.focus();
					return false;
				}
				if(parseInt(toVal.value) < parseInt(frVal.value))
				{					
					alert("value should be less than To value");					
					frVal.focus();
					return false;
				}
			}
		
		
		}
		document.myForm.REQUEST_FROM.value="VIEW";
		document.myForm.SELVALUE.value=document.myForm.selrep.options[document.myForm.selrep.selectedIndex].value
		document.myForm.SHOWREPORT.value="Y"
		var innerString  = "<TABLE width='100%' align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>";
		innerString 	+= "<Tr align='center' valign='middle'><Th align=center style=\"background-color:'F3F3F3';color:'black'\">Retrieving Data..Please wait..</Th></Tr></Table>";
		document.getElementById("inProcessDiv").innerHTML=innerString;
		document.myForm.action="ezAnalysisReport.jsp";
		document.myForm.submit();
	}	
}

function chkDates()
{
	var fd = document.myForm.fromDate.value;
	var td = document.myForm.toDate.value;
	if(fd!="" || td!="")
	{	
		if(document.myForm.fromDate.value=="")
		{
			alert("Please select From Date from calendar.");
			document.myForm.fromDate.focus();
			return;
		}
		if(document.myForm.toDate.value=="")
		{
			alert("Please select To Date from calendar.");
			document.myForm.toDate.focus();
			return;
		}
	}	
		
	var toSelDate = document.myForm.toDate.value;
	var fromSelDate = document.myForm.fromDate.value;

	var toDate = toSelDate.split(".");
	var fromDate = fromSelDate.split(".");
	var tDate = new Date();
	var fDate = new Date();

	var a1 = parseInt(toDate[1],10)-1;
	var b1 = parseInt(fromDate[1],10)-1;

	tDate = new Date(toDate[2],a1,toDate[0]);
	fDate = new Date(fromDate[2],b1,fromDate[0]);

	if(fDate >= tDate)
	{
		alert("To Date should be greater than  From Date");
		document.myForm.toDate.focus();
		return;
	}		
	return true;
}

function disableFields(selectObj)
{
	if(document.myForm.materialFrom != null || document.myForm.materialTo != null)
	{
		var selectIndex  = selectObj.options.selectedIndex
		var selectOption = selectObj.options[selectIndex].value
		if(selectOption != "QCF_RELEASE")
		{
			document.myForm.materialFrom.disabled = true
			document.myForm.materialTo.disabled   = true
		}
		else
		{
			document.myForm.materialFrom.disabled = false
			document.myForm.materialTo.disabled   = false
		}
	}	
}

function dwldExcel(fileName)
{			
	document.myForm.action = fileName;
	document.myForm.submit();		
}

function scrollValue()
{
	var headerDiv   = document.getElementById("headerDiv");
	var dataDiv   	= document.getElementById("dataDiv");
	headerDiv.scrollLeft= dataDiv.scrollLeft
}

function SAPView(docnum,docType,vendorNo)
{
	if(docType == "QCF_RELEASE")
	{
		var url="../RFQ/ezQCFSAPPrint.jsp?qcfNumber="+docnum;

	}
	if(docType == "PO_RELEASE")
	{
		var url="../Purorder/ezBlockedPoLineitems.jsp?type=REPORT_DETAILS&vendorNo="+vendorNo+"&PurchaseOrder="+docnum;
	}	
	if(docType == "CON_RELEASE")
	{
		var url="../Rfq/ezGetAgrmtDetails.jsp?viewType=REPORT_DETAILS&agmtNo="+docnum;
	}	
	var sapWindow=window.open(url,"newwin","width=900,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}


	var winobj = null;
	var show="1";
	function loadDefaults(requestFrom)
	{
		if(requestFrom != "VIEW")
		{
			document.getElementById('outputDiv').style.visibility 	= 'hidden';
			document.getElementById('dividerDiv').style.visibility 	= 'hidden';
		}
		else
		{
			document.getElementById('outputDiv').style.visibility 	= 'visible';
			document.getElementById('dividerDiv').style.visibility 	= 'visible';
		}
	}
	function showTitle()
	{
		
		if(show == "1")
		{
			document.getElementById("imgshow").title="Collapse"
		}
		else
		{
			document.getElementById("imgshow").title="Expand"
		}
	}
	function simage()
	{
	
		if(show == "1")
		{
			document.getElementById("imgshow").src='../../Images/sopen.gif'
			

			document.getElementById('inputDiv').style.width 	= '0%';
			document.getElementById('outputDiv').style.width 	= '97%';
			
			document.getElementById('inputDiv').style.left 		= '0%';
			document.getElementById('dividerDiv').style.left 	= '1%';
			document.getElementById('outputDiv').style.left 	= '2%';

			document.getElementById('docheader').style.visibility  	= 'hidden';
			document.getElementById('btnsubmit').style.visibility  	= 'hidden';
			document.getElementById('listBoxDiv2').style.visibility = 'hidden';
			document.getElementById('inputDiv').style.visibility 	= 'hidden';
			show="0"
		}
		else
		{
			
			document.getElementById("imgshow").src='../../Images/sclose.gif'
			document.getElementById('inputDiv').style.width 	= '30%';
			document.getElementById('outputDiv').style.width 	= '67%';
			
			document.getElementById('inputDiv').style.left 		= '1%';
			document.getElementById('dividerDiv').style.left 	= '31%';
			document.getElementById('outputDiv').style.left 	= '32%';
			
			document.getElementById('docheader').style.visibility  	= 'visible';
			document.getElementById('btnsubmit').style.visibility  	= 'visible';
			document.getElementById('listBoxDiv2').style.visibility = 'visible';
			document.getElementById('inputDiv').style.visibility 	= 'visible';

			show="1"
		}
	}
	function showFilterOptions()
	{
		document.myForm.SELVALUE.value=document.myForm.selrep.options[document.myForm.selrep.selectedIndex].value	
		document.myForm.REQUEST_FROM.value="PAGE";
		document.myForm.action="ezAnalysisReport.jsp";
		document.myForm.submit();
	}
	
	function funValue()
	{
		var valType = document.myForm.valcriteria.options[document.myForm.valcriteria.selectedIndex].value
		if(valType!=null && valType=="between")
		{
			document.getElementById('valueDiv').style.visibility  	= 'visible';	
		
		}
		else
			document.getElementById('valueDiv').style.visibility  	= 'hidden';	
	}
	function openReportWindow()
	{
		var chkLength = document.myForm.chk1.length
		var chkd = 0
		var radChkd = 0
		for(i=0;i<chkLength;i++)
		{
			if(document.myForm.chk1[i].checked)
			{
				chkd++;
				radChkd = i;
			}
		}
		if(chkd == 0)
		{
			alert("Please select the report");
			return;
		}
		else
		{
			var selValue = document.myForm.chk1[radChkd].value
			var winHeight = screen.height
			var winWidth = screen.width
			winobj = window.open("ezViewAnalysis.jsp?SELVALUE="+selValue,"Reports","fullscreen=yes")
		}	
	}
	function checkAuth()
	{
		if(!checkRoleAuthorizations("VIEW_REPORT_DATA"))
		{
			alert("You are not authorized to view reports");
			location.href='../Misc/ezSBUWelcomeWait.jsp'
		}
		else
		{
			document.getElementById("inputDiv").style.visibility="visible"
			document.getElementById("outputDiv").style.visibility="visible"
			document.getElementById("dividerDiv").style.visibility="visible"
		}
	}
	function closeReportWindow()
	{
		if(winobj != null)
			winobj.close()
	}
	
	function SAPView(num)
	{
		//var url="ezQcfSAPView.jsp?qcfNumber="+num;
		var url="../Rfq/ezQCFSAPPrint.jsp?qcfNumber="+num;
		var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
function showVendors(collRfq,proc)
{
	var url="../Rfq/ezShowVendors.jsp?collRfq="+collRfq+"&process="+proc;
	newWindow=window.open(url,"VendWin","width=550,height=350,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}