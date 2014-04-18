<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iInvPaymentDetails_Labels.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<%@ include file="../../../Includes/JSPs/Purorder/iInvoiceDetails_JCO.jsp"%>        
<%
	String invoiceNumber = "";
	try{
		invoiceNumber = Long.parseLong(invnum)+"";
	}
	catch(Exception numFmtEx){
		invoiceNumber = invnum+"";
	}
	
	
	String invoiceDate = new ezc.ezutil.FormatDate().getStringFromDate(dt,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))+"";
	String invoiceAmount = "";
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	if ((invAmount==null)||(invAmount.equals(""))){
		invoiceAmount = "0.00";
	}
	else{
		   invoiceAmount = myFormat.getCurrencyString(invAmount)+"";
	}
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="45%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>  
<form name="InvPayDtls">
<% 
	String display_header =invoicePayDetail_L;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp" %> 

	
<Div id='inputDiv' style='position:relative;align:center;top:2%;width:100%;'>
<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
			<Tr>
				<Td style="background-color:'F3F3F3';" align='left'>
					<font size=2><B><%=invoiceNumber_L%>&nbsp;:&nbsp;</B><%=invoiceNumber%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='center'>
					<font size=2><B><%=invDate_L%>&nbsp;:&nbsp;</B><%=invoiceDate%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='right'>
					<font size=2><B><%=invoiceAmount_L%> [<%=invCur%>]&nbsp;:&nbsp;</B><%=invoiceAmount%></font>
				</Td>
			</Tr>
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>
<br>
<%	
	double totPays = 0;
	if(SeqInv.getRowCount() == 0)
	{
		out.println("<table width=70% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 ><tr><td colspan=\"5\" align=\"center\">"+noSubItems_L+"</td></tr></table>");
	}
	else
	{
%>
		<DIV id="theads">
		<table id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
			<th width=30%><%=payDate_L%></th>
			<th  width=30%><%=payAmt_L%> [<%=invCur%>]</th>
			<th  width=20%><%=cheque_L%>#</th>
			<th  width=20%><%=bank_L%></th>
		</TR>
		</Table>
		</DIV>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
		<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		double paid= 0;
		double disCount= 0;
		for(int i=0;i<SeqInv2.getRowCount();i++)
		{
			paid= 0;
							
			try{
				 paid =  Double.parseDouble(SeqInv2.getFieldValueString(i,"PAIDAMOUNT"));
				 disCount =  Double.parseDouble(SeqInv2.getFieldValueString(i,"EXT1"));
				 
				 if("H".equals(SeqInv2.getFieldValueString(i,"DBCRINDICATOR"))){    
				 //paid = 0.00-paid;
				 totPays += paid;
				 // continue;
				 }
				 paid-=disCount;
				
			}catch(Exception numFmtEx)
			{
				totPays+=0;
			}
			if(paid != 0)
			{
			
%>		
				<tr>
					<td align="center" width=30%><%=new ezc.ezutil.FormatDate().getStringFromDate((Date)SeqInv2.getFieldValue(i,"PAYMENTDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
					<td align="right"  width=30%>
<%					String payAmount = myFormat.getCurrencyString(paid);
					String disCnt = myFormat.getCurrencyString(disCount);
					
					try
					{
						out.println(payAmount);
					}
					catch(Exception e)
					{
						out.println(SeqInv2.getFieldValueString(i,"PAIDAMOUNT"));
					}
%>
					</td>
					<td  width=20%><%=SeqInv2.getFieldValue(i,"CHEQUENUMBER")%>&nbsp;</td>
					<td  width=20%><%=SeqInv2.getFieldValue(i,"BANKNAME")%>&nbsp;</td>
				</tr>
<%
			    if(disCount != 0)
			    {
 %>
				<tr>
					<th>Discount[<%=invCur%>]</th>
					<td align="right"><b>&nbsp;<%=disCnt%></b></td>
				</tr>
<%
			    }

			}
		}
		if(totPays != 0 )	
		{
%>	
				
				<tr>
				<th>Total Amount[<%=invCur%>]</th>
				<td align="right"><b><%=myFormat.getCurrencyString(totPays)%><b></td>
				</tr>
<%
		}
%>		
		</Table>
		</Div>
<%
	}	
	if(totPays == 0 )
	{
		String noDataStatement = payDetNo_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
		<Script>
			document.getElementById("theads").style.visibility="hidden"
			document.getElementById("InnerBox1Div").style.visibility="hidden"
		</Script>
<%
	}
%>
	
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</Div>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
   