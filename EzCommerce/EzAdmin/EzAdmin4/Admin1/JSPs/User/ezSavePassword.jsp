<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<form name=myForm method=post action="ezPassword.jsp">
<%
  String oldpwd=request.getParameter("oldpassword");
  String newpwd=request.getParameter("newpassword");
  
  //check whether user entered old password is correct or not
  EzcUserParams uparams= new EzcUserParams();
  EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
  ezcUserNKParams.setPassword(oldpwd);
  uparams.createContainer();
  uparams.setObject(ezcUserNKParams);
  Session.prepareParams(uparams);
  boolean isValid = UserManager.validateUserPassword(uparams);
 
 //if user entered  wrong old password
 
  if(!isValid)
  {
  %>
  <br><br><br><br>
  <center>
   <span class=nolabelcell>
     Your old password is invalid please try agian<br>
   <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
 <%
   }
   else //if old password is correct
   {
        
        //update user password to new one
        ezcUserNKParams.setPassword(newpwd);
        uparams.createContainer();
        boolean result_flag = uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);
	UserManager.changeLoginUserPassword(uparams);
	
	
	//update the ezInfo.xml file
	try
	{
		DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

		String fileName = "ezSavePassword.jsp";
		String filePath=request.getRealPath(fileName);
		filePath=filePath.substring(0,filePath.indexOf(fileName));
		filePath += "\\ezInfo.xml";
		



		Document doc = docBuilder.parse("file:"+filePath);

		Element root = doc.getDocumentElement();
		
		NodeList list = root.getElementsByTagName("info");
		Element element=null;
		Node node=null;
		
		node=list.item(0);
		
		//String old = ((Element)node).getElementsByTagName("data").item(0).getFirstChild().getNodeValue();
		
		((Element)node).getElementsByTagName("data").item(0).getFirstChild().setNodeValue(newpwd);

		TransformerFactory factory = TransformerFactory.newInstance();
		Transformer transformer = factory.newTransformer();
		transformer.transform(new DOMSource(root),new StreamResult(new FileOutputStream(filePath)));

	}
	catch(Exception e)
	{
		out.println(e);
	}
	
 %>
 <br><br><br><br>
 <center>
  <span class=nolabelcell>
     Your Password has been changed successfully!!<br>
     From next login onwards you can use your new password.
  </span>
 </center>   

<%
  }
%>
</body>
</html>