<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
//int noOfSystemPresent = retsys.getRowCount();
int counter = retsys.getRowCount();
Vector noGrps = new Vector();

for(int ii=0;ii<counter;ii++){
			String systemType= retsys.getFieldValueString(ii,SYSTEM_TYPE);
			String systemNumber = retsys.getFieldValueString(ii,SYSTEM_NO);
			// Get List Of Groups for a System
			EzcSysConfigParams sparams2 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
			snkparams2.setLanguage("EN");
			snkparams2.setSystemNumber(systemNumber);
			sparams2.setObject(snkparams2);
			Session.prepareParams(sparams2);
			ReturnObjFromRetrieve grpReturnObj = (ReturnObjFromRetrieve)sysManager.getUserGroups(sparams2);
			grpReturnObj.check();

			if(grpReturnObj.getRowCount()>0)
			{
			retsys.deleteRow(ii);
			ii--;
			counter--;
			}

}//end of for loop
//}//end of if condition



%>
</body>
</html>
