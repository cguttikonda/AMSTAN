<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezcommon.*,ezc.ezparam.*" %>
<%@ page import ="ezc.sales.local.params.*,ezc.client.*" %>
<%@ page import = "ezc.ezdispatch.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import="ezc.drl.util.*" %>
<jsp:useBean id="chk" class="ezc.ezbasicutil.EzReplace" />
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<jsp:useBean id="dispInfoManager" class="ezc.ezdispatch.client.EzDispatchInfoManager" scope="page" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	String soNo = request.getParameter("soNo");
	String soldTo = request.getParameter("soldTo");
	String sysKey =(String)session.getValue("SalesAreaCode");
	String UserRole =(String)session.getValue("UserRole");

	String createdBy="";		//Getting from the SalesOrder Details in Local DB
	String webNo="";		//Getting from the SalesOrder Details in Local DB

	//To get CreatedBy& WebOrderNo  if the SalesOrder is a WebSalesOrder

	ReturnObjFromRetrieve mainRet = null;
	ReturnObjFromRetrieve retHeader = null;
	ReturnObjFromRetrieve sdHeader = null;

	EzcSalesOrderParams ezcSOParams = new EzcSalesOrderParams();
	ezcSOParams.setLocalStore("Y");
	EziSalesOrderStatusParams iSOStatusParams = new EziSalesOrderStatusParams();
	EziSalesHeaderParams iSOHeader = new EziSalesHeaderParams();
	EzSalesOrderStructure SOStrut = new EzSalesOrderStructure();

	iSOHeader.setType("");
	iSOHeader.setCol("SalesOrder");
	iSOHeader.setDocNumber(soNo);
	iSOHeader.setBackEndNumber(soNo);
	iSOHeader.setSoldTo("'"+soldTo+"'");
	iSOHeader.setSalesArea(sysKey);
	
	ezcSOParams.setObject(iSOStatusParams);
	ezcSOParams.setObject(iSOHeader);
	ezcSOParams.setObject(SOStrut);
	Session.prepareParams(ezcSOParams);

	EzoSalesOrderStatus soStatus  = (EzoSalesOrderStatus) EzSalesOrderManager.ezSalesOrderStatus(ezcSOParams);
	mainRet = soStatus.getReturn();
	try{
		retHeader 	= (ReturnObjFromRetrieve) mainRet.getObject("SALES_HEADER");
		sdHeader 	= (ReturnObjFromRetrieve) retHeader.getObject("SdHeader");
		webNo		= sdHeader.getFieldValueString(0,"WEB_ORNO");
		createdBy	= sdHeader.getFieldValueString(0,"CREATE_USERID");
	}catch(Exception e)
	{	//If it is not a WebOrder
		ezc.client.EzcUtilManager UtilManagerone = new ezc.client.EzcUtilManager(Session);
		String billto=UtilManagerone.getUserDefErpBillTo();
		try{
			billto = String.valueOf(Integer.parseInt(billto));
		}catch(Exception e1){}
		createdBy=billto;
		webNo="N/A";
	}
/*
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	
	//Code Ends here


	FormatDate fd = new FormatDate();

	EzcParams ezcParams = new EzcParams(true);
	ezcParams.setLocalStore("Y");

	String sDate = request.getParameter("sDate");
	String poNo = chk.setReplace(request.getParameter("poNo"));
	String delvNo = request.getParameter("delvNo");
	String delvDate = request.getParameter("delvDate");
	String dcNo = request.getParameter("dcNo");
	String dcDate = request.getParameter("dcDate");
	String invNo = " ";	//request.getParameter("invNo");
	String invDate = "21.04.2006"; //request.getParameter("invDate");
	String lrRrAirNo = request.getParameter("lrRrAirNo");
	
	String shipDate = request.getParameter("shipDate");
	
	int mm=Integer.parseInt(shipDate.substring(0,2));
	int dd=Integer.parseInt(shipDate.substring(3,5));
	int yy=Integer.parseInt(shipDate.substring(6,10));
	
	shipDate = dd+"."+mm+"."+yy;
	
	String carName = request.getParameter("carName");
	String arrDate = request.getParameter("arrDate");
	
	mm=Integer.parseInt(arrDate.substring(0,2));
	dd=Integer.parseInt(arrDate.substring(3,5));
	yy=Integer.parseInt(arrDate.substring(6,10));
		
	arrDate = dd+"."+mm+"."+yy;

	String status = "D"; // Hardcoded for LF.
	String shipTo = request.getParameter("shipTo");

	String createdOn = fd.getStringFromDate(new Date(),".",fd.DDMMYYYY);
	String lastModOn = createdOn;
	String HeaderText =request.getParameter("HeadText");
	HeaderText=chk.setReplace(HeaderText);
////  ADD HEADER
	EzDispInfoHeaderTable htable=new EzDispInfoHeaderTable();

	EzDispInfoHeaderStruct inStructHeader = new EzDispInfoHeaderStruct();

	inStructHeader.setDelvNo(delvNo);
	inStructHeader.setDcNr(dcNo);
	inStructHeader.setDcDate(dcDate);
	inStructHeader.setSoNum(soNo);
	inStructHeader.setSoDate(sDate);
	inStructHeader.setInvNum(invNo);
	inStructHeader.setInvDate(invDate);
	inStructHeader.setCreatedBy(createdBy);
	inStructHeader.setCreatedOn(createdOn);
	inStructHeader.setLastModOn(lastModOn);
	inStructHeader.setLrRrAirNo(lrRrAirNo);
	inStructHeader.setShipDate(shipDate);
	inStructHeader.setCarrier(carName);
	inStructHeader.setExpArrTime(arrDate);
	inStructHeader.setStatus(status);
	inStructHeader.setSoldTo(soldTo);
	inStructHeader.setShipTo(shipTo);
	inStructHeader.setSysKey(sysKey);
	inStructHeader.setGoodsReceived(createdOn);   /// Please note:: If CreatedOn and GoodsReceived on are same then it means that the goods are not yet received.
	inStructHeader.setExt1(webNo);	 //WebOrder No
	inStructHeader.setExt2(poNo); 	//PurchaseOrder No
	inStructHeader.setHeaderText(HeaderText);
	htable.insertRow(0,inStructHeader);

	ezcParams.setObject(htable);

	EzDispInfoLinesTable table=new EzDispInfoLinesTable();
	EzDispInfoLinesStruct inStructLines =null;

	String  lines= request.getParameter("totLines");
	int totLines = 0;

	if (lines!=null)
		totLines = Integer.parseInt(lines);

	String lineNo = null;
	String matCode = null;
	String matDesc = null;
	String uom = null;
	String qty = null;
	String plant = null;
	String batch = null;
	String ext = null;
	String refLine=null;
	String MsgStr="DC No:"+dcNo+"\n"+"LR/RR/AIR Bill No:"+ lrRrAirNo+"\n"+"Carrier Name:"+carName+"\n";
	MsgStr=MsgStr+"Expected Arrival Date:"+arrDate+"\n\n";

	MsgStr=MsgStr+"Line\t\t\tMatDesc\t\t\tQty\tUOM\n";
	MsgStr=MsgStr+"------------------------------------------------------------"+"\n";
	for(int i=0;i<totLines;i++)
	{
		inStructLines=new EzDispInfoLinesStruct();

		lineNo = request.getParameter("Line_"+i);
		matCode = request.getParameter("Material_"+i);
		matDesc = request.getParameter("Material_Desc_"+i);
		uom = request.getParameter("UOM_"+i);
		qty = request.getParameter("QTY_"+i);
		plant = request.getParameter("Plant_"+i);
		batch = request.getParameter("Batch_"+i);
		ext = request.getParameter("EXT_"+i);
		refLine = request.getParameter("RefLine_"+i);
		MsgStr=MsgStr+lineNo+"\t"+matDesc+"\t\t"+qty+"\t"+uom+"\n";
		inStructLines.setDelvNo(delvNo);
		inStructLines.setLineNr(lineNo);
		inStructLines.setMatNr(matCode);
		 matDesc= matDesc.replace('\'','`');
		inStructLines.setMatDesc(matDesc);
		inStructLines.setUOM(uom);
		inStructLines.setQtyShipped(qty);
		inStructLines.setReceipts("0");
		inStructLines.setPlant(plant);
		inStructLines.setBatchNo(batch);
		inStructLines.setRefNo(ext);
		inStructLines.setRefLineNo(refLine);
		inStructLines.setRemarks(" ");
		inStructLines.setExt1(" ");
		inStructLines.setExt2(" ");
		table.insertRow(i,inStructLines);
	}
	ezcParams.setObject(table);
	Session.prepareParams(ezcParams);
	
	
	
	
	dispInfoManager.ezAddDispatchInfo(ezcParams);
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>>");
	
	String template=(String)session.getValue("Templet");
	String group=(String)session.getValue("UserGroup");
	String userRole = (String)session.getValue("UserRole");
	String catalog_area=(String)session.getValue("SalesAreaCode");
	 status="D";
	 Vector subordinates=new Vector();
	 subordinates.addElement("1");
	 subordinates.addElement("2");
	 subordinates.addElement("3");

	//EzDispatchMails mail = new EzDispatchMails(Session,UserRole,sysKey,MsgStr,createdBy,soNo);
	//EzRanDispatchMails mail=new EzRanDispatchMails(Session,template,catalog_area,userRole,status,MsgStr,createdBy,soNo,subordinates);
	//mail.ezSendMail();
*/	
	session.putValue("EzMsg","Dispatch Info. have been Added succesfully");
%>
<script>
	document.location.replace("../Misc/ezOutMsg.jsp"); //remove top by kp
</script>



