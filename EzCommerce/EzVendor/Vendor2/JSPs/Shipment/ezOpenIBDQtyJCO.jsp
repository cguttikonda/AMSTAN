<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<%

	java.util.Hashtable openIBDItemsHT = new java.util.Hashtable();
	String site = (String)session.getValue("Site");
	//out.println("site::"+site);
	JCO.Client client=null;
	JCO.Function function = null;
	try
	{
			client = EzSAPHandler.getSAPConnection(site+"~999");
			function = EzSAPHandler.getFunction("BBP_INBD_CREATE_PO_GETITEMS");
			JCO.ParameterList impParam = function.getImportParameterList();


			impParam.setValue(soldTo,"IF_VENDOR");
			impParam.setValue(ponum,"IF_PO_NUMBER");
			
			ezc.ezcommon.EzLog4j.log("soldTo::::::"+soldTo,"I");
			ezc.ezcommon.EzLog4j.log("poNum::::::"+ponum,"I");
     

			try
			{
				client.execute(function);
				EzSAPHandler.commit(client);
				ezc.ezcommon.EzLog4j.log("client executed::::::","I");
			}
			catch(Exception e)
			{
				ezc.ezcommon.EzLog4j.log("Exception::::::"+e,"I");
			}


			JCO.Table retTable = function.getTableParameterList().getTable("ET_INB_D_CREATE_PO_DETAIL");
			int retCoun         = retTable.getNumRows();
			ezc.ezcommon.EzLog4j.log("retTable=="+retTable+"==retCoun=="+retCoun,"I");

			if(retCoun > 0)
			{
				do
				{
					String itemNo            =  (String)retTable.getValue("PO_ITEM");
					String itemOpenQty       =  (String)retTable.getValue("DELIV_QTY");
					String itemNoStr	 =  Integer.parseInt(itemNo)+"";
					
					ezc.ezcommon.EzLog4j.log("::itemNo::"+itemNo,"I");
					ezc.ezcommon.EzLog4j.log("::itemOpenQty::"+itemOpenQty+"::"+itemNoStr,"I");

					openIBDItemsHT.put(itemNoStr,itemOpenQty);
					
					//out.println(itemNo+":::"+openIBDItemsHT.get(itemNoStr));
				}
				while(retTable.nextRow());
			}
	}
	catch(Exception e){
			ezc.ezcommon.EzLog4j.log(">>>>>>>>>EXCEPTION--BBP_INBD_CREATE_PO_GETITEMS>>>>>>>>>>"+e,"I");
	}
	finally
	{
			if(client!=null)
			{
					ezc.ezcommon.EzLog4j.log(".........RELEASING CLIENT........","I");
					JCO.releaseClient(client);
					client = null;
					function=null;

			}
	}

	//ezc.ezcommon.EzLog4j.log(">>>>>>>>>OPEN IBD ITEMS>>>>>>>>>>"+openIBDItemsHT,"I");
	ezc.ezcommon.EzLog4j.log("::openIBDItemsHT::"+openIBDItemsHT,"I");
%>
