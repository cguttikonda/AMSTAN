<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iJaxpPath.jsp" %>
<%@ page import="java.util.*" %>

<%@ page import="java.text.*,javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>


<%
	String sysKey="";

	/*ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
	ezc.ezparam.ReturnObjFromRetrieve retUsers = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
        for(int i=0;i<retUsers.getRowCount();i++)
        {
	 sysKey = sysKey+retUsers.getFieldValueString(i,"ESKD_SYS_KEY")+"','";
        }
	sysKey = sysKey.substring(0,sysKey.length()-3); */

	sysKey = (String)session.getValue("SYSKEY");

	String comments=request.getParameter("comments");
	String user=Session.getUserId();

	SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss");
	String date = sdf.format(new java.util.Date());

	String qcfNum = request.getParameter("QcfNumber");
	String type = request.getParameter("Type");

	try
	{


		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String filePath=request.getRealPath("ezQcfComments.jsp");
		filePath=filePath.substring(0,filePath.indexOf("ezQcfComments.jsp"));
		//filePath += "\\EzCommerce\\EzVendor\\EzVendorDemo\\Vendor2\\JSPs\\Purorder\\QCF\\"+qcfNum+".xml";
		filePath=filePath+relativePath+qcfNum+".xml";

		Document doc = docBuilder.parse("file:"+filePath);
		Element root = doc.getDocumentElement();

			Node n1 = (Node)doc.createElement("User-Comments");
			Node n2 = (Node)doc.createElement("User");
			Node n3 = (Node)doc.createElement("Date");
			Node n4 = (Node)doc.createElement("Comments");

			Node n5 = (Node)doc.createTextNode(user);
			Node n6 = (Node)doc.createTextNode(date);
			Node n7 = (Node)doc.createTextNode(comments);

			n2.appendChild(n5);
			n3.appendChild(n6);
			n4.appendChild(n7);

			n1.appendChild(n2);
			n1.appendChild(n3);
			n1.appendChild(n4);

			Node tmp = (Node)root;
			tmp.appendChild(n1);

		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();

		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));

	}
	catch(Exception e)
	{
		out.println(e);
	}

%>
<%@ include file="../../../Includes/JSPs/Purorder/iUpdateQCFStatus.jsp" %>

<html>
<head>
<title></title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
function reLoad()
{
	if(parent.opener.document.myForm.Type!=null)
	{
		parent.opener.document.myForm.Type.value='<%=type%>'
		opener.document.myForm.action="ezListQcfs.jsp";
		opener.document.myForm.submit();
		window.close()
	}
	else
	{
		window.close();
	}
}
</script>
</head>
<body bgcolor="#FFFFF7">
<br>
<br>
<br>
<table width="50%" align="center" border=0>
  <tr align="center">
  <%
    String dispMessage="";

    String msgText="";
    String msgSubject="";
    String sendToUser="";
    //String desiredStep="";
    ArrayList desiredSteps=new ArrayList();

    if(userRole.equals("VP"))
    {
    	if(action.equals("300004"))
    	{

	   desiredSteps.add("1");
	   desiredSteps.add("2");
	   //desiredStep="1";

    	   dispMessage="Document has been approved";

	   msgSubject ="Document No : "+qcfNum+" has been approved";
	   msgText = "Hi,\n       Document Number "+qcfNum+" has been approved.\nRegards,\n"+Session.getUserId();
  	}
    	else
    	{

		//This is added nagesh to send mails to only PH.
		desiredSteps.add("1");
		//desiredStep="1";

    	   dispMessage="Document has been returned to Purchase Head";

	   msgSubject ="Document No : "+qcfNum+" has been returned";
	   msgText = "Hi,\n       Document Number "+qcfNum+" has been returned for further clarification.\nRegards,\n"+Session.getUserId();
    	}
    }
    else if(userRole.equals("PH"))
    {
        if(action.equals("300002"))
        {

		//This is added by nagesh to send mail to VP
	   desiredSteps.add("-1");
	   //desiredStep="-1";

           dispMessage="Document has been submitted to Vice President";

	   msgSubject ="QCF No : "+qcfNum+" has been submitted";
	   msgText = "Hi,\n       Document Number "+qcfNum+" has been submitted for further approval.\nRegards,\n"+Session.getUserId();
        }
        else
        {

		//This is added by nagesh to send mails to PP.
		desiredSteps.add("1");
		//desiredStep="1";


           dispMessage="Document has been returned to Purchase Person";
	   msgSubject ="Document No : "+qcfNum+" has been returned";
	   msgText = "Hi,\n       Document Number "+qcfNum+" has been returned for further clarification.\nRegards,\n"+Session.getUserId();
	   sendToUser = request.getParameter("Created")+";";
        }
    }
    else if(userRole.equals("PP"))
    {
        if(action.equals("300000"))
        {

		//This is added by nagesh to send mail to PH.
	   desiredSteps.add("-1");
	   //desiredStep="-1";

           dispMessage="Document has been submitted to Purchase Head";

	   msgSubject ="Document No : "+qcfNum+" has been submitted";
	   msgText = "Hi,\n       Document Number "+qcfNum+" has been submitted for further approval.\nRegards,\n"+Session.getUserId();
        }
    }

System.out.println(">>>>>>>>>>>>>>>>>>>>>WorkFlowParameters  ---  userRole "+userRole);
System.out.println(">>>>>>>>>>>>>>>>>>>>>WorkFlowParameters  ---  action "+action);

   if(!action.equals("300006"))
   {

    	ezc.ezparam.ReturnObjFromRetrieve retsoldto=null;

	String template=(String)session.getValue("TEMPLATE");
        String participant=(String)session.getValue("USERGROUP");
        ezc.ezparam.ReturnObjFromRetrieve retSoldTo = null;
        ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
        ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
        params.setTemplate(template);
        params.setSyskey(sysKey);
        params.setParticipant(participant);
        params.setDesiredSteps(desiredSteps);
        mainParams.setObject(params);
        Session.prepareParams(mainParams);
        retSoldTo=(ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);
        int usersCount=retSoldTo.getRowCount();
        for(int i=0;i<usersCount;i++)
        {
		sendToUser=sendToUser+retSoldTo.getFieldValueString(i,"EU_ID")+",";
        }
}
	sendToUser=sendToUser.substring(0,sendToUser.length()-1);

System.out.println(">>>>>>>>>>>>>>>>>>>>>Mail will be send to following users "+sendToUser);
%>
<%@ include file="../Purorder/ezSendAckMail.jsp" %>
 <th><%=dispMessage%></th>
   </tr>
</table>
<br><br>
<center><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="reLoad()"></center>
<Div id="MenuSol"></Div>
</body>
</html>
