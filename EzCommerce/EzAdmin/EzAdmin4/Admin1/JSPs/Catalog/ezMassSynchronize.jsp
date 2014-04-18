<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iMassSynchronize.jsp"%>
<%

	String SysKey = "ESKD_SYS_KEY";
	java.util.ArrayList sysKeys=new java.util.ArrayList();

	int rowCount=ret.getRowCount();
	for(int i=0;i<rowCount;i++)
	{
		sysKeys.add(ret.getFieldValueString(i,SysKey));
	}

	//out.println(sysKeys);
	//ezc.ezbasicutil.EzMaterialSynch synch=new ezc.ezbasicutil.EzMaterialSynch();
	//synch.doSynch(sysKeys,Session);
%>