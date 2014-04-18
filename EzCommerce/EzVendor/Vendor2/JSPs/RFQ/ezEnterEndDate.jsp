<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iListCollectiveRFQByMat.jsp"%>
<%
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
%>

<html>
<head>
<title>Enter Quotation End Date -- Powered By EzCommerce India</title>
<head>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%
	String reqDate = request.getParameter("reqDate");
	String matDescTemp = request.getParameter("matDesc");
%>
<script>
function funOnload()
{
   document.myForm.qtnEndDate.value = window.dialogArguments	
}

function closeWin()
{
	var reqDate 	= document.myForm.matDelDate.value;//'<%=reqDate%>';
	var endDate 	= document.myForm.qtnEndDate.value;
	
	a=reqDate.split(".");
	b=endDate.split("."); 	
	var reDate = new Date(a[2],(a[1]-1),a[0])
	var enDate = new Date(b[2],(b[1]-1),b[0])
	
	var toDate  = new Date();
	
	if(document.myForm.comment.selectedIndex==0)
	{
		alert("Please Select Comments")
		document.myForm.comment.focus()
		return;
	}
	if(document.myForm.qtnEndDate.value=="")
	{
		alert("Please Enter Quotation End Date")
		document.myForm.qtnEndDate.focus()
		return;
	}
	else if(enDate<toDate)
	{
		alert("Quotation End date must greater than Today's date");
		return;
	}
	else if(reDate < toDate)	
	{
		alert("Delivery date must greater than Today's date");
		return;
	}
	else if(reDate <= enDate)	
	{
		alert("Quotation End date must be less than the Del.Date");
		return;
	}
	var comments = document.myForm.comment.value
	var collNo   = document.myForm.collNo.value
	var delivDate   = document.myForm.matDelDate.value
	var matDesc	= document.myForm.matDesc.value
	window.returnValue = document.myForm.qtnEndDate.value+'##'+comments+'##'+collNo+'##'+delivDate+'##'+matDesc;
	window.close();

}
function  funDateShow()
{
	if(document.myForm.colRfqDt != null)
	{
		if(!(isNaN(document.myForm.colRfqDt.length)))
		{
			var selVal = document.myForm.collNo[document.myForm.collNo.selectedIndex].value;
			if(selVal!="")
			{	
				document.getElementById("imgId").style.visibility = "hidden";
				document.myForm.qtnEndDate.value = document.myForm.colRfqDt[parseInt(document.myForm.collNo.selectedIndex)-1].value;
			}
			else
			{
				document.getElementById("imgId").style.visibility = "visible";
				document.myForm.qtnEndDate.value = "";
			}
		}
		else
		{
			if(selVal!="")
			{	
				document.getElementById("imgId").style.visibility = "hidden";
				document.myForm.qtnEndDate.value = document.myForm.colRfqDt.value;
			}
			else
			{
				document.getElementById("imgId").style.visibility = "visible";
				document.myForm.qtnEndDate.value = "";
			}
		}
	}	
}
function winClose()
{
	window.returnValue = "Cancel";
	window.close();

}
</script>
</head>
<body onLoad="funOnload()">
<form name="myForm" >
<%
int retObjCnt = 0;
	if(myRet!=null)
		retObjCnt = myRet.getRowCount(); 
		
%>
 <br><br><br>
    <table width="90%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
    	
    	<tr>
		<Th width="40%" align="left">Collective RFQ No</Th>
		<Td width="60%">
			<select name="collNo" style="width:100%" id="CalendarDiv" onClick="funDateShow()">
				<option value="">Generate Collective RFQ</option>
<%
				for(int i=0;i<retObjCnt;i++)
				{
%>					<Option value='<%=myRet.getFieldValueString(i,"COLLECTIVE_RFQ_NO")%>'><%=myRet.getFieldValueString(i,"COLLECTIVE_RFQ_NO")%></Option>
					
<%				}
%>
			</select>
<%			
			for(int i=0;i<retObjCnt;i++)
			{
				String valDate = "";
				java.util.Date valDateObj = (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
				if(valDate!=null)
				     valDate = fd.getStringFromDate(valDateObj,".",ezc.ezutil.FormatDate.DDMMYYYY);
				     
%>			
				<input type="hidden" name="colRfqDt" value='<%=valDate%>'>
<%
			}
%>			
		</Td>
    	</tr>
    	<tr> 
    		<Th width="40%" align="left">Material Desc</Th>
		<Td width="60%"><input type="text" name="matDesc"  class="InputBox" size=30  value="<%=matDescTemp%>"></Td>
	</tr>
    	
    	<tr>
		<Th width="40%" align="left">Quotation End Date* </Th>
		<Td width="60%"><input type="text" name="qtnEndDate"  class="InputBox" size=12  readonly><img id="imgId" src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.qtnEndDate",50,150,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
	</tr>
	<tr>
		<Th width="40%" align="left">Delivery Date </Th>
		<Td width="60%"><input type="text" name="matDelDate"  value='<%=reqDate%>' class="InputBox" size=12  readonly><img id="imgId" src="../../Images/calender.gif" style="cursor:hand" height="20" onClick=showCal("document.myForm.matDelDate",50,150,"<%=cDate%>","<%=cMonth%>","<%=cYear%>") ></Td>
		</Td>
	</tr>
	<tr>
		<Th width="40%" align="left">Comments* </Th>
		<Td width="60%">
			<select name="comment" style="width:100%" id="CalendarDiv">
				<option value="">-Select Quote Comments-</option>
				<option value="AB1">AB1 ---> Rejection for price reasons</option>
				<option value="AB2">AB2 ---> Rejection for quality reasons</option>
				<option value="OK1" selected>OK1 ---> OK for price reasons</option>
				<option value="OK2">OK2 ---> OK on quality grounds</option>
			</select>
		</Td>
	</tr>	
    </table>
<br><br><br>    
 <center>
 <Div id="buttonDiv" align="center" style="position:absolute;left:0%;width:100%;top:90%">
<%
         buttonName = new java.util.ArrayList();
         buttonMethod = new java.util.ArrayList();
         
         buttonName.add("&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;");   
          buttonName.add("&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;");   
    
          buttonMethod.add("closeWin()");
          buttonMethod.add("winClose()");
          out.println(getButtonStr(buttonName,buttonMethod));

%>
</Div>
 </center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
