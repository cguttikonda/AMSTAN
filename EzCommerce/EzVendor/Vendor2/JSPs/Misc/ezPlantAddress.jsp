<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iPlantAddress_Labels.jsp"%> 
<%@ page import="java.util.*" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%
	String fileName = "ezPlantAddress.jsp"; 
%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iGetSbuPlantAddress.jsp"%>             
<HTML>
<head>
</head>
<BODY scroll="no">

<%
	if (ret.getRowCount()==0)
	{
		String noDataStatement = pltAddNotAvail_L;
%>
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>

<Div id="ButtonDiv" align=center style="position:absolute;top:85%;visibility:visible;width:100%">
<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Ok");
		buttonMethod.add("window.close()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</Div>

<%
	}
	else{
%>
<TABLE width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	 <tr align="center">
	    <th colspan=2> <%=addOfPlnt_L%> <%=token%></th>
 	 </tr>
        <tr>
	<th width="20%" align="left"><%=name_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"NAME")%>&nbsp;</td>
        </Tr>
        <Tr>
	<th width="20%" align="left"><%=add1_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"ADDRESS1")%>&nbsp;</td>
	</tr>
	<tr>
	<th width="20%" align="left"><%=add2_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"ADDRESS2")%>&nbsp;</td>
        </Tr>
        <Tr>
	<th width="20%" align="left"><%=city_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"CITY")%>&nbsp;</td>
	</tr>
	<tr>
	<th width="20%" align="left"><%=state_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"STATE")%>&nbsp;</td>
        </Tr>
        <Tr>
	<th width="20%" align="left"><%=country_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"COUNTRY")%>&nbsp;</td>
	</tr>
	<tr>
	<th width="20%" align="left"><%=cst_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"CST")%>&nbsp;</td>
        </Tr>
        <!-- <Tr>
	<th width="20%" align="left"><%=cenExCode_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"CENTRALEXICE-CODE")%>&nbsp;</td>
	</tr> -->
	<tr>
	<th width="20%" align="left"><%=phone_L%></th>
	<td width="20%"><%=ret.getFieldValueString(0,"PHONE")%>&nbsp;</td>
        </Tr>
        </tABLE>

<br>

<Div id="ButtonDiv" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();

		buttonName.add("Ok");
		buttonMethod.add("window.close()");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</Div>
<%}%>
<Div id="MenuSol"></Div>
</body>
</html>
