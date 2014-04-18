
function compareDates(date1,date2)
{
	date1TempArr=date1.split(".");
	date2TempArr=date2.split(".");


	tempDate1=date1TempArr[1]+"/"+date1TempArr[0]+"/"+date1TempArr[2];
	tempDate2=date2TempArr[1]+"/"+date2TempArr[0]+"/"+date2TempArr[2];

	compDate1 = new Date(tempDate1);
	compDate2 = new Date(tempDate2);

	if(compDate1 > compDate2)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function checkEmpty(chkVal)
{
	if(chkVal=="" || chkVal==null)
		return "NA"; 
	else
		return chkVal; 

}

function KeySubmit()
{
	if (event.keyCode==13)
		searchForMaterial()
}

function searchForMaterial()
{
	if(document.myForm.SearchMat[0].checked)
		searchMatByNumber();

	if(document.myForm.SearchMat[1].checked)
		searchMatByDesc();
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


function getPRs()
{
	var matCode = document.myForm.matNo.value;
	var fromDate = document.myForm.fromDate.value;
	var toDate = document.myForm.toDate.value;

	/*if(fromDate!="")
	{
		if(compareDates(today,fromDate))
		{
			alert("From Date should be greater than or equals to Today Date");
			return false;
		}
	}


	if(toDate!="")
	{
		if(compareDates(today,toDate))
		{
			alert("To Date should be greater than or equals to Today Date");
			return false;
		}
	}*/

	if(fromDate!="" && toDate!="")
	{
		if(compareDates(fromDate,toDate))
		{
			alert("To Date should be greater than or equals to From Date");
			return false;
		}
	}

	buttonsSpan	  = document.getElementById("EzButtonsSpan")
	buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
	     buttonsSpan.style.display		= "none"
	     buttonsMsgSpan.style.display	= "block"
	}


	document.myForm.action = "ezListPR.jsp";
	document.myForm.submit();
}

function setEmpty()
{
	if(myForm.matDescScrh.value=="Enter Search String Here.")
		myForm.matDescScrh.value="";
}
	