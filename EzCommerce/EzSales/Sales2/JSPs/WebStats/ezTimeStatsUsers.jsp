<%--
***************************************************************
       /* =====================================
        * Copyright Notice 
	* This file contains proprietary information of Answerthink India Ltd.
	* Copying or reproduction without prior written approval is prohibited.
	* Copyright (c) 2005-2006 
	=====================================*/

       /* =====================================
        * Author : Girish Pavan Cherukuri
	* Team : EzcSuite
	* Date : 16-09-2005
	* Copyright (c) 2005-2006 
	=====================================*/
***************************************************************
--%>
<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTimeStatsUsers_Labels.jsp"%>

 <%

	String Hour=request.getParameter("Hour");
	String Users=request.getParameter("Users");

 %>

<html>
<head>
	<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	<Title><%=webPoweredBy_L%></Title>
</head>
<BODY scroll=no>

	<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class=displayHeader><center> <%=usersLoggedBet_L%>  <%=Integer.parseInt(Hour)%> <%=and_L%>  <%=Integer.parseInt(Hour)+1%></center></Td>
		</Tr>
	</TABLE>
	<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width="50%"><%=user_L%></Td>
		<Th width="50%"><%=noOfTimes_L%></Td>
	</Tr>
<%
		String className = "";
		int a=0;
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(Users,"§");
		java.util.Vector Tokens = EzToken.getTokens();
		for(int v=0;v<Tokens.size();v++)
		{
			a++;
			if(a%2==0) 
				className="class=color";
			else 
				className="";
				
			ezc.ezbasicutil.EzStringTokenizer EzChildToken = new ezc.ezbasicutil.EzStringTokenizer((String)Tokens.elementAt(v),"¥");
			java.util.Vector childTokens = EzChildToken.getTokens();
%>
			<Tr>
				<Td  width="50%" <%=className%>><%=(String)childTokens.elementAt(0)%></Td>
				<Td  width="50%" align="center" <%=className%>><%=(String)childTokens.elementAt(1)%></Td>
			</Tr>
<%
		}
%>
</Table>
<Div id="buttons" align=center style="position:absolute;top:90%;width:100%;visibility:visible">
<%		
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

</Div> 
<Div id="MenuSol"></Div>
</body>
</html>