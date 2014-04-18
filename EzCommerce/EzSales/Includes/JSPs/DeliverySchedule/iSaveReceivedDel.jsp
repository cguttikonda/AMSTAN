<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezdispatch.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="DispInfoManager" class="ezc.ezdispatch.client.EzDispatchInfoManager" scope="page" />


<%
	String SoNo=request.getParameter("SoNum");
	String sysKey =(String)session.getValue("SalesAreaCode");
	EzcParams ezcParams = new EzcParams(true);
	ezcParams.setLocalStore("Y");

	EzDispInfoHeaderStruct inStructHeader = new EzDispInfoHeaderStruct();
	String role=(String)session.getValue("UserRole");
	/*String recBy="";
	if ("CU".equals(role))
		recBy="AG";
	else if ("AG".equals(role))
		recBy="AG";
	else if ("CM".equals(role))
		recBy="AG";

	inStructHeader.setExt2(recBy); //The role of the Goods Received Person
	*/
	if(recdate!=null)
	{
		Date fromDate = new Date();
		fromDate.setDate(Integer.parseInt(recdate.substring(3,5)));
		fromDate.setMonth(Integer.parseInt(recdate.substring(0,2))-1);
		fromDate.setYear(Integer.parseInt(recdate.substring(6,10))-1900);
		recdate =fromDate.getDate()+"/"+(fromDate.getMonth()+1)+"/"+(fromDate.getYear()+1900);
	}	

	inStructHeader.setDelvNo(delno);
	inStructHeader.setStatus("R");
	inStructHeader.setGoodsReceived(recdate);

	ezcParams.setObject(inStructHeader);

	EzDispInfoLinesTable  table = new EzDispInfoLinesTable();
	EzDispInfoLinesStruct inStructLines = null;

	String lineNo="";
	String qty="";
	String remarks="";
	for(int k=0;k<count;k++)
	{
		inStructLines=new EzDispInfoLinesStruct();
		lineNo = request.getParameter("lineno_"+k);
		qty = request.getParameter("recQty_"+k);
		remarks= request.getParameter("Rem_"+k);
		if (remarks==null)
			remarks="None";
		else
	                remarks=remarks;
		
		inStructLines.setDelvNo(delno);
		inStructLines.setLineNr(lineNo);
		inStructLines.setReceipts(qty);
		inStructLines.setRemarks(remarks);
		table.insertRow(k,inStructLines);
	}

	ezcParams.setObject(table);
	Session.prepareParams(ezcParams);

	DispInfoManager.ezUpdateDispatchInfo(ezcParams);

	String MasgTxt="\nFor Delivery No:"+delno+"\n";
	MasgTxt=MasgTxt+"Materials Received In good Condition.\n";



		String template=(String)session.getValue("Templet");
		String group=(String)session.getValue("UserGroup");
		String userRole = (String)session.getValue("UserRole");
		String catalog_area=(String)session.getValue("SalesAreaCode");
		String status="R";
		Vector superior=new Vector();
		superior.addElement("-1");
		superior.addElement("-2");
		superior.addElement("-3");


	//EzDispatchMails mail = new EzDispatchMails(Session,role,sysKey,MasgTxt," ",SoNo);
	//EzRanDispatchMails mail=new EzRanDispatchMails(Session,template,catalog_area,userRole,status,MasgTxt," ",SoNo,superior);
	//mail.ezSendMail();

	session.putValue("EzMsg","Dispatch has been Acknowledged successfully.");
%>

<script>
	document.location.replace("../Misc/ezOutMsg.jsp"); 
</script>
