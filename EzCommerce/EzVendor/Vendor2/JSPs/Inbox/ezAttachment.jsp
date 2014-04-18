<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iLang_Labels.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%@ include file="../../../Includes/Jsps/Inbox/iGetUploadTempDir.jsp"%>

<%
   String cancel=request.getParameter("operation");
%>

<html>
  <head>
     <title>Mail Attachments</title>
     <link rel="stylesheet" href="Theme1.css">
     <script src="../../Library/JavaScript/Inbox/ezComposePersMsgs.js"></script>
     <script language="JavaScript">

  	function setVal()
     	{

<%
      String fname=String.valueOf(session.getValue("fname"));
      System.out.println("session value is :"+fname);
      String check=request.getParameter("attachlist");
      System.out.println("check value :"+check);

      String message=request.getParameter("mess");
      System.out.println("the file already exist value is :"+message);



            if(cancel !=null && !"null".equals(cancel) && !"".equals(cancel))
            {
        	 try
        	{

      		   File fdel=new File(inboxPath+session.getId());
      		   boolean ret=false;
      		   if(fdel.exists() && fdel.isDirectory())
      		   {
      			File[] files=fdel.listFiles();
      			if(files.length==0)
      			{
%>

				    parent.opener.myForm.attachs.value="";

                            window.close();
<%
      			}
      			else
      			{
      			    File fnew=null;
      			    for(int m=0;m<files.length;m++)
      			    {
      			    	System.out.println("IN LOOP");
      			       fnew=new File(inboxPath+session.getId()+"\\"+files[m].getName());
      			       System.out.println("file name is:"+files[m].getName());
      			       if(fnew.exists() && fnew.isFile())
      			       {
      				    fnew.delete();
      				    System.out.println("deleted:"+m);
      			       }
      			    }
      			}
      			 session.putValue("fname","");
      			 fdel.delete();
      		   }
%>
	    parent.opener.myForm.attachs.value="";
        window.close();
<%
      		   }catch(Exception e)
      		   {
      		       System.out.println("the exception we are getting while deleting is:"+e.getMessage());
      	           }
             }
	     if(check!=null)
	     {
	          System.out.println("inside check value :"+check);
           String p="";
	          File f=new File(inboxPath+session.getId()+"\\"+check);
	          if(f.exists())
	          {
	                  System.out.println("the file name is :"+f.getPath());
	           	  f.delete();
	          	  StringTokenizer st=new StringTokenizer(fname,",");
	           	  System.out.println("no of tokens :"+st.countTokens());
	           	  if(st.countTokens()==1)
	           	  {
          	               session.putValue("fname","");
	           	  }
	           	  else
	           	  {
	           	       while(st.hasMoreTokens())
	           	       {
	           	       	  String tok=st.nextToken();
	          	          if(tok.equals(check))
	           	          {
	           	          }
	           	          else
	           	          {
	          	                  p=p+tok+",";
	           	          }
	         	   }
			session.putValue("fname",p.substring(0,p.length()-1));
           	       }
             	  }

      }

      fname=String.valueOf(session.getValue("fname"));
%>
      var exist="<%=message%>";
      var s="<%=fname%>";
      if((s!=""))
      {
	    	var sa=s.split(",");
	    	if(sa.length==0)
	    	{
	    	     document.temp.attachlist.options[i]=new Option(sa[i],sa[i]);
	    	}
	    	for(i=0;i<sa.length;i++)
	    	{
	    	      document.temp.attachlist.options[i]=new Option(sa[i],sa[i]);
    	        }
       }

             if(exist=="exist")
             {
                alert("The file with this name already exists");
             }

 }

     </script>
  </head>

  <body onLoad="setVal()">

     <Table border=0 cellspacing=0 cellpadding=0 width=600>
  	<Tr>
  	    <Td width=15 rowspan=7></Td>
  	    <Ta class=displaycell align=center  colspan=5 >
  		  Attach a file to your message in two steps, repeating the steps as needed to attach multiple files. Click <b>OK</b> to return to your message when you are done.
   		<br><br>
  	   </Td>
	</Tr>
</table>
<form name="doneattach" ENCTYPE="multipart/form-data" method="POST" >
  <table border=0 cellspacing=0 cellpadding=0 width=100% >
    <tr>
      <td  width=50%>
      <table width="100%" border="1" cellspacing=0 cellpadding=0 borderColorDark="#ffffff" borderColorLight="#000000">
      <tr>
      <td>
     	  <table width="100%" border="0" cellspacing=0 cellpadding=0 >
      	  <tr>
      		  	<th width=5% height=1>
      	  		<font size=2> 1</font>
      		  	</th>
      	      <td>
			     &nbsp;
			</td>
         </tr>
          <tr>
      	      <td>
			     &nbsp;
			</td>

            <td colspan=2>
            <font size=1 class="blackcell">
            <br>
            Click <b>Browse</b> to select the file, or type the path to the file in the box below.
            </font>
            <br><br><br>
		      <font  style="font-size:13px"><label for="attFbutton">Attach File</label>:</font><br>
		      <input type="file"  name="attfile" id="attFbutton" tabindex="1" title="Click here to select a File">
			<br><br><br><br><br>
            </td>
          </tr>
          <tr>
          </tr>
        </table>

        </td>
        </tr>
       </table>
      </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td width=50%>



        <table width="100%" border="1" cellspacing=0 cellpadding=0 borderColorDark="#ffffff" borderColorLight="#000000">
          <tr>
            <td >

      	  <table width="100%" border="0" cellspacing=0 cellpadding=0 >
      	  <tr>
      		  	<th width=5% height=1>
      	  		<font size=2> 2</font>
      		  	</th>
      	      <td>
			     &nbsp;
			</td>
         </tr>
          <tr>
      	      <td>
			     &nbsp;
			</td>

            <td colspan=2>

            	<font size=1 class="blackcell">
            	<br>
            		Move the file to the <b>Attachments</b> Box by clicking Attach.File transfer times vary from (30sec to 10min).
            	</font>
				<br><br><br>


			<table width=100%>
			  <tr>
            <td width=30%>
	 		<a href="javascript:doClose()"><img src = "../../Images/Buttons/<%= ButtonDir%>/attach.gif"  title="<%=getLabel("TT_CLK_HR_ATTC_FILE")%>" border=none  <%=statusbar%>></a><br>
	 		<br>
			<a href="javascript:doRemove()"><img src = "../../Images/Buttons/<%= ButtonDir%>/remove1.gif"  title="<%=getLabel("TT_CLK_HR_RMV_FILE")%>" border=none   <%=statusbar%>></a>
			</td>
</form>
			<td width=70%>
<form name="temp">
<input type='hidden' name="filename" value="empty">

				<select name="attachlist" tabindex="4" multiple style="width:100%" size=5>
		   	        </select>
</form>

		   	 </td>

		   	 </tr>
		   	 </table>

			<br><br>

            </td>
          </tr>
          <tr>
          </tr>
        </table>


            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<form name="temp1" ENCTYPE="multipart/form-data" method="POST">
	<br<br><br>
	<table border=0 width=100%>
	  <Tr>
	  <Td colspan=5 align=center>
			<a href="JavaScript:doAttach()">
<img src = "../../Images/Buttons/<%= ButtonDir%>/done.gif"  title="<%=getLabel("TT_CLK_HR_CONS_ATTC")%>" border=none <%=statusbar%>></a>
		&nbsp;

	<!--	<a href="JavaScript:doCancel()"><img src="../../Images/Buttons/<%= ButtonDir%>/cancel.gif"  title="<%=getLabel("TT_CLK_HR_IGN_ATTC")%>" border=none  <%=statusbar%>></a> -->
	  </Td>
	  </Tr>
	  </table>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

