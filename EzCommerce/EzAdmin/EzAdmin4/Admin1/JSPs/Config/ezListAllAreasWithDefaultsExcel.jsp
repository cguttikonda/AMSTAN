<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListAllAreasWithDefaults.jsp"%>
<%
	if(defRet!=null)
	{
		Vector columns=new Vector();
		for(int i=0;i<defRet.getColumnCount();i++)
		columns.add(defRet.getFieldName(i));
		String fileName=("AC".equals(areaFlag))?"Ezc_SalesAreas.xls":"Ezc_VendorAreas.xls";
		ezc.ezbasicutil.EzExcelDriver ed=new ezc.ezbasicutil.EzExcelDriver();

		try
		{
			ed.ezCreateExcel(fileName,"Sheet1",response,defRet,columns);
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e.getMessage());
		}
	}
%>

