<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*"%>
<%@ page import="ezc.ezparam.*" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" />

<%

	String msgSubject="";
	String msgText="";


	String fileName=request.getParameter("fileName");
	String isAttachments="N";

	String requestId=request.getParameter("requestId");
	String type=request.getParameter("Type");
	String refNum=request.getParameter("refDocNo");

	String sysKey=(String)session.getValue("SYSKEY");
        	String soldTo = (String)session.getValue("SOLDTO");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezvendorapp.params.EzMaterialResponseStructure struct =  new ezc.ezvendorapp.params.EzMaterialResponseStructure();

	Date d=new Date();
	SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
	String SysDate=sdf.format(d);
		struct.setRequestId(requestId);
       		struct.setSysKey(sysKey);
	       	struct.setSoldTo(soldTo);
	       	struct.setResponseBy(Session.getUserId());
	       	struct.setResponseDate(SysDate);
	       	struct.setResponseDesc(request.getParameter("details"));
		String price = request.getParameter("price");
		if(price==null)
		{
		   price="";
		}
	       	struct.setExt1(price);
	       	struct.setExt2(refNum);

		mainParams.setObject(struct);
		mainParams.setLocalStore("Y");
		Session.prepareParams(mainParams);
		AppManager.ezAddMaterialResponse(mainParams);

	      if(type.equals("N"))
	      {
		ezc.ezparam.EzcParams addDocMainParams = null;
		ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();

		java.util.StringTokenizer st = new java.util.StringTokenizer(fileName,"^");
		ezc.ezupload.params.EziUploadDocsParams addParams= null;
		ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;

		addDocMainParams = new ezc.ezparam.EzcParams(false);
		addParams= new ezc.ezupload.params.EziUploadDocsParams();
		addParams.setSysKey(sysKey);
		addParams.setObjectType("MATRESP");
		addParams.setObjectNo(requestId+soldTo+refNum);
		addParams.setStatus("");
		addParams.setCreatedOn(SysDate);
		addParams.setCreatedBy(Session.getUserId());
		addParams.setUploadDirectory(uploadTempDir+session.getId());
		addDocMainParams.setObject(addParams);

		if(!fileName.equals(""))
		{


		       String coa = st.nextToken();
		       coa = coa.substring(0,coa.indexOf("#"));
		       if(!coa.equals("-"))
		       {
				rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
				rowParams.setType("COA");
				rowParams.setClientFileName(coa);
				tabParams.appendRow(rowParams);
		       }

		       String stp = st.nextToken();
		       stp = stp.substring(0,stp.indexOf("#"));
		       if(!stp.equals("-"))
		       {
			 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
			 	rowParams.setType("STP");
			 	rowParams.setClientFileName(stp);
			 	tabParams.appendRow(rowParams);

		       }

		}

		addDocMainParams.setObject(tabParams);
		Session.prepareParams(addDocMainParams);
		UploadManager.uploadDoc(addDocMainParams);
	     }	

		msgSubject = "Material Response Posted";
		msgText = "This is a response to the material request posted by "+session.getValue("Vendor");

%>
<%@include file="../Materials/ezSendMail.jsp"%>

<html>
<head>
<title></title>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body bgcolor="#FFFFF7">
<br>
<br>
<br>
  <table width="50%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
  <tr align="center">
   	 <th>Thank you for responding to the Material Request.</th>
  </tr>
</table>
<br><br>
<center><a href="../Materials/ezListMaterialRequest.jsp?Type=<%=type%>"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none></center>
<Div id="MenuSol"></Div>
</body>
</html>
