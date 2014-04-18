<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%
	
	String stAtpStr  = request.getParameter("stAtp");
		
	if("null".equals(stAtpStr) || stAtpStr==null)
		stAtpStr="";	
	
	String atpSTP	=   request.getParameter("selSoldTo");
	if(atpSTP==null || "null".equals(atpSTP))
		atpSTP=(String)session.getValue("AgentCode");
		
	String atpSHP	=   (String)session.getValue("ShipCode");
	String atpDiv  	=   (String)session.getValue("division");
	String atpDtc 	=   (String)session.getValue("dc");
	String atpSOr	=   (String)session.getValue("salesOrg");
		
	String atpion=request.getParameter("atpon");
		
	String atpForStr = request.getParameter("atpfor");	
	if(atpForStr==null || "null".equals(atpForStr) || "".equals(atpForStr))
		atpForStr="1234";
		
	String atpQtyStr = request.getParameter("atpqty");
	if(atpQtyStr==null || "null".equals(atpQtyStr))
		atpQtyStr="";
		
	String atpForStrArr[] = request.getParameterValues("atpfor");	
	String atpQtyStrArr[] = request.getParameterValues("atpqty");
		
	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","STATUS","UPC","ENDLEADTIME"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	
	String atpColZMat[]={"MATERIAL","REQQTY"};
	ReturnObjFromRetrieve atpZMaterialRet = new ReturnObjFromRetrieve(atpColZMat);
	
	HashMap zMatHM = new HashMap();
	
	ReturnObjFromRetrieve  soldTosSesGet = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	ReturnObjFromRetrieve  statesSesGet  = (ReturnObjFromRetrieve)session.getValue("retAtpStateObj_ses");	
	
	if(atpForStr!=null && !"null".equals(atpForStr) && !"".equals(atpForStr))
	{				

		DateFormat formatter1;
		Date DateFrom = new Date();
		formatter1 = new SimpleDateFormat("MM/dd/yyyy");

		DateFrom = (Date)formatter1.parse(atpion); 

		JCO.Client client=null;
		JCO.Function functionEx = null;	

		String site_S = (String)session.getValue("Site");
		String skey_S = "998";

		try
		{
			functionEx 		  = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY",site_S+"~"+skey_S);
			JCO.ParameterList atpProc = functionEx.getImportParameterList();
			JCO.Table zMat 		  = functionEx.getTableParameterList().getTable("ZMATERIAL");

			atpProc.setValue(atpSOr,"SALES_ORGANIZATION");
			atpProc.setValue(atpDtc,"DISTRI_CHANNEL");
			atpProc.setValue(atpDiv,"DIVISON");
			atpProc.setValue(atpSTP,"KUNNR");
			atpProc.setValue(atpSHP,"KUNWE");
			atpProc.setValue(stAtpStr,"REGIO");
			
			if(atpForStrArr!=null && atpForStrArr.length>0)
			{
				for(int i=0;i<atpForStrArr.length;i++)
				{					
					zMat.appendRow();
					zMat.setValue(atpForStrArr[i],"MATERIAL");
					zMat.setValue(DateFrom,"REQ_DATE");
					zMat.setValue(atpQtyStrArr[i],"REQ_QTY");
				}
			}			
			else
			{
					zMat.appendRow();
					zMat.setValue(atpForStr,"MATERIAL");
					zMat.setValue(DateFrom,"REQ_DATE");
					zMat.setValue(atpQtyStr,"REQ_QTY");			
			}

			try
			{
				client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
				client.execute(functionEx);
			}
			catch(Exception ec)
			{
				out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
			}

			JCO.Table atpResultTable = functionEx.getTableParameterList().getTable("RESULT");
			JCO.Table atpZMatTable 	 = functionEx.getTableParameterList().getTable("ZMATERIAL");

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
						atpResultRet.setFieldValue("ENDLEADTIME",atpResultTable.getValue("ENDLEADTME"));	
						atpResultRet.addRow();  
					}
					while(atpResultTable.nextRow());
				}
			}
			
			if(atpZMatTable!=null)
			{				
				if (atpZMatTable.getNumRows() > 0)
				{					
					do
					{											
						atpZMaterialRet.setFieldValue("MATERIAL",atpZMatTable.getValue("MATERIAL"));
						atpZMaterialRet.setFieldValue("REQQTY",atpZMatTable.getValue("REQ_QTY"));											
						atpZMaterialRet.addRow();
						
						zMatHM.put(atpZMatTable.getValue("MATERIAL"),atpZMatTable.getValue("REQ_QTY"));
					}
					while(atpZMatTable.nextRow());
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
%>