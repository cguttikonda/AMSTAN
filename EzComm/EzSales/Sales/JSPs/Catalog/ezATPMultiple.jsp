<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%	
	String atpSOrATP	=   (String)session.getValue("salesOrg");
	String atpDtcATP	=   (String)session.getValue("dc");
	String atpDivATP  	=   (String)session.getValue("division");
	String atpSTPATP   	=   (String)session.getValue("AgentCode");
	String atpSHPATP	=   (String)session.getValue("ShipCode");
	String stAtpStrATP 	=   (String)session.getValue("shipState");
					
	HashMap atpMultHM = new HashMap();
	float quantityREQATP=1;
	
	if(prodCodesAL!=null && prodCodesAL.size()>0 )
	{				
		JCO.Client client=null;
		JCO.Function functionEx = null;
		
		String site_SC = (String)session.getValue("Site");
		String skey_SC = "998";
		Date dateFrom = new Date();		
		
		try
		{
			functionEx 		  = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY",site_SC+"~"+skey_SC);
			JCO.ParameterList atpProc = functionEx.getImportParameterList();
			JCO.Table zMat 		  = functionEx.getTableParameterList().getTable("ZMATERIAL");

			atpProc.setValue(atpSOrATP,"SALES_ORGANIZATION");
			atpProc.setValue(atpDtcATP,"DISTRI_CHANNEL");
			atpProc.setValue(atpDivATP,"DIVISON");
			atpProc.setValue(atpSTPATP,"KUNNR");
			atpProc.setValue(atpSHPATP,"KUNWE");
			atpProc.setValue(stAtpStrATP,"REGIO");
			
			String prodMulAtp = "";
			for(int i=0;i<prodCodesAL.size();i++)
			{
				prodMulAtp = (String)prodCodesAL.get(i);
				zMat.appendRow();
				zMat.setValue(prodMulAtp,"MATERIAL");
				zMat.setValue(dateFrom,"REQ_DATE");
				zMat.setValue(quantityREQATP,"REQ_QTY");		
			}
			
			try
			{
				client = EzSAPHandler.getSAPConnection(site_SC+"~"+skey_SC);
				client.execute(functionEx);
			}
			catch(Exception ec)
			{
				//out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
			}

			JCO.Table atpResultTable = functionEx.getTableParameterList().getTable("RESULT");						
			
			String atpProdCode = "";
			String atpProdAvlb = "";
 			
			if(atpResultTable!=null)
			{				
				if (atpResultTable.getNumRows() > 0)
				{					
					do
					{						
						atpProdCode = (String)atpResultTable.getValue("MATERIAL");
						atpProdAvlb = (String)atpResultTable.getValue("AVAIL_QTY");
												
						try{
						        atpProdCode = Long.parseLong(atpProdCode)+"";
						}catch(Exception e){
							atpProdCode = atpProdCode;
						}
													
    						atpMultHM.put(atpProdCode,atpProdAvlb);
    						
					}
					while(atpResultTable.nextRow());
				}
			}						
		}
		catch(Exception e)
		{
			//out.println("EXCEPTION>>>>>>"+e);
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
%>