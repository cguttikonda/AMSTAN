<%@ page import = "ezc.ezparam.*,ezc.ezbasicutil.*,ezc.ezutil.FormatDate,java.util.*,ezc.ezsalesquote.params.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%

	String soNum = request.getParameter("docId");
	int retCount = 0;

	ezc.ezsalesquote.client.EzSalesQuoteManager EzSalesQuote = new ezc.ezsalesquote.client.EzSalesQuoteManager();
	
	ezc.ezparam.EzcParams auditMainParams = new ezc.ezparam.EzcParams(true);
	auditMainParams.setLocalStore("Y");
	EziWFAuditTrailParams eziWFHistoryParams= new EziWFAuditTrailParams();
	eziWFHistoryParams.setEwhDocId(soNum+"') AND EWAT_TYPE IN ('SQUOTE");
	eziWFHistoryParams.setEwhType("SQUOTE");
	eziWFHistoryParams.setEwhExt1("$$");
	auditMainParams.setObject(eziWFHistoryParams);
	Session.prepareParams(auditMainParams);
	ReturnObjFromRetrieve auditNoRetObj = (ReturnObjFromRetrieve)EzSalesQuote.ezGetWFAuditTrailNo(auditMainParams);
	
	//out.println("auditNoRetObj:::::::::::::::::"+auditNoRetObj.toEzcString());
	
	if(auditNoRetObj!=null && auditNoRetObj.getRowCount()>0)
		retCount = auditNoRetObj.getRowCount();

%>
<html>
<head>
<Title>WorkFlow Audit Trail List For Document:<%=soNum%></Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<script>
var tabHeadWidth = 98;
var tabHeight="65%";
if(screen.width==800)
{
	tabHeight="40%";
}	
function submitPage()
{
	document.myForm.submit()
}
</script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
</head>
<Body onLoad="scrollInit(10)" onresize="scrollInit(10)" scroll=no >
<Form name="myForm">
<input type=hidden name='commentsField'>
<%
	String display_header = "Audit Trail For Sales Quote <font color='#FFFFFF'>"+soNum+"</font>" ;

	if(retCount>0)
	{
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
		String format = EzGlobal.getDateFormat();
		Vector grtypes = new Vector();
		
		grtypes.addElement("date");

		EzGlobal.setColTypes(grtypes);

		Vector grColNames = new Vector();
		grColNames.addElement("EWAT_DATE");
		EzGlobal.setDateFormat(format+" HH:MM:SS");

		EzGlobal.setColNames(grColNames);

		globalRet = EzGlobal.getGlobal(auditNoRetObj);
		EzGlobal.setDateFormat(format);
%>	
		<Table align=center width="98%" class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th width="100%"  align="center"><%=display_header%></Th>
		<Tr>
		</Table>
		<Div id="theads">
		<Table id="tabHead" align=center width="98%" class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			<Tr>
				<!--<Th width="10%"  align="center">Audit</Th>-->
				<Th width="75%" align="center">Action</Th>
				<Th width="25%" align="center">Date </Th>
			</Tr>
		</Table>
		</Div>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:55%;left:2%">
		<Table id="InnerBox1Tab" width="100%" align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
<%
		String comments = "";
		for(int i=0;i<retCount;i++)
		{
			comments = auditNoRetObj.getFieldValueString(i,"EWAT_COMMENTS");
%>
				<Tr>
					<!--<Td width="10%" align="center"><%=auditNoRetObj.getFieldValueString(i,"EWAT_AUDIT_NO")%>&nbsp;</Td>-->
					<Td width="75%" title='<%=comments%>'><%=comments%>&nbsp;</Td>
					<Td width="25%" align="center"><%=globalRet.getFieldValue(i,"EWAT_DATE")%>&nbsp;</Td>
				</Tr>
<%
		}
%>

		</Table>
		</Div>	
<%
	}
	
	if(retCount==0)
	{
%>
		<DIV style="position:absolute;width:100%;height:40%;top:45%">
			<Table align="center" style="width:50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th >List Not Found For This Document Number.</Th>
				</Tr>
			</Table>
		</Div>	
<%
	}
%>		
<Div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:90%">
<%				 
		    buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
		    buttonMethod.add("window.close()");
		    out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>	
<Div id="MenuSol">
</Div>
</form>
</body>
</html>