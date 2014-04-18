/****************************************************************************************
        * Copyright Notice ===================================================
	* This file contains proprietary information of Answerthink Ind Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 =====================================*
		Author: Girish Pavan Cherukuri
		Team:   EzcSuite
		Date:   16/09/2005
*****************************************************************************************/

function funSubmit()
{
	if(document.myForm.FromDate.value=="")
	{
		alert("Please Enter From Date")
		return false;
	}		
	else if(document.myForm.ToDate.value=="")
	{
		alert("Please Enter To Date")
		return false;
	}
	else
	{
		document.myForm.chkdindex.value=document.myForm.WebSysKey.selectedIndex;
		document.myForm.action="ezListWebStatsBySBU.jsp";
		document.myForm.submit();
	}
}
