<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%	
	String atpSOr	=   (String)session.getValue("salesOrg");
	String atpDtc 	=   (String)session.getValue("dc");
	String atpDiv  	=   (String)session.getValue("division");
	String atpSTP   =   (String)session.getValue("AgentCode");
	String atpSHP	=   (String)session.getValue("ShipCode");
	String stAtpStr =   (String)session.getValue("shipState");
	String site_SC  = (String)session.getValue("Site");
			
	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","STATUS","UPC"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	
	
	float quantityREQ=1;

	if(prodCode!=null && !"null".equals(prodCode) && !"".equals(prodCode) )
	{				

		JCO.Client client=null;
		JCO.Function functionEx = null;
		
		
		String skey_SC = "998";

		Date dateFrom = new Date();
		
		try
		{
			functionEx 		  = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY",site_SC+"~"+skey_SC);
			JCO.ParameterList atpProc = functionEx.getImportParameterList();
			JCO.Table zMat 		  = functionEx.getTableParameterList().getTable("ZMATERIAL");

			atpProc.setValue(atpSOr,"SALES_ORGANIZATION");
			atpProc.setValue(atpDtc,"DISTRI_CHANNEL");
			atpProc.setValue(atpDiv,"DIVISON");
			atpProc.setValue(atpSTP,"KUNNR");
			atpProc.setValue(atpSHP,"KUNWE");
			atpProc.setValue(stAtpStr,"REGIO");
						
			zMat.appendRow();
			zMat.setValue(prodCode,"MATERIAL");
			zMat.setValue(dateFrom,"REQ_DATE");
			zMat.setValue(quantityREQ,"REQ_QTY");			

			
			try
			{
				client = EzSAPHandler.getSAPConnection(site_SC+"~"+skey_SC);
			}catch(Exception ce)
			{
				out.println(":::::::::::::::::::ce111::::::::::::::::::::"+ce);
			}
			
			try
			{
				
				client.execute(functionEx);
			}
			catch(Exception ec)
			{
				out.println(":::::::::::::::::::ec111::::::::::::::::::::"+ec);
			}

			JCO.Table atpResultTable = functionEx.getTableParameterList().getTable("RESULT");

			if(atpResultTable!=null)
			{				
				if (atpResultTable.getNumRows() > 0)
				{					
					do
					{						
						atpResultRet.setFieldValue("MATERIAL",atpResultTable.getValue("MATERIAL"));
						atpResultRet.setFieldValue("MATERIALDESC",atpResultTable.getValue("MFRPN"));
						atpResultRet.setFieldValue("AVAILQTY",atpResultTable.getValue("AVAIL_QTY"));
						atpResultRet.setFieldValue("PLANT",atpResultTable.getValue("PLANT"));												
						atpResultRet.setFieldValue("STATUS",atpResultTable.getValue("STATUS"));											
						atpResultRet.setFieldValue("UPC",atpResultTable.getValue("EAN11"));					
						atpResultRet.addRow();
					}
					while(atpResultTable.nextRow());
				}
			}						
		}
		catch(Exception e)
		{
			out.println("EXCEPTION>>>>>>"+e);
		}
		finally
		{
			if (client!=null)
			{
				JCO.releaseClient(client);
				client = null;
				functionEx=null;
			}
		}
	}	
	
 	int reqQtyIntC=0,retQtyIntC=0;
 	String atpAvailC="";
 	float atpRetQtyC=0;
 	
 	if(atpResultRet!=null && atpResultRet.getRowCount()>0)
 	{
 	
		atpRetQtyC = Float.parseFloat(atpResultRet.getFieldValueString(0,"AVAILQTY"));

		if(atpRetQtyC>=1)
			atpAvailC = "Y";
		else
			atpAvailC = "N";
	}
%>