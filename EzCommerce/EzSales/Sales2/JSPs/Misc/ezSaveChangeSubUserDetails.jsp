<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%
	String UserId = (request.getParameter("UserID")).trim();
	String FirstName = (request.getParameter("userName")).trim();
	String Email = (request.getParameter("email")).trim();
	String ValidToDate = "01/31/01";
	String UserGroup = "0", UserType = "3";
	String CatalogNumber = (request.getParameter("catnum")).trim();
	String subUserAuth = request.getParameter("subUserAuth");
	
	ezc.ezcommon.EzLog4j.log("subUserAuth::::::::::::::"+subUserAuth,"I");
	

	String[] chk=request.getParameterValues("CheckBox");
	String[] subUserSysKeys=request.getParameterValues("subUserSysKeys");
	
	

	String [] ERPCust = null;
	String [] SysKey = null;

	java.util.Vector myVector=new java.util.Vector();
	java.util.Vector customers=new java.util.Vector();
	java.util.Vector syskeys=new java.util.Vector();

	String [] selSoldTo=request.getParameterValues("SelSoldTo");
	String [] selSysKey=request.getParameterValues("SelSysKey");


	if(chk!=null)
	{
		for(int i=0;i<chk.length;i++)
		{
			java.util.StringTokenizer stk=new java.util.StringTokenizer(chk[i],"#");
			String token1=stk.nextToken();
			String token2=stk.nextToken();
			customers.addElement(token1);
			syskeys.addElement(token2);
			myVector.addElement(token1+"[[[]]]" + token2);
		}
	}
	
	
	
	
	

	if(selSoldTo!=null)
	{
		for(int i=0;i<selSoldTo.length;i++)
		{
			if(myVector.contains(selSoldTo[i] +"[[[]]]" + selSysKey[i]))
			{
				customers.removeElement(selSoldTo[i]);
				syskeys.removeElement(selSysKey[i]);
				continue;
			}
			customers.addElement(selSoldTo[i]);
			syskeys.addElement(selSysKey[i]);
		}
	}



	ERPCust= new String[customers.size()];
	SysKey=new String[syskeys.size()];
	for(int i=0;i<customers.size();i++)
	{
		ERPCust[i]=((String)customers.elementAt(i)).trim();
		
		//out.println("<Br>::::ERPCust::::"+ERPCust[i]);
		
		SysKey[i]=((String)syskeys.elementAt(i)).trim();
		
		//out.println("<Br>:::SysKey::::"+SysKey[i]);
	}

	EzUserStructure in = new EzUserStructure();
	in.setUserId(UserId.trim());
	in.setFirstName(FirstName);
	in.setMiddleName("");
	in.setLastName("");
	in.setEmail(Email);
	in.setType(new Integer (UserType).intValue());
	in.setUserGroup(new Integer (UserGroup).intValue());
	in.setValidToDate(ValidToDate);
	in.setIsBuiltInUser("Y");


	EzcUserParams uparams = new EzcUserParams();
	EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
	ezcAddUserStructure.setEzUserStructure(in);
	ezcAddUserStructure.setERPCustomer(ERPCust);
	ezcAddUserStructure.setSysKey(SysKey);
	ezcAddUserStructure.setCatalogNumber(CatalogNumber);
	uparams.createContainer();
	uparams.setObject(ezcAddUserStructure);
	Session.prepareParams(uparams);
	UserManager.updateUser(uparams);
	
	/******************** Update Sub User Auth - Start **********************/
	
	if(subUserAuth!=null && !"null".equals(subUserAuth) && !"".equals(subUserAuth))
	{
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);

		miscParams.setQuery("UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+subUserAuth.trim()+"' WHERE EUD_USER_ID='"+UserId.trim()+"' AND EUD_KEY='SUAUTH'");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		MiscManager.ezUpdate(miscMainParams);
	}

	/******************** Update Sub User Auth - End **********************/
%>

<html>
<head>
<Title>Add User</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
	function navigateBack(obj)
	{
		document.myForm.action=obj;
		document.myForm.submit();
	}
</script>
</head>
<body> 
<form name="myForm">
	<br><br><br><br>
<%
	String noDataStatement = "User data updated successfully";

%>
	<%@ include file="../Misc/ezDisplayNoData.jsp"%> 	
	<!--
	<Table width="40%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th align=center>Updation has been done successfully .</Th>
	</Tr>
	</Table>
	-->
		
	<Div id="ButtonDiv" style="position:absolute;top:60%;width:100%" align="center">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Ok");
		buttonMethod.add("navigateBack(\"../Misc/ezListSubUsers.jsp\")");
			
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</Div>
</form>
	<Div id="MenuSol"></Div>
</body>
</html>