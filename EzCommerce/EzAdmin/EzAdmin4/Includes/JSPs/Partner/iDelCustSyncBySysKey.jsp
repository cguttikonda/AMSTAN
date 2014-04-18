<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="session"></jsp:useBean>
<%
	String FUNCTION = request.getParameter("FUNCTION");
	String Area =request.getParameter("Area");
	String websyskey=request.getParameter("WebSysKey");
	String buspar=request.getParameter("BusParCompName");

	// Added the below line by satya on 21012005
	String customerNo = request.getParameter("aEzcNo");

	if (FUNCTION == null)
		FUNCTION="AG";
	FUNCTION = FUNCTION.trim();

	String cTitle = (FUNCTION.equals("AG"))?"Customer":"Vendor";
	String cFlag = (FUNCTION.equals("AG"))?"C":"V";

	ReturnObjFromRetrieve retErpCust = null;
	String Bus_Partner = request.getParameter("BusinessPartner");

	boolean deleteError = false;
	int delErrCnt = 0;
	int areaCnt = 0;
	int errRows = 0;
	if ( Bus_Partner != null )
	{
		Bus_Partner = Bus_Partner.trim();
		String pCheckBox[] = request.getParameterValues("CheckBox");
		String myFunc=null;
		String areaKey =null;
		String ezPfCust =null;
		String ezErpCust = null;
		StringTokenizer myTokenizer=null;
		if(pCheckBox!=null)
		{
			for(int i=0;i<pCheckBox.length;i++)
			{
				myTokenizer=new StringTokenizer(pCheckBox[i],"###");
				myFunc=myTokenizer.nextToken();
				ezPfCust=myTokenizer.nextToken();
				ezErpCust=myTokenizer.nextToken();
				areaKey=myTokenizer.nextToken();
				if ( myFunc.equals("AG") || myFunc.equals("VN") )
				{
					ezErpCust = ezPfCust;
				}
				EzCustomerStructure ecs = new EzCustomerStructure();

				// Modified the below lines by satya on 21012005
				ecs.setSysKey(areaKey);
				//ecs.setSysKey(areaKey +"' and EC_NO = '"+customerNo);
				// Modifications completed by satya

				ecs.setErpSoldTo(ezErpCust);
				ecs.setPartnerNo(ezPfCust);
				ecs.setPartnerFunc(myFunc);
				ecs.setBussPartner(Bus_Partner);
				ecs.setLanguage("EN");
				if ( FUNCTION.equals("AG") )
				{
					EzcCustomerParams cparams = new EzcCustomerParams();
					cparams.setObject(ecs);
					Session.prepareParams(cparams);
					retErpCust = (ReturnObjFromRetrieve) CustomerManager.deleteCustomerPartnerFunctions(cparams);
				}
				else
				{
					EzcVendorParams vparams = new EzcVendorParams();
					vparams.setObject(ecs);
					Session.prepareParams(vparams);
					retErpCust = (ReturnObjFromRetrieve) VendorManager.deleteVendorPartnerFunctions(vparams);
				}
				if ( retErpCust.isError() )
				{
					deleteError = true;
					errRows = retErpCust.getRowCount();
%>
					<br><br><br><br>
					<Table >
					<Tr>
						<Th>Delete was not successfull for <%=areaKey%></Th>
					</Tr>
					<Tr>
						<Th>Following users are assigned to this area</Th>
					</Tr>
<%
					for (int j = 0; j < errRows; j++)
					{
						String uId = retErpCust.getFieldValueString(j,"EU_ID");
%>
						<Tr><Td align="center"><%=uId.trim()%></Td></Tr>
<%
					}
%>
					</Table>
<%
				}
			}
		}
		if (deleteError)
		{
%>
			<div align="center">
			<a href="ezBPDelCustSync.jsp?BusinessPartner=<%=Bus_Partner%>&FUNCTION=<%=FUNCTION%>" Click Here to go to Delete Sync</a>
			</div>
<%
		}
	}
%>