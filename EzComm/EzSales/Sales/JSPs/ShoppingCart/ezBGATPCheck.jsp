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
		
	String atpForStr=request.getParameter("atpfor");
	int prdsLen =0;
	String selectedPrdsSplitArr[] = null;
	if(atpForStr!=null)
	{
		selectedPrdsSplitArr = atpForStr.split("§");
		prdsLen = selectedPrdsSplitArr.length;
	}
			
	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	String appendATP ="";
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
			
			if(prdsLen>0)
			{
				for(int i=0;i<prdsLen;i++)
				{
					String prodCode  =  selectedPrdsSplitArr[i].split("¥")[0];
					String prodQty   =  selectedPrdsSplitArr[i].split("¥")[1];										
					
					zMat.appendRow();
					zMat.setValue(prodCode,"MATERIAL");
					zMat.setValue(DateFrom,"REQ_DATE");
					zMat.setValue(prodQty,"REQ_QTY");
				}
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
					int indx = 0;
					do
					{							
						if(indx==0)
						{
							appendATP = atpResultTable.getValue("MATERIAL")+"¥"+eliminateDecimals((String)atpResultTable.getValue("AVAIL_QTY"));
						
						}
						else
						{
							appendATP = appendATP+"§"+atpResultTable.getValue("MATERIAL")+"¥"+eliminateDecimals((String)atpResultTable.getValue("AVAIL_QTY"));
						}
						indx++;
						
						//atpResultRet.setFieldValue("MATERIAL",atpResultTable.getValue("MATERIAL"));
						//atpResultRet.setFieldValue("AVAILQTY",atpResultTable.getValue("AVAIL_QTY"));
						//atpResultRet.addRow();  
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
	
	out.print(appendATP);
%>

<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";
		return ret;
	}
	
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>









