<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iViewDespDetailsLocal.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iViewReceivedDel_Lables.jsp"%>


<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<Script>
		  var tabHeadWidth=95
<%if ((retHeadDetails!=null)||(retHeadDetails.getRowCount()>0)){
%>
   	  var tabHeight="35%"
<%}else{%>
   	  var tabHeight="60%"

<%}%>
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script>
	function showSpan(spid)
	{
		spobj=document.getElementById("SP"+spid);
		
		if (spobj!=null){
			if(spobj.style.display=="none")
				spobj.style.display="block";
			else if(spobj.style.display=="block")
				spobj.style.display="none"; 
		}
	}
	function openWindow1(fieldName)
	{
		str = "ezShowRemarks.jsp?fieldName="+fieldName
		newWindow = window.open(str,"MyWin","resizable=no,left=250,top=180,height=250,width=350,status=no,toolbar=no,menubar=no,location=no")

		/*
		Str=eval(fieldName).value;		
		if(Str!=null)
		retVal =showModalDialog("../Projections/ezShowRemarks.jsp",Str,'center:yes;dialogWidth:20;dialogHeight:16;status:no;minimize:yes');
		else
		retVal =showModalDialog("../Projections/ezShowRemarks.jsp"," ",'center:yes;dialogWidth:20;dialogHeight:16;status:no;minimize:yes');
		*/
	}
	function openWindow1(fieldName)
	{
		str = "ezAddRemarks.jsp?fieldName="+fieldName
		newWindow = window.open(str,"MyWin","resizable=no,left=250,top=180,height=250,width=350,status=no,toolbar=no,menubar=no,location=no")		
		
	}
	function ezBack()
	{
			history.go(-1);
	}
	function funAcknowledge()
	{
		var rcDate = document.myForm.recDate;
		if(rcDate==null || rcDate.value=="")
		{
			alert("Please enter received date")
			return;
		}
		document.myForm.action="ezSaveReceivedDel.jsp";
		document.myForm.submit();
	}
	</script>
</head>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>

<form  method="post" onSubmit="return false" name="myForm">

<input type="hidden" name="Stat" value="<%=request.getParameter("Stat")%>" >
<%
	try{
	     delNum=Long.parseLong(delNum)+"";
	   }catch(Exception e){ }

	String display_header = disDet_L+delNum; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<%
	String userName=(String)Session.getUserId();
	String crBy=null;
	String role=(String)session.getValue("UserRole");
		String stat=null;
		String recDate=null;
		String st=retHeadDetails.getFieldValueString(0,"STATUS");
		st=st.trim();

		if("D".equals(st)) 
		{
			stat="Yet to receive";
			recDate = "";
		}	
		else if ("R".equals(st)) 
		{
			stat="Acknowledged";
			recDate = retHeadDetailsGlobal.getFieldValueString(0,"GOODS_RECEIVED");
		}	
		
	if ((retHeadDetails!=null)||(retHeadDetails.getRowCount()>0))
	{
		//out.println("retHeadDetails	"+retHeadDetails.toEzcString());
	%>
	<table  width="95%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	
	<tr>
		<input type="hidden" name="SoNum" value="<%=retHeadDetails.getFieldValue(0,"SO_NUM")%>" >
		<th align="left" width='25%'>Delivery Challan No</th>
		<td width='35%'><%=retHeadDetails.getFieldValue(0,"DC_NR")%>&nbsp;
		<input type="hidden" name="DelNum" value="<%=retHeadDetails.getFieldValue(0,"DC_NR")%>" >
		</td>
		<th align="left" width='20%'>Delivery Challan Date</th>
		<td width='20%'><%=retHeadDetailsGlobal.getFieldValue(0,"DC_DATE")%></td>
	</tr>

	<tr>
		<th align="left" width='25%'><%=lrNo_L%></th>
		<td width='35%'> <a href="http://www.fedex.com/Tracking?tracknumbers=<%=retHeadDetails.getFieldValue(0,"LR_RR_AIR_NR")%>" target="_blank" ><%=retHeadDetails.getFieldValue(0,"LR_RR_AIR_NR")%> </a> </td>
		<th align="left" width='20%'><%=shipDat_L%></th>
		<td width='20'><%=retHeadDetailsGlobal.getFieldValue(0,"SHIPMENT_DATE")%></td>
	</tr>
	<tr>
		<th align="left" width='25%'><%=caName_L%></th>
		<td width='35%'><%=retHeadDetails.getFieldValue(0,"CARRIER")%></td>
		<th align="left" width='20%'><%=recDate_L%></th>		
<%		if("D".equals(st)) 
		{
%>			<td width='20%'><input type=text name="recDate" class=InputBox   size=12 maxlength="10" readonly><%=getDateImage("recDate")%></td>	
<%		}	
		else if ("R".equals(st)) 
		{
%>			<td width='20%'><%=recDate%>&nbsp;</td>
<%		}
%>

	</tr>
	<tr>
		<th align="left" width='25%'>Sold To </th>
		<td width='35%'>
		<%
		String sold=retHeadDetails.getFieldValueString(0,"SOLDTO");

		String  Name=sold;

		int retCustListCount=retCustList.getRowCount();
		for ( int j = 0 ; j < retCustListCount; j++ )
		{
			if(retCustList.getFieldValueString(j,"EC_ERP_CUST_NO").equals(sold))
				Name = retCustList.getFieldValueString(j,"ECA_NAME");
		}
		out.println(Name);
		%></td>

			<th  align="left" width='20%'><%=status_L%></th>
			<Td width='20%'><%=stat%></td>
	</tr>
	<tr>
		<th align="left" width='25%'><%=remark_L%></th>
		<td align="left" colspan=3 width='75%'>
		<%=retHeadDetails.getFieldValueString(0,"HEADERTEXT")%>
		</td>
	</tr>
	</table>
	<%
	}%>

	<%
	     
	if ((retLineDetails!=null)||(retLineDetails.getRowCount()>0))
	{
	%>
	<Div id="theads">
	<table id="tabHead" width="95%"   align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<tr>
		<th width="10%"><%=lineNo_L%></th>
		<!--<th width="16%"><%=batNo_L %></th>-->
		<th width="50%"><%=proddesc_L%></th>
		<!--<th width="5%"><%=uom_L%></th>-->
		<th width="20%"><%=qtyShip_L%></th>
		<th width="20%"><%=remark_L%></th>
	</tr>
	</Table>
	</Div>
<%if ((retHeadDetails!=null)||(retHeadDetails.getRowCount()>0)){
%>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:35%;left:2%">
<%}else{%>
   	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">

<%}%>

	<Table align=center  id="InnerBox1Tab"  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 width="100%">
<%
	int line=0;
	String batch=null;
	String matNo=null;
	String matDesc=null;
	String UOM=null;
	String QTY=null;
	String Ext2=null;
	String rqty=null;
	String Plant=null;
	int spanCount=0;
	int retLineCount=retLineDetails.getRowCount();
	String iRem="";
	for (int i=0;i<retLineCount;i++)
	{
		String lin =retLineDetails.getFieldValueString(i,"LINE_NR");
		lin=(lin == null || "null".equals(lin) || lin.trim().length() == 0)?"0":lin;
		line=Integer.parseInt(lin);
		matDesc=retLineDetails.getFieldValueString(i,"MAT_DESC");
		UOM=retLineDetails.getFieldValueString(i,"UOM");
		QTY=retLineDetails.getFieldValueString(i,"QTY_SHIPPED");
		batch=retLineDetails.getFieldValueString(i,"BATCHNO");
		batch= ((batch==null)||("null".equals(batch)))?" ":batch;
		Ext2=retLineDetails.getFieldValueString(i,"REFNO");
		rqty=retLineDetails.getFieldValueString(i,"RECEIPTS");
		String lineRef=retLineDetails.getFieldValueString(i,"LINEREF");
		java.math.BigDecimal Bqty = new java.math.BigDecimal("0");
		iRem=retLineDetails.getFieldValueString(i,"REMARKS");
%>
		<input type="hidden" name="lineno_<%=i%>" value="<%=line%>">
		<input type="hidden" name="recQty_<%=i%>" value="<%=QTY%>">	
<%

		if(batch.trim().length()==0)
		{
				int k=i;		
		%>
		<Tr><td>
			<span>
			<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>


			<td width='10%'><%=line%>&nbsp;</td>
			<!--<td width='16%'>
			<a href='JavaScript:showSpan("<%=spanCount%>")'>
				<%=multiBatch_L%>
			</a>
			</td>-->
			<td width='50%'><%=matDesc%></td>
			<!--<td width='5%'><%=UOM%></td>-->
			<Td width='20%' align='right'><a id="Mqty_<%=i%>">&nbsp;</a></Td>
			<Td width="20%">
				<input type="hidden" name="Rem_<%=i%>" value="<%= iRem %>">
				<%/*if(iRem == null || "null".equals(iRem) || iRem.trim().length()==0)
				{
					out.println("&nbsp;");
				}else{*/%>
					<a href='JavaScript:openWindow1("myForm.Rem_<%=i%>")'><center><image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0  title="<%=clkHrVewRmks_L%>" <%=statusbar%> ></a>
				<%//}
				%>
			</Td>
			</Tr>
			</Table>

			
		</span>
		<span id="SP<%=spanCount%>"  style="display:none">
		<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<%
		int n=i;
		int tot = 0;
		String jRem="";
		for (int j=i+1;j<retLineCount;j++)
		{
%>		
			<input type="hidden" name="lineno_<%=j%>" value="<%=retLineDetails.getFieldValueString(j,"LINE_NR").trim()%>" >
			<input type="hidden" name="recQty_<%=j%>" value="<%=QTY%>" >

<%		
			String refno =retLineDetails.getFieldValueString(j,"LINEREF");
			refno=(refno == null || "null".equals(refno) || refno.trim().length() == 0)?"0":refno.trim();

			if (lineRef.equals(refno))
			{
					try{
					refno=String.valueOf(Integer.parseInt(refno));
					}catch(Exception e){}
					String jQty= retLineDetails.getFieldValueString(j,"QTY_SHIPPED");
					i++;
					jRem=retLineDetails.getFieldValueString(j,"REMARKS");
					
		%>
			<tr>
				<td width='10%'><%=retLineDetails.getFieldValueString(j,"LINE_NR").trim()%>&nbsp;</td>
				<!--<td width='16%'><%=retLineDetails.getFieldValueString(j,"BATCHNO").trim()%>&nbsp;</td>-->
				<td width='50%'><%=retLineDetails.getFieldValue(j,"MAT_DESC")%></td>
				<!--<td width='5%'><%=retLineDetails.getFieldValue(j,"UOM")%></td>-->
				<Td width='20%' align='right'><%=jQty%></Td>
				<Td width="20%">
					<input type="hidden" name="Rem_<%=i%>" value="<%=jRem%>">
					<%/*if(iRem == null || "null".equals(iRem) || iRem.trim().length()==0)
				{
					out.println("&nbsp;");
				}else{*/%>
					<a href='JavaScript:openWindow1("myForm.Rem_<%=i%>")'><center><image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0 <%=statusbar%>></a>
					<%//}%>
				</Td>
				</tr>
			<%
				Bqty=Bqty.add(new java.math.BigDecimal(jQty));

			}
			if((retLineDetails.getFieldValueString(j+1,"BATCHNO")).trim().length()==0 )
			{
				break;
			}
			
		}%>
		<%if (tot > 0){%><input type="hidden"  name="final_<%=n%>" value="<%= tot%>"><%}%>
		</Table>
		</span>
			<script>
					if(document.getElementById("Mqty_<%=k%>") != null)
					document.getElementById("Mqty_<%=k%>").innerHTML="<%=Bqty.toString()%>"
				</script>	
	<%	spanCount++;
	%>
		</Td></Tr>
	<%
	}
	else
	{%>
		<Tr><Td>
		<span>
		<Table width='100%'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<td width='9%'><%=line%></td>
		<!--<td width='16%'><%=batch%>&nbsp;</td>-->
		<td width='45%'><%=matDesc%></td>
		<!--<td width='5%'><%=UOM%></td>-->
		<Td width='18%' align='right'><%=retLineDetails.getFieldValue(i,"QTY_SHIPPED")%></Td>
		<Td width="19%">
		<%
		/*if(iRem == null || "null".equals(iRem) || iRem.trim().length()==0)
				{
					out.println("&nbsp;");
				}else{*/%>
			<input type="hidden" name="Rem_<%=i%>" value="<%= iRem %>"><a href='JavaScript:openWindow1("myForm.Rem_<%=i%>")'><center><image src="../../Images/Buttons/<%= ButtonDir%>/text.gif" border=0 <%=statusbar%>></a>
		<%//}%>
		</Td>
		</Tr>
		</Table>
		</span>
		</Td></Tr>
	<%}
	}//for
	%>
	</Table>
		</Div>
		
	<input type='hidden' name="TotCount" value="<%=retLineDetails.getRowCount()%>">

	<%}
	else
	{%>
		<table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >><Tr><Td align='center' colspan=5><%=noLines_L%></Td></Tr></Table>
	<%}%>
	
	<div id="buttonDiv" align="center" style="position:absolute;top:92%;width:100%">
		<table width="100%">
		<tr><td class=blankcell align="center">
<%		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		if("D".equals(st)) 
		{
			buttonName.add("Acknowledge");
			buttonMethod.add("funAcknowledge()");
		}
			
			buttonName.add("Back");
			buttonMethod.add("ezBack()");
			
		out.println(getButtonStr(buttonName,buttonMethod));
	
%>
		</td></tr>
		</table>
	</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
