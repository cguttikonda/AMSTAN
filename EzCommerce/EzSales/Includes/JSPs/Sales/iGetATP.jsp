
<%@ page import="ezc.sales.material.params.*" %>
<%@ page import= "ezc.ezbasicutil.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" scope="session"></jsp:useBean>
<%
String ProductNumber =request.getParameter("ProductCode");
String ProdDesc =request.getParameter("ProdDesc");
String UOM =  request.getParameter("UOM");
String itemNumber = request.getParameter("itemNumber");
String RQty = request.getParameter("ReqQty");
String RDate =request.getParameter("ReqDate");
String plant =request.getParameter("plant");



java.util.GregorianCalendar reqDateG =null;

EzcMaterialParams ezMatParams = new EzcMaterialParams();
EziMaterialParams eiMatParams = new EziMaterialParams();


EzBapiwmdvsTable InputTable = new EzBapiwmdvsTable();
String[] ReqQty = new String[10];
String[] ReqDate = new String[10];

//for edit
if(!(("null".equals(itemNumber))||(itemNumber==null)))
{
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");

	int z=0;
	for(int i=0;i<ret.getRowCount();i++)
	{
		if(ret.getFieldValueString(i,"EZDS_ITM_NUMBER").equals(itemNumber))
		{
		 	ReqQty[z] =ret.getFieldValueString(i,"EZDS_REQ_QTY");
		 	ReqDate[z] = ret.getFieldValueString(i,"EZDS_REQ_DATE");
		 	if((!( (ReqQty[z] == null) || (ReqQty[z].trim().length() ==0))) && (!( (ReqDate[z] == null) || ("null".equals(ReqDate[z]) ) )))
			{
				EzBapiwmdvsTableRow InputTableRow = new EzBapiwmdvsTableRow();

				int dt = Integer.parseInt(ReqDate[z].substring(0,2));
				int mn = Integer.parseInt(ReqDate[z].substring(3,5));
				int yr = Integer.parseInt(ReqDate[z].substring(6,10));
				reqDateG = new java.util.GregorianCalendar(yr,mn-1,dt);
				InputTableRow.setReqDate(reqDateG.getTime());
				InputTableRow.setReqQty( new java.math.BigDecimal(ReqQty[z]) ); 
				InputTable.appendRow(InputTableRow);
			}
			z++;
		}
	}
	
	//for edit end 
}else{
	EzStringTokenizer rq = new EzStringTokenizer(RQty,"@@");
	EzStringTokenizer rd = new EzStringTokenizer(RDate,"@@");
	int rCount =rq.getTokens().size();
	try{
		for(int j=0;j <rCount ;j++)
		{
			ReqQty[j] = (String)rq.getTokens().elementAt(j);
			ReqDate[j] = (String)rd.getTokens().elementAt(j);
			if((!("0".equals(ReqDate[j])))&&(!("0".equals(ReqQty[j]))))
			{
				EzBapiwmdvsTableRow InputTableRow = new EzBapiwmdvsTableRow();
				
				int mn = Integer.parseInt(ReqDate[j].substring(0,2));
				int dt = Integer.parseInt(ReqDate[j].substring(3,5));
				int yr = Integer.parseInt(ReqDate[j].substring(6,10));
				reqDateG = new java.util.GregorianCalendar(yr,mn-1,dt);
				InputTableRow.setReqDate(reqDateG.getTime());
				InputTableRow.setReqQty( new java.math.BigDecimal(ReqQty[j]) ); 
				InputTable.appendRow(InputTableRow);
			}

		}
	}catch(Exception e)
	{
	}
}


eiMatParams.setMaterial(ProductNumber);
eiMatParams.setUnit(UOM);
eiMatParams.setPlant(plant);
//eiMatParams.setCheckRule("01");
eiMatParams.setCheckRule("");
eiMatParams.setWmdvsx(InputTable);
ezMatParams.setObject(eiMatParams);
Session.prepareParams(ezMatParams);  

System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
EzoMaterialParams eoMatParams = (EzoMaterialParams) EzcMaterialManager.getMaterialAvailability(ezMatParams);
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
ReturnObjFromRetrieve Return = (ReturnObjFromRetrieve) eoMatParams.getReturn();
ReturnObjFromRetrieve OutputTable = (ReturnObjFromRetrieve) eoMatParams.getMdve();
//Return.toEzcString();
//OutputTable.toEzcString();
%>