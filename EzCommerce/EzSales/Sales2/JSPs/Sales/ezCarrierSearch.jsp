<%@ page import ="ezc.ezparam.*" %>
<%
	ReturnObjFromRetrieve CarrierInfo= (ReturnObjFromRetrieve)application.getAttribute("CARRIER_INFO");
	//CarrierInfo.toEzcString();
	String carrierNo = request.getParameter("carrierNo");
	carrierNo 	 = (carrierNo.toUpperCase()).trim();
	String Status 	 = request.getParameter("Status");
	String xmlrep 	 = "";
	int rowCount 	 = CarrierInfo.getRowCount();
	boolean flag 	 = false;
	
	if("I".equals(Status))
	{
		for(int i=0;i<rowCount;i++)
		{
			String carrierNum = CarrierInfo.getFieldValueString(i,"CARR_NO");
			carrierNum = carrierNum.trim();
			if(carrierNum.startsWith(carrierNo))
			{
				xmlrep += "<strong><font size=2>"+carrierNum+"==></strong> <i>"+CarrierInfo.getFieldValueString(i,"CARR_NAME")+"</i></font><br>";				
			}
		}
	}
	else if("O".equals(Status))
	{
		for(int i=0;i<rowCount;i++)
		{
			String carrierNum = CarrierInfo.getFieldValueString(i,"CARR_NO");
			carrierNum = carrierNum.trim();
			if(carrierNum.equals(carrierNo) || "".equals(carrierNo))
			{				
				xmlrep="Success";
				flag = false;
				break;
			}
			else
			{
				flag = true;
			}			
		}
		if(flag)
		      xmlrep="NOTVALID";
	}
	if(xmlrep.length()==0)
		xmlrep="<strong><font size=2>No Match Found</font></strong>";			

	out.println(xmlrep);
%>