<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="session">
</jsp:useBean>

<%
String FUNCTION = request.getParameter("FUNCTION");

if (FUNCTION == null)FUNCTION="AG";
FUNCTION = FUNCTION.trim();

String cTitle = (FUNCTION.equals("AG"))?"Customer":"Vendor";
String cFlag = (FUNCTION.equals("AG"))?"C":"V";

ReturnObjFromRetrieve retErpCust = null;

String DeleteCount = request.getParameter("TotalCount");
int delCount = 0;
if ( DeleteCount != null )delCount = (new Integer(DeleteCount)).intValue();

String Bus_Partner = request.getParameter("BusPartner");
boolean deleteError = false;
int delErrCnt = 0;
int areaCnt = 0;
int errRows = 0;

if ( Bus_Partner != null )
{

	Bus_Partner = Bus_Partner.trim();
	
	
	for( int x = 0; x < delCount; x++)
	{
		String pCheckBox = request.getParameter("CheckBox_"+x);
		
		if ( pCheckBox != null )
		{
			String areaKey = request.getParameter("AREA_"+x);
			if ( areaKey != null) areaKey = areaKey.trim();

		
			String ezPfCust = request.getParameter("ERPCUST_"+x);
			String ezErpCust = request.getParameter("EzcCustomer_"+x);
			if ( pCheckBox.equals("AG") || pCheckBox.equals("VN") )
			{
				ezErpCust = ezPfCust;
			}

			if ( ezErpCust != null ) ezErpCust = ezErpCust.trim();
			if ( ezPfCust != null ) ezPfCust = ezPfCust.trim();

		
			if ( areaKey != null && ezErpCust != null )
			{

				/*** Commented by Venkat on 6/1/2001
				EzcBussPartnerParams bparamsD = new EzcBussPartnerParams();
				EzcBussPartnerNKParams bnkparamsD = new EzcBussPartnerNKParams();
				bnkparamsD.setLanguage("EN");
				bnkparamsD.setSys_key(areaKey);	
				bnkparamsD.setErp_customer(ezErpCust);
				bnkparamsD.setPartnerNumber(ezPfCust);
				bnkparamsD.setPartnerFunc(pCheckBox);
				bparamsD.setBussPartner(Bus_Partner);
				bparamsD.setObject(bnkparamsD);
				Session.prepareParams(bparamsD);
				retErpCust = (ReturnObjFromRetrieve)BPManager.deleteEzcErpCustomer(bparamsD);
				//retErpCust.check();
				**/


				/************** Starts Here *************/
				EzCustomerStructure ecs = new EzCustomerStructure();
				ecs.setSysKey(areaKey);
				ecs.setErpSoldTo(ezErpCust);
				ecs.setPartnerNo(ezPfCust);
				ecs.setPartnerFunc(pCheckBox);
				ecs.setBussPartner(Bus_Partner);
				ecs.setLanguage("EN");



				/** Added by Venkat on 6/1/2001 **/
				if ( FUNCTION.equals("AG") )
				{
					EzcCustomerParams cparams = new EzcCustomerParams();
					//EzCustomerParams  cnkparams = new EzCustomerParams();
					//cnkparams.setLanguage("EN");
					//cnkparams.setEzCustomerStructure(ecs);
					cparams.setObject(ecs);
					Session.prepareParams(cparams);
					ezc.ezutil.EzSystem.out.println("Before Calling deleteCustomerPartnerFunctions");
					retErpCust = (ReturnObjFromRetrieve) CustomerManager.deleteCustomerPartnerFunctions(cparams); 
					ezc.ezutil.EzSystem.out.println("After Calling deleteCustomerPartnerFunctions>>"+retErpCust);
		
				}
				else
				{

					EzcVendorParams vparams = new EzcVendorParams();
					//EzVendorParams  vnkparams = new EzVendorParams();
					//vnkparams.setLanguage("EN");
					//vnkparams.setEzCustomerStructure(ecs);
					vparams.setObject(ecs);
					Session.prepareParams(vparams);
					
					ezc.ezutil.EzSystem.out.println("Before Calling deleteVendorPartnerFunctions");
					retErpCust = (ReturnObjFromRetrieve) VendorManager.deleteVendorPartnerFunctions(vparams); 
					ezc.ezutil.EzSystem.out.println("After Calling deleteVendorPartnerFunctions");
		
				}
				/** Changes end here **/
				
				ezc.ezutil.EzSystem.out.println("value:"+retErpCust.isError());
				if ( retErpCust.isError() )
				{
				        deleteError = true;
					errRows = retErpCust.getRowCount();
					out.println("<br>");
					out.println("<br>");
					out.println("<div align=\"center\">");
					out.println("<table>");
					out.println("<tr>");
					out.println("<th>Delete was not successfull for "+areaKey+"</th>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<th>Following users are assigned to this area</th>");
					out.println("</tr>");
					for (int j = 0; j < errRows; j++)
					{
						String uId = retErpCust.getFieldValueString(j,"EU_ID");
						ezc.ezutil.EzSystem.out.println("uId:"+uId+":");
						out.println("<tr><td align=\"center\">"+uId.trim()+"</td></tr>");
					}
					out.println("</table>");
					out.println("</div>");

%>
					
<%
				}
			 } //end if areaKey
		
		} //end pCheckBox != null
	} //end for
	
	if ( deleteError )
	{
		out.println("<div align=\"center\" >");
		//out.println("<input type=\"button\" name=\"back\" value=\"Back\" onClick=\"history.back()\">");
		out.println("<a href=\"ezBPDelCustSync.jsp?BusinessPartner="+Bus_Partner+"&FUNCTION="+FUNCTION+"\">Click Here to go to Delete Sync</a>");
		out.println("</div>");
	}
} //end if
%>