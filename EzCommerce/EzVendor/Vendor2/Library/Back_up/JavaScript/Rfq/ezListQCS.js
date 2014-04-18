function hideButton()
{
	buttonsSpan	  = document.getElementById("EzButtonsSpan")
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
	     buttonsSpan.style.display		= "none"
	     buttonsMsgSpan.style.display	= "block"
	}
}	

function showWin(qcf,quan)
{
	var url="ezQcfComments.jsp?qcfNumber="+qcf+"&quantity="+quan;
	newWindow=window.open(url,"myWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function showVendors(collRfq,proc)
{
	var url="ezShowVendors.jsp?collRfq="+collRfq+"&process="+proc;
	newWindow=window.open(url,"VendWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function showGraph(collRfq)
{
	var url="ezReportChart.jsp?collRFQ="+collRfq;
	newWindow=window.open(url,"ReportWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

}

function funUnload()
{
	if(newWindow!=null && newWindow.open)
	{
	  newWindow.close();
	}
}
function CloseQCF()
{
	var chkObj 	= document.myForm.collectiveRFQNo;
	var chkLen	= chkObj.length;
	var chkValue	= "";
	var count	= 0;

	if(!isNaN(chkLen))
	{
		for(i=0;i<chkLen;i++)
		{
			if(chkObj[i].checked)
			{
				count++;				
			}
		}
	}
	else
	{
		if(chkObj.checked)
		{
			count = 1;
		}
	}

	if(count == 0)
	{
		alert("Please select atleast one QCF to Close");
		return;
	}

	if(confirm("Are you sure to close QCF(s)?"))
	{
		url = "ezRemarks.jsp";
		values="";
		dialogvalue=window.showModalDialog(url,values,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;resizable=no")
		if ((dialogvalue=='Canceld~~')||(dialogvalue==null))
		{
			return;
		}
		else
		{
			document.myForm.reasons.value = dialogvalue;
			document.myForm.action="ezCloseQCF.jsp";
			document.myForm.submit();
		}
	}	
}

