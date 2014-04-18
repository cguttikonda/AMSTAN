<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@page import="java.util.*"%>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/ilistPRT.jsp" %>
<%
String divHgt = "70";
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<Script src="../../Library/JavaScript/ezTrim.js"></Script>
	<Script>
		var tabHeadWidth = 90;
		var tabHeight="65%";
		if(screen.width==800) 
		{
			tabHeight="57%";
		}
		 
		function funBack()
		{
			 
			document.myForm.action="ezPrePRList.jsp";	
			document.myForm.submit();
		}
		function vendorList()
		{
			
			//alert("Get Sources")
			var chkObj 	= document.myForm.purchReq;
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
						chkValue = chkValue+chkObj[i].value+"##";		
					}
				}
			}
			else
			{
				if(chkObj.checked)
				{
					count = 1;
					chkValue = chkValue+chkObj.value+"##";
				}
			}
			if(count == 0)
			{
				alert("Please select atleast one Purchase Requisition");
				return;
			}
		
			var mainToken	= chkValue.split("##");
			
			var tokensLen	= mainToken.length-1;
		
			var material;
			var plant;
			var delDate;
			var qty	= 0;
			var uom;
			var matDesc;
			var prno;
			var itmno;
			var valtype;
			if(!isNaN(tokensLen))
			{
			
				var childToken	= mainToken[0].split("$$");
				material	= childToken[0];
				plant		= childToken[1];
				qty		= childToken[3];
				delDate		= childToken[2];
				uom		= childToken[4];
				matDesc		= childToken[5];
				prno		= childToken[6];
				itmno		= childToken[7];
				valtype		= childToken[8];
				a=delDate.split(".");
				var mm = parseInt(a[1],10)-1;
				var dlvrDate  = new Date(a[2],mm,a[0]);
				
				
			
				for(j=1;j<tokensLen;j++)
				{
					var childToken	= mainToken[j].split("$$");
		
					var material1	= childToken[0];
					var plant1	= childToken[1];
					var qty1	= childToken[3];
					var delDate1	= childToken[2];
					
					b=delDate1.split(".");
					var mm1 = parseInt(b[1],10)-1;
					var cmprDate  = new Date(b[2],mm1,b[0]);
		
					/*if(delDate<delDate1)
					{
						delDate = delDate1; 
					}*/
					
					if(dlvrDate<cmprDate)
					{
						delDate = delDate1; 
					}
					//alert(delDate);
		
					if(funTrim(material) == funTrim(material1))
					{
						if(funTrim(plant) == funTrim(plant1))
						{
							qty = parseInt(qty)+parseInt(qty1);	
						}
						else
						{
							alert("Please select material with same Plant to get Vendors");
							return;
						}
					}
					else
					{
						alert("Please select same Material to get Vendors");
						return;
					}
				}	
			}
			
			buttonsSpan	  = document.getElementById("EzButtonsSpan")
			buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
			if(buttonsSpan!=null)
			{
			     buttonsSpan.style.display		= "none"
			     buttonsMsgSpan.style.display	= "block"
		     	}
			document.myForm.purchReq.value		= material+"$$"+plant+"$$"+delDate+"$$"+qty+"$$"+uom+"$$"+matDesc+"$$"+prno;
			document.myForm.purchaseHidden.value	= material+"$$"+plant+"$$"+delDate+"$$"+qty+"$$"+uom+"$$"+matDesc+"$$"+prno+"$$"+itmno+"$$"+valtype;
			
			//alert("document.myForm.purchReq.value"+document.myForm.purchReq.value)
			//alert("document.myForm.purchaseHidden.value"+document.myForm.purchaseHidden.value)
			
			document.myForm.action			= "ezVendorViewList.jsp";
			document.myForm.submit();
}
	</Script>
	
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="post">
<input type=hidden name="purchaseHidden">
<input type ="hidden" name="reasons" value =""> 
<%
	
	String display_header = "List Of Purchase Requisitions"; 
	if(Status.equals("R"))
		display_header = "List Of Released Purchase Requisitions";
	else if(Status.equals("U"))
		display_header = "List Of Unreleased Purchase Requisitions";
%> 
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%  
	if(myRetCount==0)
	{
%>
	<br><br><br><br><br>
	<Table width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th>No Purchase Requisitions exist to List</th>
		</Tr>
	</Table>
	
	<Div id="back" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
	    
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("&nbsp;&nbsp;Back&nbsp;&nbsp;");
	buttonMethod.add("funBack()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>

</Div>
<%
	}
	else
	{
%>
<br>
<Div id="theads">
<Table id="tabHead" width="90%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
      <tr>

        <th align="center" width="9%">PR No</th>
        <th align="center" width="12%">Created Date</th>
       
      </tr>
</Table>  
</Div>

<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;left:2%">
<Table  id="InnerBox1Tab" width="100%" align=center  border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
	boolean showStr = false;
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	String  reqno="",item="",material="",myMatDesc="";
	for(int i=0;i<myRetCount;i++)
	{
		try
		{
			reqno=""+Long.parseLong(myRet.getFieldValueString(i,"REQNO"));
		}
		catch(Exception e)
		{
			reqno=myRet.getFieldValueString(i,"REQNO");
		}
		try
		{
			item=""+Long.parseLong(myRet.getFieldValueString(i,"ITEM"));
		}
		catch(Exception e)
		{	
			item=myRet.getFieldValueString(i,"ITEM");
		}
		try
		{
			material=""+Long.parseLong(myRet.getFieldValueString(i,"MATERIAL"));
		}
		catch(Exception e)
		{
			material=myRet.getFieldValueString(i,"MATERIAL");
		}
		
		
%>
		<Tr>
<%
			String styleTemp="",prColor="";
		  	if(Status.equals("R"))
			{
				String searchKey=myRet.getFieldValueString(i,"REQNO")+"¥"+myRet.getFieldValueString(i,"ITEM");
				
				if(prTreeSet.contains(searchKey))
				{
					showStr = true;
				}
			
			
				myMatDesc = myRet.getFieldValueString(i,"DESCRIPTION");
				//out.println("myRet====="+myRet.toEzcString());
				
				myMatDesc=myMatDesc.replace('\'','`');
%>
				
<%
			}
%>

	
   				
			<td align="center" width="9%" ><a href="listPR1.jsp?PRnum=<%=reqno%>"><%=reqno%></a></td>
			
			<td align="center" width="12%"><%=fd.getStringFromDate((Date)myRet.getFieldValue(i,"REQDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%></td>
			
		</Tr>
<%
	}
%>
</Table>
</Div>
<Div id="back" align=center style="position:absolute;top:91%;visibility:visible;width:100%">

		<span id="EzButtonsSpan" >
			


		</span>
		<span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
		</span>
		
</Div>
<% 
}
%>
	
<input type=hidden name="backChk" value="PRS">	


<input type="hidden" name="Status" value="<%=Status%>">
<input type="hidden" name="matNo" value="<%=matNo%>">
<input type="hidden" name="selplant" value="<%=plant%>">
<input type="hidden" name="fromDate" value="<%=fromDate%>">
<input type="hidden" name="toDate" value="<%=toDate%>">

</Form>
<Div id="MenuSol"></Div>
</body>
</html>
