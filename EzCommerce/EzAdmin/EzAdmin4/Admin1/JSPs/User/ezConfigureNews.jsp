<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/JSPs/WebStats/iCalendar.jsp"%> 
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%
	
%>
<html>
<head>

<Script type="text/javascript">
function getAttachWindow()
{
	var attachedFiles="";
	var val=document.myForm.attachs.value
	if(val != "")
	{
		var arr=val.split('\n')
		for(var i=0;i<arr.length;i++)
		{
			if(arr[i] != "")
			{
				if(attachedFiles == "")
					attachedFiles = arr[i]
				else
					attachedFiles += "&attachedFiles="+arr[i];
			}
		}

	}

	var url = "ezNewsAttachment.jsp?attachedFiles="+attachedFiles;
	var hWnd = 	window.open(url,"UserWindow","width=600,height=325,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}
function funOpenFile()
{
	var dbClickOnFlNm = document.myForm.attachs.value
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../../../../../EzSales/Sales2/JSPs/UploadFiles/ezViewFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm,"newwin","width=800,height=550,left=100,top=30,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");
	}	
}
function doRemove()
{
	var count=0;
	//alert("attachs::::::::::::::::"+document.myForm.attachs.length)
	if(document.myForm.attachs.length==0)
	{
		alert("Currently no attachments in your list");
	}
	else
	{
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			if(document.myForm.attachs.options[i].selected)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please select the files to remove");
		}
		else
		{
			var attachedFiles="";
			var toBeDelFiles="";
			if(document.myForm.attachs.length > 0)
			{
				attachedFiles=document.myForm.attachs.options[0].value
				if(document.myForm.attachs.options[0].selected)
					toBeDelFiles=document.myForm.attachs.options[0].value
			}
			for(var i=1;i<document.myForm.attachs.length;i++)
			{
				attachedFiles += "&allAttachedList="+document.myForm.attachs.options[i].value
				if(document.myForm.attachs.options[i].selected)
				{
					if(toBeDelFiles == "")
						toBeDelFiles = document.myForm.attachs.options[i].value
					else
						toBeDelFiles += "&toBeDelFiles="+document.myForm.attachs.options[i].value
				}
			}

			document.myForm.action="../Inbox/ezDeleteAttachments.jsp?allAttachedList="+attachedFiles+"&toBeDelFiles="+toBeDelFiles+"&flag=N";
			document.myForm.submit();
		}
	}
}
function getDefaultsFromTo()
{
<%
		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
		
		tomorrow.setDate(today.getDate()+15);
		ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();

%> 
		document.myForm.fromDate.value = "<%=format.getStringFromDate(today,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		document.myForm.toDate.value = "<%=format.getStringFromDate(tomorrow,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		
}

function saveSubmit()
{
	
	var descObj 		= eval("document.myForm.Desc")
	var fromDateObj 	= eval("document.myForm.fromDate")
	var toDateObj 		= eval("document.myForm.toDate")
	var categoryObj		= eval("document.myForm.category")
	var WebSysKeyObj	= eval("document.myForm.WebSysKey")
	var newsTextObj		= eval("document.myForm.newsText")	
	var viewAuthCnt		= document.myForm.viewAuth.length
	var typeCnt		= document.myForm.newsType.length
	var authView
	count=0
	count1=0
	
	
	if(descObj.value=='')
	{
		alert("Enter description")
		descObj.focus();
		return;
		
	}
	if(newsTextObj.value=='')
	{
		alert("Enter Text")
		newsTextObj.focus();
		return;
		
	}	
	for(i=0;i<typeCnt;i++)
	{
		if(document.myForm.newsType[i].checked)
		{
			type=document.myForm.newsType[i].value
			count++
		}
		
	}
	if(count==0)
	{
		alert("Please select news type")
		return;
	}	

	if(fromDateObj.value=='')
	{
		alert("Please select valid from")
		fromDateObj.focus();
		return;

	}
	if(toDateObj.value=='')
	{
		alert("Please select valid to")
		toDateObj.focus();
		return;

	}
	if(categoryObj.value=='')
	{
		alert("Please select news category")
		categoryObj.focus();
		return;

	}
	if(WebSysKeyObj.value=='')
	{
		alert("Please select sales area")
		WebSysKeyObj.focus();
		return;

	}
	for(i=0;i<viewAuthCnt;i++)
	{
		if(document.myForm.viewAuth[i].checked)
		{
			authView=document.myForm.viewAuth[i].value
			count1++
		}
		
	}
	if(count1==0)
	{
		alert("Please select view type")
		return;
	}
		
	if(document.myForm.attachs.length>0)
	{
		document.myForm.attachflag.value="true";
		var astring="";
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			astring=astring+document.myForm.attachs.options[i].value+",";
		}
		astring	= astring.substring(0,astring.length-1);
		document.myForm.attachString.value=astring;
	}


	
	
	/*alert("desc:::::::::::::::::::::"+descObj.value)
	alert("fromDate:::::::::::::"+fromDateObj.value)
	alert("toDate:::::::::::::"+toDateObj.value)
	alert("WebSysKey:::::::::::::"+WebSysKeyObj.value)
	alert("category:::::::::::::"+categoryObj.value)
	alert("viewAuth:::::::::::::"+authView)
	alert("selectedSol::::::::::"+document.myForm.selectedSol.value)
	alert("selectedShip::::::::::"+document.myForm.selectedShip.value)
	alert("attachString::::::::::"+astring)*/
	
	
	document.myForm.action="ezAddSaveNews.jsp";
	document.myForm.submit();

}
function funHide(viewAuth)
{
	if(viewAuth=="I")
	{
		document.getElementById("selPart").removeAttribute("href")
		document.getElementById("selPart1").removeAttribute("href")
		document.getElementById("selPart").style.color="grey"
		document.getElementById("selPart1").style.color="grey"
			
	}
	else if(viewAuth=="E")
	{
		document.getElementById("selPart").href="javascript:funSelSoldto('STP')"
		document.getElementById("selPart1").href="javascript:funSelSoldto('SHP')"
		document.getElementById("selPart").style.color="blue"
		document.getElementById("selPart1").style.color="blue"
	}	
	else if(viewAuth=="A")
	{
		document.getElementById("selPart").removeAttribute("href")
		document.getElementById("selPart1").removeAttribute("href")
		document.getElementById("selPart").style.color="grey"
		document.getElementById("selPart1").style.color="grey"
	}

}
function funSelSoldto(sel)
{
	var selSys
	var url
	var selSolds= document.myForm.selectedSol.value
	//alert(selSolds)
	if(sel=='STP')
	{
		selSys	=	document.myForm.WebSysKey.value
		url	=	"ezGetSoldTos.jsp?WebSysKey="+selSys+"&Area=C&myUserType=3&selSolds="+selSolds 
	}
	else
	{
		selSys	=	document.myForm.WebSysKey.value
		url	=	"ezGetShipTos.jsp?WebSysKey="+selSys+"&Area=C"	
	
	}
	var hWnd	=	window.open(url,"UserWindow","width=500%,height=350,left=100,top=100,resizable=yes,scrollbars=no,statusbar=yes toolbar=no,menubar=no");
	if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;
}


</Script>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>

<Title>Add News Data</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body OnLoad='getDefaultsFromTo()'>

<form name=myForm method=post >
<input type="hidden" name="selectedSol"> 
<input type="hidden" name="selectedShip"> 
<input type="hidden" name="attachString">
<input type="hidden" name="attachflag">

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Add News</Td>
  	</Tr>
	</Table>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
      	<Th colspan="2">
        <div align="center"> Please Enter News Information</div>
      	</Th>
    	</Tr>
    	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Description <font color='red'><span>*</span></font></div>
		</Td>
		<Td width="63%">
			<input type=text class = "InputBox" name=Desc maxlength="100" style="width:37%">
			
		</Td>
    	</Tr> 
	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">News Text <font color='red'><span>*</span></font></div>
		</Td>
		<Td width="63%">
			<textarea class=txarea name=newsText rows=2  style="overflow:auto;border:0;width:100%" wrap="off" ></textarea>
			
		</Td>
    	</Tr>     	
	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">News Type <font color='red'><span>*</span></font></div>
		</Td>
		<Td width="63%" >
				<input type="radio" name="newsType" value="I" >Information
				<input type="radio" name="newsType" value="T">Tracking
				<input type="radio" name="newsType" value="TA">Track & Acknowledge
		</Td>
    	</Tr>     	
	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">ValidFrom <font color='red'><span>*</span></font></div>
		
		</Td>
		<Td width="37%">
		<input type=text class = "InputBox" name="fromDate" size=11 value="" readonly>
        		 &nbsp;<%=getDateImage("fromDate")%>
		</Td>
    	</Tr>
    	<Tr>
	      	<Td width="37%" class="labelcell">
	        <div align="right">ValidTo <font color='red'><span>*</span></font></div>
	      	</Td>
	      	<Td width="63%">
	      		<input type=text class = "InputBox" name="toDate" size=11 value="" readonly>
        		&nbsp;<%=getDateImage("toDate")%>
	      	</Td>
    	</Tr>
    	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Category <font color='red'><span>*</span></font></div>
		</Td>
		<Td width="63%">	

			<select name="category" id=ListBoxDiv>
			<option value='PL' selected>Price list downloads</option>
			<option value='PS'>Periodic Statement</option>
			<option value='PRODSPEC'>Product Specification</option>
			<option value='NP'>New products/Product line</option>
			<option value='DP'>Discontinued Products</option>
			<option value='PCA'>Price change Announcements</option>
			<option value='PA'>Promotion Announcements</option>
			<option value='SLOB'>SLOB/Specials</option>
			<option value='OM'>Others/Miscellaneous</option>


			</select>	
		</Td>
    	</Tr>
  </Table>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
      	<Th colspan="2">
        <div align="center"> Authorizations</div>
      	</Th>
    	</Tr>  
	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Sales Area <font color='red'><span>*</span></font></div>
		</Td>
		<Td width="67%">	

		<select name="WebSysKey" style = "width:35%"   onSelect='funGetSoldTo()'>
		
<%
		StringBuffer all=new StringBuffer("");
		ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		for(int i=0;i<ret.getRowCount();i++)
		{
			if(i==0)
			{
				all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
			}
			else
			{
				all.append(",");
				all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
			}
%>			
			<option value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>"><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
		}
%>


			</select>	
		</Td>
		
    	</Tr>
  	
    	
    	<Tr>
		
		<Td width="37%" class="labelcell">
		<div align="right">Visible<font color='red'><span>*</span></font></div>
		</Td>
		<Td width="63%">
			<input type="radio" name="viewAuth" value='I' onClick="funHide('I')">Internal
			<input type="radio" name="viewAuth" value='E' onClick="funHide('E')">External
			<input type="radio" name="viewAuth" value='A' onClick="funHide('A')">All
		</Td>
		
    	</Tr>
	<Tr>
		
		<Td width="37%" class="labelcell">
		<div align="right">&nbsp; </div>
		</Td>
		<Td width="63%" >
			<a href="javascript:funSelSoldto('STP')" id ="selPart">SoldTo</a>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
			<a href="javascript:funSelSoldto('SHP')" id ="selPart1">ShipTo</a>
		</Td>
		
    	</Tr>      	
	   	
</Table>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="80%">
	 <Tr>
	<Th align="left" width=60%>
	<Table width=100%>
	<Tr>
		<Th align=left>
			<a href="javascript:getAttachWindow()" title="Click Here To Attach A File"><Font color="white"><B>Attach</B></Font></a>
		</Th>
		<Th align=right>
			<a href="JavaScript:doRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B></Font></a>
		</Th>
	</Tr></Table>
		
	<Tr>
		<Td>
			<!--<textarea class=txarea name=attachs rows=3 readonly style="overflow:auto;border:0;width:100%" wrap="off" ondblclick="funOpenFile()"></textarea>-->
		<select name=attachs style="width:100%" size=5 ondblclick="funOpenFile()">
		</select>
		</Td>
	</Tr>
	
</Table>
<!--<Table align="center" width="80%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
	<Th align="left" width=60%>
		<Table width=100%>
		<Tr>
		<Th align=left>
			<a href="JavaScript:getAttachWindow()" title="Click Here To Attach A File"><Font color="white"><B>Attach</B></Font></a>
		</Th>
		<Th align=right>
			<a href="JavaScript:doRemove()" title="Click Here To Remove Attached File"><Font color="white"><B>Remove</B></Font></a>
		</Th></Tr></Table>
	</Th>
	</Tr>
	<Tr>
	<Td align="center" width=60% class='blankcell' >
		<select name="attachs" style="width:100%" size=5 ondblclick="funOpenFile()">
		
		</select>
	</Td>
	</Tr>
	</Table>-->
<br>

<br>
<div align="center">
    	<!--<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif">--> 
    	<a href="javascript:saveSubmit()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none  ></a>
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>

</form>
</body>
</html>
