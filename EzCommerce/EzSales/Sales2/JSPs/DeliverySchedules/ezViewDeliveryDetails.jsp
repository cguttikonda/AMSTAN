<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iAddDeliverySchedule.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iViewDeliveryDetails_Lables.jsp"%>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr; 
	}
%>
<%

			String urlFlag	= request.getParameter("urlFlag");
			String Status	= request.getParameter("status");
			String custInvNo= request.getParameter("custInvNo");
			String from 	= request.getParameter("from");
			String fromDate = request.getParameter("FromDate");  // don't delete
			String toDate 	= request.getParameter("ToDate"); 

%>
<html>  
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<Script>
		  var tabHeadWidth=95
 	   	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>

	<script>
	
		function showSpan(spid) 
		{

			obj=document.getElementById("SP"+spid);  
			if (obj!=null){
				if(obj.style.display=="none")
					obj.style.display="block";
				else if(obj.style.display=="block")
					obj.style.display="none";
				scrollInit();
			}

		}
		function ezPrint(obj1)
		{
	          	      document.forms[0].action=obj1
          		      document.forms[0].submit();
               	}
               	function funBack()
               	{
               		if('CUSTINV'=='<%=request.getParameter("urlFlag")%>')
               		{
               			document.ADSForm.action="../Sales/ezCustInvoiceDetails.jsp?salesDocNo=<%=soNum%>&custInvNo=<%=custInvNo%>&status=<%=Status%>"
               			document.ADSForm.submit();
               		}
               		else
               		{
               			history.go(-1);
               		}
               	}
		function ezBack()
		{
		<%
			if("ezGetDeliveryBySO".equals(from)) 
			{
		%>
			    // if(document.forms[0].onceSubmit.value!=1){
				//document.forms[0].onceSubmit.value=1
				document.body.style.cursor="wait"
				document.forms[0].action="ezGetDeliveryBySO.jsp?SalesOrder=<%=soNum%>&status=<%=Status%>"
				document.forms[0].submit();
                            // }
		<%
			}else if("ezCustInvoiceDetails".equals(from))
			{
		%>	     //if(document.forms[0].onceSubmit.value!=1){
				//document.forms[0].onceSubmit.value=1
				document.body.style.cursor="wait"
				document.forms[0].action="../Sales/ezCustInvoiceDetails.jsp?salesDocNo=<%=soNum%>&custInvNo=<%=custInvNo%>&status=<%=Status%>"
				document.forms[0].submit();
                            // }
		<%
			}else{
		%>
				history.back(-1);
		<%}%>
		}
	</script>
</head>
<body   onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form  method="post" name="ADSForm" onSubmit="return false" >
<input type="hidden" name="FromForm"	value="ClosedOrderList">
<input type="hidden" name="FromDate" 	value="<%=fromDate%>">
<input type="hidden" name="ToDate" 	value="<%=toDate%>">
<input type="hidden" name="base" 	value="SalesOrder">
<input type="hidden" name="status" 	value="<%=Status%>">
<input type="hidden" name="sendMail">
<%
	try{
		delNo = Long.parseLong(delNo)+"";
	}catch(Exception e)
	{
	
	}
	String display_header = dispDet_L+"&nbsp;:&nbsp;"+delNo;
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>



<%
	int delCount = delivTable.getRowCount();
	if ((soNum!=null)&&(! "".equals(soNum.trim()))){
%>
	<table width="25%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr>
			<th align="left"><%=saleNo_L%></th>
			<td ><%
				try{
					out.println(Long.parseLong(soNum));
				}catch(Exception e){ out.println(soNum); }
				%>
			</td>
		</Tr>
	</table>
<%
	}
	if(delCount==0)
	{
	%>
			<br><br><br><table  align=center border=0 >
			<tr>
	       		<Td class=displayalert align="center">No Delivery Details to view </Td>
			</tr></table>	
			<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
			<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Back");
				buttonMethod.add("ezBack()");
				out.println(getButtonStr(buttonName,buttonMethod));
			%>	
			</div>
	<%
	return;
	}
	%>
	<Div id="theads">
	<table  width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="11%"><%=lineNo_L%></th>
		<th width="19%">Product Code</th>
		<th width="36%">Product Description</th>
		<!--<th width="5%"><%=uom_L%></th>-->
		<th width="14%"><%=qty_L%></th>
	</tr></table>
	 </Table>
	 </Div>

	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
	<Table align=center id="InnerBox1Tab"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 width="100%">
	<%

	String line=null;
	String batch=null;
	String matNo=null;
	String matDesc=null;
	String UOM=null;
	String QTY=null;
	String Ext1=null;
	String Ext2=null;
	String Plant=null;
	int spanCount=0;
	ArrayList duplicate = new ArrayList();
	String tempMatNo = "";
	for (int i=0;i<delCount;i++)
	{

		line	= delivTable.getFieldValueString(i,"DelivItem");
		matNo	= delivTable.getFieldValueString(i,"Material");
		matDesc	= delivTable.getFieldValueString(i,"ShortText");
		UOM	= delivTable.getFieldValueString(i,"SalesUnit");
		QTY	= delivTable.getFieldValueString(i,"DlvqtySalesUnt");
		QTY	= eliminateDecimals(QTY);
		batch	= delivTable.getFieldValueString(i,"Batch");
		Ext1	= delivTable.getFieldValueString(i,"Ext1");
		Ext2	= delivTable.getFieldValueString(i,"Ext2");
		Plant	= delivTable.getFieldValueString(i,"Plant");
		
		
		try
		{
			tempMatNo = Integer.parseInt(matNo)+"";
		}
		catch(Exception e)
		{
			tempMatNo = matNo;
		}
					
		String vendbatch = delivTable.getFieldValueString(i,"VendorBatch");
		if ("Multiple Batchs".equals(Ext2))
		{
				if(!duplicate.contains(vendbatch))
						duplicate.add(vendbatch);
		%>
			<tr><td>
			<span>
			<Table width='100%'   align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<td width='11%'><input type=hidden name=Line_<%=i%> value="<%=line%>"><%=line%></td>
				<td width='19%'>
				<input type=hidden name=Material_<%=i%> value="<%=matNo%>">
				<input type=hidden name=Batch_<%=i%> value="<%=batch%>">
				<input type=hidden name=EXT_<%=i%> value="MultiBatch">
				<input type="hidden" name="Plant_<%=i%>" value="<%=Plant%>">
				<input type="hidden" name="RefLine_<%=i%>" value="<%=line%>">
				<a href='JavaScript:showSpan("<%=spanCount%>")'><%=batNo_L%></a>
				</td>
				<td width='36%'><input type=hidden name="Material_Desc_<%=i%>" value="<%=matDesc%>">&nbsp;<%=matDesc%></td>
				<!--<td width='5%' align='center'>&nbsp;<%=UOM %></td>-->
				<td width='14%'  align='right'><input type=hidden name="QTY_<%=i%>" value="<%= QTY %>">&nbsp;<%=QTY%></td>
				<input type=hidden name="UOM_<%=i%>" value="<%=UOM%>">
			</Tr>
			</Table>
			</span>

			</td></tr>
			<tr><td>

			<span id="SP<%=spanCount%>"  style="display:none">
			<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<%
				int k=i;
			for (int j=k+1;j<delivTable.getRowCount();j++)
			{
			
				
				String tempext2 = delivTable.getFieldValueString(j,"Ext2");

				if ("Multiple Batchs".equals(tempext2.trim()))
					continue;
				try{
					tempext2=String.valueOf(Integer.parseInt(delivTable.getFieldValueString(j,"Ext2")));
				}catch(Exception e)
				{
					tempext2="0";
				}
				
				
				try{
				if (Integer.parseInt(line)==Integer.parseInt(delivTable.getFieldValueString(j,"Ext2")))
				{	
				
					k++;
				%>
				<tr>
					<td width='11%'><input type=hidden name=Line_<%=i%> value="<%=delivTable.getFieldValueString(j,"DelivItem")%>"><%=delivTable.getFieldValueString(j,"DelivItem")%></td>
					<td width='19%'>
					<input type=hidden name=Material_<%=i%> value="<%=delivTable.getFieldValueString(j,"Material")%>">
					<input type=hidden name=Batch_<%=i%> value="<%=delivTable.getFieldValueString(j,"Batch")%>">
					<input type=hidden name=EXT_<%=i%> value="<%=delivTable.getFieldValueString(j,"Ext2")%>">
					<input type="hidden" name="Plant_<%=i%>" value="<%=delivTable.getFieldValueString(j,"Plant")%>">
					<input type="hidden" name="RefLine_<%=i%>" value="<%=line%>">
					<%=delivTable.getFieldValueString(j,"Batch")%>
					</td>
					<td width='36%'><input type=hidden name="Material_Desc_<%=i%>" value="<%=delivTable.getFieldValueString(j,"ShortText")%>">&nbsp;<%=delivTable.getFieldValueString(j,"ShortText")%></td>
					<!--<td width='5%' align='center'><%=delivTable.getFieldValueString(j,"SalesUnit")%></td>-->
					<td width='14%' align='right'><input type=hidden name="QTY_<%=i%>" value="<%=delivTable.getFieldValueString(j,"DlvqtySalesUnt")%>"><%=delivTable.getFieldValueString(j,"DlvqtySalesUnt")%></td>
					<input type=hidden name="UOM_<%=i%>" value="<%=delivTable.getFieldValueString(j,"SalesUnit")%>">
				</tr>
				<%
				}
				}catch(Exception e)
				{
					System.out.println("An Exception Occured :"+e);
					break;
				}
				/*if ("Multiple Batchs".equals(delivTable.getFieldValueString(j+1,"Ext2")))
				{
					break;
				}*/
			}%>
			</Table>
			</span>
			</td></tr>

		<%	spanCount++;
		}
		else
		{
				
			if(!duplicate.contains(vendbatch))
			//if(2==line.length())
			{
		%>
			<Tr><td>
			<span>
			<Table width='100%'   align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<td width='11%'><input type=hidden name=Line_<%=i%> value="<%=line%>"><%=line%></td>
				<td width='19%'>
				<input type=hidden name=Material_<%=i%> value="<%=matNo%>">
				<input type=hidden name=Batch_<%=i%> value="<%=batch%>">
				<input type=hidden name=EXT_<%=i%> value="<%=Ext2%>">
				<input type="hidden" name="Plant_<%=i%>" value="<%=Plant%>">
				<input type="hidden" name="RefLine_<%=i%>" value="<%=line%>">
				<%=tempMatNo%>
				</td>
				<td width='36%'><input type=hidden name="Material_Desc_<%=i%>" value="<%=matDesc%>">&nbsp;<%=matDesc%></td>
				<!--<td width='5%' align='center'>&nbsp;<%=UOM%></td>-->
				<td width='14%'  align='right'><input type=hidden name="QTY_<%=i%>" value="<%=QTY%>">&nbsp;<%=QTY%></td>
				<input type=hidden name="UOM_<%=i%>" value="<%=UOM%>">
			</Tr>
			</Table>
			</span>
			</Tr></Td>

		<%	}
		}
	}%>
	</table>
	</Div>
	<div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	if(Status!=null && !"null".equals(Status))
		Status = Status.trim();
	//if((Status.trim()).equalsIgnoreCase("C"))
	if("C".equalsIgnoreCase(Status))
	{	buttonName.add("Back");
		buttonMethod.add("funBack()");
	}	
	else
	{	
		buttonName.add("Back");
		buttonMethod.add("ezBack()");
	}	
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>	
	</div>
	<input type="hidden" name="totLines" value="<%=delivTable.getRowCount()%>">
	<input type="hidden" name="onceSubmit" value=0>	
</form>
<Div id="MenuSol"></Div>
</body>
</html>

