<%@ page import ="ezc.ezparam.*,ezc.ezpurchase.params.*,java.util.*,ezc.ezutil.*,ezc.ezbasicutil.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
<%@ include file="../../../Includes/Jsps/Purorder/iServiceEntrySheets.jsp"%>

<Html>
<Head>
<Script>
	var tabHeadWidth=95
	var tabHeight="57%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

<title>Serive Entry Sheets</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</Head>
<Body bgcolor="#FFFFF7"  onLoad="scrollInit();" onResize="scrollInit()" scroll=no>
<Form name="myForm">
<%
	String display_header="Serive Entry Sheets";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	if(retObjCount==0){
%>
	<br><br><br>
	<table width="60%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<tr align="center">
	<th>No Serive Entry Sheets Exist</th>
	</tr>
	</table>
	<Div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		butActions.add("JavaScript:history.go(-1);");	
		out.println(getButtons(butNames,butActions));
%>
	</Div>
	
<%
		
	}else{
%>
		<Br>
		
		<Div id="theads">
			<Table  id="tabHead" width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<Tr align="center" valign="middle">
					<Th width="15%">Sheet No</Th>
					<Th width="15%">Pckg.No</Th>
					<Th width="15%">PO No</Th>
					<Th width="10%">PO Item</Th>
					<Th width="35%">Net Value</Th>
					<Th width="10%">Currency</Th>
										
					
				</Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:57%;left:2%">
		<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
		
		
		Vector types = new Vector();
		types.addElement("currency");
		
		EzGlobal.setColTypes(types);

		Vector names = new Vector();
		names.addElement("NET_VALUE");
		EzGlobal.setColNames(names);
		ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)retObj);
		ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
		for(int i=0;i<retObjCount;i++)
		{
			String creatdOn=formatDate.getStringFromDate((Date)retObj.getFieldValue(i,"CREATED_ON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			String creatdBy=retObj.getFieldValueString(i,"CREATED_BY");
			String sheetNo=retObj.getFieldValueString(i,"SHEET_NO");
			String netValue=ret.getFieldValueString(i,"NET_VALUE");
			String currency=retObj.getFieldValueString(i,"CURRENCY");
			
			
%>
			
			<Tr>
			<Td width="15%" align="center"><a href="ezServiceEntrySheetDetails.jsp?docNo=<%=sheetNo%>&selFlg=D&creatdBy=<%=creatdBy%>&creatdOn=<%=creatdOn%>&curr=<%=currency%>&netVal=<%=netValue%>"><%=sheetNo%></a>&nbsp;</Td>
			<Td width="15%" align="center"><%=retObj.getFieldValueString(i,"PCKG_NO")%>&nbsp;</Td>
			<Td width="15%" align="center"><%=retObj.getFieldValueString(i,"PO_NUMBER")%>&nbsp;</Td>
			<Td width="10%" align="center"><%=retObj.getFieldValueString(i,"PO_ITEM")%>&nbsp;</Td>
			<Td width="35%" align="right"><%=netValue%>&nbsp;</Td>
			<Td width="10%" align="center"><%=currency%>&nbsp;</Td>
			</Tr>
<%
		}
%>
		
		</Table>
		</Div>
		
		<Div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
			butActions.add("JavaScript:history.go(-1);");	
			out.println(getButtons(butNames,butActions));
%>
		</Div>
	



<%
	
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
