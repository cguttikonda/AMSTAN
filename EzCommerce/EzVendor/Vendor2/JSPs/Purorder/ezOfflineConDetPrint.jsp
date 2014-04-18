<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />

<%	
      //System.out.println("ezOfflineConDetPrint.jspezOfflineConDetPrint.jsp");
	String display_header ="";
	String type = "PDF"; 
	boolean showPDF=true;
	String agmtNo = request.getParameter("agmtNo");
	String vendor = request.getParameter("vendor");
	String Site=(String)session.getValue("Site");
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	EziPrintParams params= new EziPrintParams();
	params.setObjectType("CON");
	params.setObjectNo(agmtNo);
	params.setDocType(type);
	params.setVendor(vendor.trim());
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	javax.servlet.ServletOutputStream sos=null;
	
	try{
		if ("PDF".equals(type)){
		
			JCO.Client client1=null;
			 JCO.Function function = null;
			// javax.servlet.ServletOutputStream sos=null;
			 try
			 {
				 client1 = EzSAPHandler.getSAPConnection(Site+"~999");
				 function = EzSAPHandler.getFunction("Z_EZ_PRINT_DOCUMENT",Site+"~999");
				 JCO.ParameterList  printDetail = function.getImportParameterList();
				 JCO.Table tabList = null;
				 printDetail.setValue("EV","OBJTYPE");
				 printDetail.setValue(vendor,"VENDOR");
				 printDetail.setValue("P","DOCTYPE");
				 printDetail.setValue(agmtNo,"OBJNUMBER");
				try{
					client1.execute(function);
					byte Z_STRING[]= (function.getExportParameterList()).getByteArray("Z_STRING");
					
					if(Z_STRING!=null && Z_STRING.length > 10){
					
						response.setContentType("application/x-download");
						response.setHeader ("Content-Disposition", "attachment;filename="+agmtNo+".pdf");
						sos=response.getOutputStream();           
						sos.write(Z_STRING);
					}else{
						showPDF = false;
					}	
				}catch(Exception err){}

				ezc.ezcommon.EzLog4j.log("============>1234","I"); 
				ezc.ezcommon.EzLog4j.log("============>12345","I");
				ezc.ezcommon.EzLog4j.log("contract print====>123456","I");
				ezc.ezcommon.EzLog4j.log("agreement no ====>"+agmtNo,"I");
				ezc.ezcommon.EzLog4j.log("vendor====>"+vendor,"I");
			}catch(Exception e){}
			finally
			{
				   if (client1!=null)
				   {
					JCO.releaseClient(client1);
					client1 = null;
					function=null;
					sos.close();
				    }
		 	}
			/*ReturnObjFromRetrieve myTable=(ReturnObjFromRetrieve)ShManager.ezGetPrintVersion(mainParams);
			int rowCount=myTable.getRowCount();

			
				response.setContentType("application/x-download");
				response.setHeader ("Content-Disposition", "attachment;filename="+agmtNo+".pdf");

				ezc.ezsap.V46B.generated.ZrawtabTableRow myTableRow=null;
				sos=response.getOutputStream();	
				for(int i=0;i<rowCount;i++)
				{
					byte[] b=(byte[])myTable.getFieldValue(i,"OUTTAB");
					sos.write(b);
				}
			*/	
			
				
			
			
		}
	}
	catch(Exception e)
	{
		showPDF=false;
		
		

	}
	
	if(!showPDF){
	
	
%>	
			
			<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
			<%@ include file="../Misc/ezDisplayHeader.jsp"%>
			<br><br>
			
			<Table align=center><Tr><Td class=displayheader>Document could not be printed currently. Please try after some time</Td></Tr></Table><br><br>
			<br><br><Table align='center'><Tr><Td>Contact System Administrator for further Details.</Td></Tr></Table>
			<br><br>
			<Table align=center><Tr>
			<Td class="TDCommandBarBorder">
			    <table border="0" cellspacing="3" cellpadding="5">
			    <tr>		
			      <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:history.go(-1)" >
				     <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
			      </td>
			    </tr>
			    </table>
			    </td>
			</Tr></Table>
<%
	
	
	
	
	}
	
	if (sos!=null)
		sos.close();

%>

<Div id="MenuSol">

</Div>
