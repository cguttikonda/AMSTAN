<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iBlockedPoLineItems_Labels.jsp"%>
<%
	boolean hasReleaseAuth = false;
	
	
	if(session.getValue("USERAUTHS") != null)
	{
		
		java.util.Vector authVector = (java.util.Vector)session.getValue("USERAUTHS");
		
		if(authVector.contains("RELEASE_PO"))
		{
			
			hasReleaseAuth = true;
		}
		else
		{
			hasReleaseAuth = false;
		}
	}	
	else
	{
		hasReleaseAuth = false;
	}
	
	
%>
<%@ page import ="java.math.*" %>
<%@ page import ="java.util.*" %> 
<%@ page import ="ezc.ezutil.*" %>

<%@ include file="../../../Includes/JSPs/Purorder/iBlockedPoLineItems.jsp"%>
<%FormatDate formatDate = new FormatDate();%>
<html>
<head>
<title>PO LINE Details</title>

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Script>
var tabHeadWidth=96
var tabHeight="45%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

	<script>
	var releaseAuth = <%=hasReleaseAuth%>;
	function formEvents1(formEv)
	{
		window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=600,left=10,top=10");
	}

	function funSubmit(formEv)
	{
		if(releaseAuth)
		{
			document.myForm.action = formEv
			document.myForm.submit();
		}
		else
		{
			alert("You are not authorized for releasing the Purchase Order to the Vendor");
		}			
	}
	function formEvents(formEv)
	{
			document.myForm.action=formEv;
			document.myForm.submit();
		
	}
	

	function goToPlantAddr(plant)
	{
		window.open("ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=300,height=320");
	}
	</script>

</head>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<%
	int polines = dtlXML.getRowCount();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	if (polines ==0)
	{
		String noDataStatement = noOrdLiPres_L;
%>		
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
	else
	{

		String netOrderAmount = dtlXML.getFieldValueString(0,"NET_VALUE");
		netOrderAmount = netCalcAmt+""; 
		String currency = dtlXML.getFieldValueString(0,"CURRENCY");
		String display_header = poDetails_L;
		String poNumberx="";
		try
		{
			poNumberx=Long.parseLong(poNum)+"";
		}
		catch(Exception e)
		{
			poNumberx=poNum;;
		}
		String poDate = formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String poVal  = myFormat.getCurrencyString(netOrderAmount);
		
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp" %>
				
		<Div id='inputDiv' style='position:relative;align:center;top:2%;width:100%;'>
		<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'#F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
					<Tr>
						<Td style="background-color:'#F3F3F3';" align='left'>
							<font size=2><B><%=poNo_L%>&nbsp;:&nbsp;</B><%=poNumberx%></font>
						</Td>
						<Td style="background-color:'#F3F3F3';" align='center'>
							<font size=2><B><%=orderDate_L%>&nbsp;:&nbsp;</B><%=poDate%></font>
						</Td>
						<Td style="background-color:'#F3F3F3';" align='right'>
							<font size=2><B><%=netValue_L%>[<%=currency%>]&nbsp;:&nbsp;</B><%=poVal%></font>
						</Td>
					</Tr>
				</Table>
			</Td>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>		
		<br>

		<form  name="myForm" method="post">
		<input type="hidden" name="OrderDate" value="<%=poDate%>">
		<input type="hidden" name="OrderType" value='<%=request.getParameter("type")%>'>

		<DIV id="theads">
		<Table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
		<th width="5%" ><%=line_L%></th>
      		<th width="12%"><%=mat_L%></th>
	      	<th width="25%"> <%=desc_L%></th>
      		<th width="6%"><%=uom_L%></th>
	      	<th width="11%"><%=qty_L%></th>
      		<th width="11%"><%=price_L%></th>
	      	<th width="14%"><%=value_L%></th>
     		<th width="6%"><%=plant_L%></th>
	      	<th width="10%"><%=edDate_L%></th>
		</Tr>
		</Table>
		</div>


		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
		<TABLE  id="InnerBox1Tab"  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<%

		for(int i=0; i<polines; i++)
		{
			String lineNum = (String)dtlXML.getFieldValue(i, LINENO);
			String matNum = (String)dtlXML.getFieldValue(i, MATERIAL);
			matNum = matNum.trim();
			String matDesc = (String)dtlXML.getFieldValue(i, MATDESC);
			matDesc = matDesc.trim();
			String uom = (String)dtlXML.getFieldValue(i, UOM);
			String qty = dtlXML.getFieldValueString(i, ORDQTY);
			String plant = dtlXML.getFieldValueString(i, "PLANT");

			java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
			String price = dtlXML.getFieldValueString(i, AMOUNT);
			price = (Double.parseDouble(price)*100)+"";
			double amnt = 0.0;
			try{
				amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"))*100;
			}catch(Exception e){}
			BigDecimal BD = new BigDecimal(amnt);
			String netAmount =dtlXML.getFieldValueString(i, AMOUNT);


			Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
			String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));

			%>

    			<tr align="center">
		      	<td width=5%"><%if(lineNum != null)out.println(lineNum); %></td>
			<td width="12%" align=left>
			<%try{
				matNum=String.valueOf(Long.parseLong(matNum));
			}catch(Exception nfe){	}

			%>
			<%= matNum %>&nbsp;
    			</td>

    			<td width="25%" align=left title="<%=matDesc%>">
			<%=matDesc%>
    			</td>
			<td width="6%"><%=uom %>&nbsp;</td>
			<td width="11%" align="right"><%=qty%>&nbsp</td>
			<td width="11%" align="right">
			<%=myFormat.getCurrencyString(price)%>&nbsp
			</td>
			<td width="14%" align="right">
			<%
				String bd = BD.toString();
				out.println( myFormat.getCurrencyString(bd));
			%>
			<input type="hidden" name="POPrice" value="<%=BD%>">&nbsp</td>
			<td width="6%">
			<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='<%=viwPltAdd_L%>'; return true" onMouseout="window.status=' '; return true">
			<%=plant%></a>&nbsp</td>
    			<td width="10%" align="center">
			<%
			if(edDate.length() == 10)
			{
				if(dtlXML.getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
				{
			%>		<a href="ezDelDetPO.jsp?orderNum=<%=dtlXML.getFieldValue(0,ORDER)%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=edDate%></a>
			<%	}
				else
				{
			%>		<%=edDate%>
			<%	}
			}
			%>&nbsp
			</td>
	  		</tr>
			<%

		}

		%>

	</Table>

	</div>

	<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
	<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Back");
		buttonMethod.add("history.go(-1)");
		
		buttonName.add("Print");
		buttonMethod.add("formEvents(\"ezPrint.jsp\")");


		if("PURPERSON".equals(Session.getUserId()) || "PURHEAD".equals(Session.getUserId()))
		{
			buttonName.add("Release Order");
			buttonMethod.add("funSubmit(\"ezReleasePurchaseOrder.jsp\")");
		}	
		
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
	</div>
	
<input type=hidden name="poData" value="<%=poNum%>¥<%=vendor%>¥<%=request.getParameter("type")%>¥<%=sysKey%>">
<input type=hidden name="PurchaseOrder" value="<%=poNum%>">
<input type=hidden name="vendorNo" value="<%=vendor%>">  
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
