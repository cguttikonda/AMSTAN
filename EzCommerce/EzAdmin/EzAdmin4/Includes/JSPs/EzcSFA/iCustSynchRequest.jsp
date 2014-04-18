<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezadmin.busspartner.params.*,java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<%
	String user_id = "";
	if(request.getParameter("UserId")!=null)
		user_id = request.getParameter("UserId");
	Vector sectorData = new Vector();
	if(user_id != null)
	{
		EzcUserParams uparamsN= new EzcUserParams();
		EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
		ezcUserNKParamsN.setLanguage("EN");
		uparamsN.setUserId(user_id);
		uparamsN.setObject(ezcUserNKParamsN);
		Session.prepareParams(uparamsN);
		ReturnObjFromRetrieve reterpdef = (ReturnObjFromRetrieve)UserManager.getAddUserDefaults(uparamsN);
		reterpdef.check();
		String defaultArea = "";
		String defKey = "";
		
		if(reterpdef != null)
		{
			for(int i=0;i<reterpdef.getRowCount();i++)
			{
				defKey = reterpdef.getFieldValueString(i,USER_DEFAULT_KEY);
				if("SECTOR".equals(defKey))
				{
					defaultArea = reterpdef.getFieldValueString(i,USER_DEFAULT_VALUE);
					break;
				}
			}
			
			if(defaultArea.indexOf(",") != -1)
			{	
				StringTokenizer stoken = new StringTokenizer(defaultArea,",");
				while(stoken.hasMoreElements())
				{
					sectorData.addElement(stoken.nextToken());
				}
			}
			else
				sectorData.addElement(defaultArea);
		}
	}	
%>