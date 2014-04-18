
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/InboxBean.jsp"%>
<%@ include file="../../../Includes/Lib/Inbox.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="java.util.*" %>
<%

        String msgId=request.getParameter("MessageID");
	String fold=request.getParameter("folder");

	String FolderName= request.getParameter("FolderName");
        int msg1=Integer.parseInt(msgId);
        String subject=request.getParameter("Subject");

        ReturnObjFromRetrieve resDetails=null;
	ReturnObjFromRetrieve retMsgInfo = null;
	ReturnObjFromRetrieve retFoldList = null;

	String language = "EN";
	String client = "200";
        EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();	
		     
     	String folderID = request.getParameter("FolderID");
     	if(folderID == null)
     	{
     		folderID = "1000";
     	}
	     	// Set the Input Parameters
	     	ezcMessageParams.setMsgId(msgId);
	     	ezMessageParams.setClient(client);
	     	ezMessageParams.setLanguage(language);
	     	ezcMessageParams.setObject(ezMessageParams);
		Session.prepareParams(ezcMessageParams); 

	     	retFoldList = (ReturnObjFromRetrieve)Manager.getFolderList(ezcMessageParams);
	     	retFoldList.check();
	     	
	     	String server = (String)session.getValue("SERVER");
		String protocol = (String)session.getValue("PROTOCOL");
		String mailUser = (String)session.getValue("USERID");
        	String mailPassword = (String)session.getValue("PASSWORD");

               ezc.ezmail.EzMail mail=new ezc.ezmail.EzMail();
               
               ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();

               mailParams.setHost(server);
               mailParams.setProtocol(protocol);
               if("IMAP".equals(protocol))
	               	mailParams.setPort("143");
	       else
	              	mailParams.setPort("110");
        	               
               mailParams.setUserId(mailUser);
               mailParams.setPassword(mailPassword);
               mailParams.setFolderName(fold);
              mailParams.setMessageId(""+msg1);
              

              retMsgInfo=mail.getMailDetails(mailParams);
               	Vector attachments=new Vector();
                       String flag=retMsgInfo.getFieldValueString(0,"ISATTACH");
                       if(flag.equals("Y"))
		       {
                          attachments=(Vector)retMsgInfo.getFieldValue(0,"ATTACHMENTS");
                       }
                       
		       String fileAttach="";
	     	
         		String from= retMsgInfo.getFieldValueString(0, "FROM");  
         		
         		if((from==null) || ("null".equals(from)))
         		{  
         		     from="----";
         		}
         		//String subject=(String)retMsgInfo.getFieldValueString(0, "SUBJECT");
         		
         		if(subject==null || ("null".equals(subject)))
         		{
         		   subject="----";
         		 }

                       Date d=(Date)retMsgInfo.getFieldValue(0,"DATE");
                       String dat="";
                       if(d!=null)
                       {
                           dat=d.getDate()+"."+(d.getMonth()+1)+"."+(d.getYear()+1900);
                       }
                       else 
                       {
                       	dat="&nbsp";
                       }
                       
		     	String msg = (String)retMsgInfo.getFieldValueString(0, "CONTENT");
                        msg=msg.substring(msg.lastIndexOf("*")+1,msg.length());
		     	if(msg!=null)
		     	{
		     	   
		     	}
		     	else
		     	{
		     	      msg="";
		     	}
		     	
                       
%>


<html>
   <head>
        <Title>Inbox: Personal Message Details</Title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	
	<script src = "../../Library/JavaScript/Inbox/ezPersMsgDetails.js"></script>
<script>
  	tabHeadWidth=80;
  </script>
<script src="../../Library/JavaScript/ezScrollDefine.js"></script>
<script src="../../Library/JavaScript/ezScroll.js"></script>

	<body onLoad='scrollInit()' onResize='scrollInit()' bgcolor="#FFFFF7"  scroll=no>
	
	
<form name=myForm method=post action="ezDelPersMsgs.jsp">
	    
	    <br>
		<Table   width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
	  	    <Tr align="center"> 
		    	<Td class="displayheader">Message Details</Td>
	  	    </Tr>
	        </Table >
	      <!--  <div id="theads">-->
	        <Table   width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666  cellPadding=2 cellSpacing=0 >
    	           <Tr align="center" valign="middle" > 
      	               <Td width="25%" class="labelcell" align = right> From: </Td>
	       	       <Td width="75%" align="left"> 
        	           <input type="hidden" name="fromUser" value="<%=from%>"><%=from%>
	      	       </Td>
    	           </Tr>
    	           <Tr align="center" valign="middle"> 
    	  	        <Td width="25%" class="labelcell" align = right> Subject: </Td>
		        <Td width="75%" align="left"> 
	                   <input type="hidden" name="msgSubject"  value="<%=subject%>"><input type="text" size=90 readonly value="<%=subject%>" class=DisplayBox>

<%
                      
                     if(attachments.size() > 0)
		       {
		          
                         for(int i=0;i<attachments.size();i++)
                         
	 	         {
%>
                             <b><a href="ezDownLoad.jsp?MessageId=<%=msgId%>&FolderName=<%=fold%>&FileName=<%=attachments.elementAt(i)%>" style="text-decoration:none"><%=attachments.elementAt(i)%></a></b>
<%
                                 
		         }
                       }
                      
%>

                                  
	                   
        	        </Td>
     	           </Tr>
	           <Tr align="center" valign="middle" >
      	                <Td width="25%" class="labelcell" align = right>Date:</Td>
      	                <Td width="75%" align="left"><%=dat%>	</Td>
    	           </Tr>
                </Table >
               
		<!--</div>--> <BR>
		<!--<DIV id="OuterBox1Div" style="position:absolute">
		<DIV id="InnerBox1Div">-->
		
		       	            <%=( (("null").equals(msg))||(msg==null)?"&nbsp;":msg)%>
            
              	<!--</div></div>
	                      <div id="ScrollBoxDiv" style="position:absolute;top:80%;left:80%;visibility:hidden">
	      			<A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='dn'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
	          			<img name="scrollDn" src="../../Images/Buttons/<%=ButtonDir%>/down.gif" border="0" alt="Scroll Down"></a>
	          			<A HREF="javascript:void(0)" onmouseOver="scrolling=1;UpDn='up'; javascript:scrollMessage(); return false;" onmouseOut="scrolling=0;clearTimeout(timerID)" onClick="javascript:pageUpDnMessage(); return false;">
	          			<img name="scrollUp" src="../../Images/Buttons/<%=ButtonDir%>/up.gif" border="0" alt="Scroll Up"></a>
		</div>-->
	    	
 	   <div align="center" style="position:absolute;top:85%;left:35%;"><br>
		<input type="image" src = "../../Images/Buttons/<%=ButtonDir%>/reply.gif" name="Submit" value="Reply" onClick="setActionNew();return document.returnValue">
                <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
   </div> 
	 <br>
</form>
</body>
</html>

