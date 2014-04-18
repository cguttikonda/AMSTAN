<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="javax.xml.parsers.*,java.io.*,javax.xml.transform.*,javax.xml.transform.dom.*,javax.xml.transform.stream.*" %>
<%@ page import="org.w3c.dom.*,org.xml.sax.*" %>

<%

	String orderXML = request.getParameter("orderXML");
	String SalesOrder = request.getParameter("SO");
	String userEmail = (String)session.getValue("USEREMAIL");
	String EzMsg ="Problem Ocuured While Sending Order XML";

	if(SalesOrder==null) SalesOrder = "";
	
	
	String filePathTemp = "";
	
	String filePath=request.getRealPath("ezEmailOrderAsXML.jsp");
	filePath=filePath.substring(0,filePath.indexOf("ezEmailOrderAsXML.jsp"));
	filePathTemp = filePath+"\\XML";
	filePath += "\\XML\\ezOrder_"+SalesOrder+".xml";
	
	String fName = "ezOrder_"+SalesOrder+".xml";
	
	
	File file = new File(filePath);
	ArrayList filename= new ArrayList();

	

	if(!file.exists())
	{
		orderXML=orderXML.replaceAll("&lt;","<");
		orderXML=orderXML.replaceAll("&gt;",">");
		orderXML=orderXML.replaceAll("&amp;","&");
		orderXML=orderXML.replaceAll("&apos;","'");
		orderXML=orderXML.replaceAll("&quo;","\"");

		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		Document document = docBuilder.parse(new InputSource(new StringReader(orderXML))); 

		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();
		transformer.transform(new DOMSource(document),new StreamResult(new File(filePath)));
		
			
	}
	
	File folder = new File(filePathTemp);
	File[] listOfFiles = folder.listFiles();
				
			
	for (int i = 0; i < listOfFiles.length; i++) {
		    if (listOfFiles[i].isFile()) {
			filename.add(listOfFiles[i].getName());

		    }
		}

	int index = filename.indexOf(fName);

	if(index>=0)
	filename.remove(index);

	
	ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();
	
	mailParams.setGroupId("Ezc");
	//mailParams.setTo(userEmail);
	//mailParams.setCC();
	mailParams.setTo("mbablani@answerthink.com");
	mailParams.setCC("psingamaneni@answerthink.com");
	mailParams.setMsgText("Please find the Attached order : "+SalesOrder+"  XML");
	mailParams.setSubject("Order : "+SalesOrder+" XML");


	if(file.exists())
	{
		mailParams.setAttachDirectory(filePathTemp);
		mailParams.setSendAttachments(true);
	}
	else
	{
		mailParams.setSendAttachments(false);
	}	

	if(filename.size()>0)
		mailParams.setAttachExclusion(filename);

	ezc.ezmail.EzMail myMail=new ezc.ezmail.EzMail();
	boolean value=false;
	value = myMail.ezSend(mailParams,Session);

	if(value)
	EzMsg ="Order XML has been sent Successfully";
		
	
	
%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<html>
<Script>
function funOk()
{

	document.myForm.action="../Sales/ezBackEndSOList.jsp?RefDocType=P";
	document.myForm.submit();
}
</Script>
<body>
<form name="myForm">
<Div>
<table align=center>
<br><br><br><br><br><br>
<td align=center class=displayalert>
<%
out.println(EzMsg);
%>
</td>
</tr>
</table>
<br><br><br>
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();	
	
	buttonName.add("Ok");
	buttonMethod.add("funOk()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
