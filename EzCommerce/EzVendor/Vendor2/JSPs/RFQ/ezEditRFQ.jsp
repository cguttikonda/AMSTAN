<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>

<%@include file="../../../Includes/Jsps/Rfq/iViewRFQDetails.jsp"%>
<%@page import="ezc.ezutil.*"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	<%@ include file="../../../Includes/Jsps/Misc/iShowCal.jsp"%>
	<script src="../../Library/JavaScript/Rfq/ezViewRFQDetails.js"></Script>
	<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
	
<Script>
	var tabHeadWidth=96
	var tabHeight="65%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>

	function checkQty(qtyObj)
	{
		var fldValue = qtyObj.value;
		if(fldValue == "")
		{
			alert("Please enter quantity");
			qtyObj.focus();
			return;
		}
		else
		{
			if(isNaN(fldValue))
			{
				alert("Please enter valid quantity");
				qtyObj.focus();
				return;
			}
			else if(parseFloat(fldValue)<=0)
			{
				alert("Quantity should be greater than zero");
				qtyObj.focus();
				return;
			}

		}

	}
	
	function saveChanges()
	{
		
		
		var reqDate 	= "";
		var endDate 	= document.myForm.qtnEndDate.value;
		var toDate  = new Date();
		
		if(endDate==""){
			alert("Please enter quotation end date");
			return;
		}else{
			b=endDate.split("."); 
			var enDate = new Date(b[2],(b[1]-1),b[0]);
			if(enDate<toDate){
				alert("Quotation End date should be greater than Today's date");
				return;
			}
			
		}
		
		var lineNoObj=document.myForm.lineNo;
		var lineNoObjLen="";
		if(lineNoObj!=null){
			lineNoObjLen=lineNoObj.length;
			if(isNaN(lineNoObjLen)){
				reqDate=document.myForm.deliveryDate0.value;
				if(reqDate==""){
					alert("Please enter delivery date");
					return;
				}else{
					b=reqDate.split("."); 
					var delDate = new Date(b[2],(b[1]-1),b[0]);
					if(delDate<toDate){
						alert("Delivery date should be greater than Today's date");
						return;
					}
							
				}
			}else{
				for(var i=0;i<lineNoObjLen;i++){
					reqDate=eval("document.myForm.deliveryDate"+i+".value");
					if(reqDate==""){
						alert("Please enter delivery date");
						return;
					}else{
						b=reqDate.split("."); 
						var delDate = new Date(b[2],(b[1]-1),b[0]);
						if(delDate<toDate){
							alert("Delivery date should be greater than Today's date");
							return;
						}
					}	
				}
			}
		}
		
		hideButton();
		document.myForm.action="ezEditSaveRFQ.jsp";
		document.myForm.submit();
		
	}


</Script>
</head>

<body onLoad="scrollInit()" onResize="scrollInit()">
<form  name="myForm">




<%
	String display_header = "RFQ Details";
%>	
	
<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<%
	
	
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	Vector types = new Vector();
        types.addElement("date");
        EzGlobal.setColTypes(types);
		
        Vector names = new Vector();
	names.addElement("ORDERDATE");		
        EzGlobal.setColNames(names);
        
        ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)dtlXML);
        int rfqHeaderCnt =0;
        
        if(rfqHeader!=null)
        	rfqHeaderCnt = rfqHeader.getRowCount();
        	

        	
        if(rfqHeaderCnt!=0)
        {
        
        	
		String OrderDate = ret.getFieldValueString(0,"ORDERDATE");
		
 %>
		
		<br>
		<table width="80%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
		<tr>
			<th width="15%" align="left">RFQ No </th>
			<td width="15%" align="left">
			<input type="hidden" name="rfqNo" value="<%=poNum%>">
			<input type="hidden" name="myCollRFQNo" value="<%=myCollRFQNoT%>">
			
			<%=poNum%>
			</td>
			
			<th width="15%" align="left">RFQ Date</th>
			<td width="15%" align="left"><%=OrderDate%></td>
			<th width="20%" align="left">Quotation End Date</th>
			<td width="20%" align="left"><input type="text" name="qtnEndDate" class="InputBox" size=12 value="<%=CDate%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="15" onClick=showCal("document.myForm.qtnEndDate",75,650,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")>&nbsp;</td>
			
		</tr>
		</table>
		<br>

		<Div id="theads">
		<table id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<tr align="center" valign="middle">
		<th width="5%">Line</th>
		<th width="15%">Material</th>
		<th width="30%">Description</th>
		<th width="15%">Quantity</th>
		<th width="10%">UOM</th>
		<th width="15%">Delivery Date</th>
		<th width="10%">Plant</th>
		
		
		</tr>
		</table>
		</div>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<table id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="100%">
<%
		
		for(int i=0;i<Count;i++)
		{
			String delDate=fd.getStringFromDate((Date)dtlXML.getFieldValue(i,"CONFIRMDELIVERYDATE"),".",ezc.ezutil.FormatDate.DDMMYYYY);
%>
			<tr>
				<td width="5%" align="center">
					<input type="hidden" name="lineNo" value="<%=dtlXML.getFieldValueString(i, "POSITION")%>">
					<%=dtlXML.getFieldValueString(i, "POSITION")%>
				</td>
				<td width="15%" align="center">
<%				try{
					out.println(Long.parseLong(dtlXML.getFieldValueString(i,"ITEM")));
				}catch(Exception e){
					out.println(dtlXML.getFieldValueString(i,"ITEM"));
				}
%>
				</td>
				<td width="30%">
					<input type="text" size=40 name="matDesc" class="InputBox" value="<%=dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%>">
				</td>
				<td align="right" width="15%">
					<input type="text" size=10 name="quantity" class="InputBox" onBlur="checkQty(this)" value="<%=dtlXML.getFieldValueString(i,"ORDEREDQUANTITY")%>" style="text-align:right">
				</td>
				<td align="center" width="10%"><%=dtlXML.getFieldValueString(i,"UOMPURCHASE")%></td>
				<td align="center" width="15%">
				<input type="text" name="deliveryDate<%=i%>" class="InputBox" size=12 value="<%=delDate%>" readonly> <img src="../../Images/calender.gif" style="cursor:hand" height="15" onClick=showCal("document.myForm.deliveryDate<%=i%>",75,650,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")>&nbsp;
				
				</td>
				<td align="center" width="10%"><a href="JavaScript:void(0)" onClick=goToPlantAddr('<%=dtlXML.getFieldValueString(i,"PLANT")%>')><%=dtlXML.getFieldValueString(i,"PLANT")%></a>&nbsp;</td>
    			</tr>
<%	
		}
%>
  		</table>
		</div>
		<div align='center' style='position:absolute;top:88%;left:45%'>
		<span id="EzButtonsSpan" >
	
<%		
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
        
    butActions.add("history.go(-1)");
    butActions.add("saveChanges()");
    out.println(getButtons(butNames,butActions));
%>
	</span>
		<span id="EzButtonsMsgSpan" style="display:none">
		<Table align=center>
			<Tr>
				<Td class="labelcell">Your request is being processed... Please wait</Td>
			</Tr>
		</Table>
	</span>
			
</div>
<%
	}
%>
 </Form>	
 <Div id="MenuSol"></Div>
 </body>
 </html>
