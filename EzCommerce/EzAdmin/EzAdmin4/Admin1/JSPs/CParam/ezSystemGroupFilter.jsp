<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
			// Get List Of Groups for a System
			EzcSysConfigParams sparams2 = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams2 = new EzcSysConfigNKParams();
			snkparams2.setLanguage("EN");
			snkparams2.setSystemNumber(sys_num);
			sparams2.setObject(snkparams2);
			Session.prepareParams(sparams2);
			ReturnObjFromRetrieve grpReturnObj = (ReturnObjFromRetrieve)sysManager.getUserGroups(sparams2);
			grpReturnObj.check();

			if(grpReturnObj.getRowCount()>0)
			{
			groupExist = true;
			}
			else
			{
			groupExist = false;
			}

%>
</body>
</html>
