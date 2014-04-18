<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iSystemKeys.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iGetSyncDetails.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%@ page import="java.util.*" %>
<%
     String type=request.getParameter("type");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

		
  <script language="JavaScript">
     
  </script>

<script src="../../Library/JavaScript/ezTabScroll.js"></script>

</head>
<body onLoad='scrollInit()' onResize='scrollInit()' bgcolor="#FFFFF7"  scroll=no>

<form name=myForm method=post action="ezUserSyncDetails.jsp">
    <input type='hidden' name='type' value="<%=type%>">

<%
        if((v.size()==0) && (temps.equals("false")))
	{
%>
<div id="test" width="100%"  style="position:absolute;top:30%;left:20%;">
             <Table top=50 border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="60%"  >
	             <tr>
	               <Td class = "labelcell">
	                   <div align="center"><b>No Data Exists In Database</b></div>
	               </Td>
	             </tr>
       </table></div>
<%
	}
	else if ((v.size()==0) && (temps.equals("true")))
	{
%>
         <div id="test" width="100%"  style="position:absolute;top:30%;left:20%;">
	              <Table top=50 border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="60%"  >
	 	             <tr>
	 	               <Td class = "labelcell">
	 	                   <div align="center"><b>Check the Log file it is throwing some exception</b></div>
	 	               </Td>
	 	             </tr>
       </table></div>
<%
	}
        else
        {
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr  align="center">
	    <Th width="46%" class="labelcell">Select System Key</Th>
   	      <Td width="38%" class="blankcell">
                   <div id = listBoxDiv> <select name="syskey" multiple size=5  >

<%
        for(int i=0;i<v.size();i++)
	{
%>
		<option value="<%=v.elementAt(i)%>"><%=v.elementAt(i)%>
<%
        }
%>
	</select></div>
	</Td>
		<Td >
		     <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/show.gif" style = "cursor:hand">
		</Td>
	</Tr>
	</Table><br><br>
<%
         int size=v1.size();
         if(!data.equals("nodata"))
         {
%>
            <br><br>
	    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	             <tr>
	               <Td class = "labelcell">
	                   <div align="center"><b>Please Select System keys  to continue.</b></div>
	               </Td>
	             </tr>
       </table>
<%
        }
         if((size==0) && (data.equals("nodata")))
	 {
%>
	<br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
         <tr>
           <Td class = "labelcell">
               <div align="center"><b>No Data Found</b></div>
           </Td>
         </tr>
       </table>
<%
        }
        else if(size>0)
        {
%>
	<div id="theads">
	<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Th width="40%">UserId</Th>
			<Th WIDTH="60%">Password</Th>
		</Tr>
	</Table>
	</div>

	<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
<%
              for(int m=0;m<v1.size();m++)
	      {
                   String element=String.valueOf(v1.elementAt(m));
                   StringTokenizer st=new StringTokenizer(element,",");
%>
               <Tr align="left">
<%
                   while(st.hasMoreTokens())
	           {
%>
                           <Td width="40%">
                              <%=st.nextToken()%>
                           </Td>
                           <Td width="60%">
                              <%=st.nextToken()%>
                           </Td>
<%
		   }
%>
                </Tr>
<%
              }
            }
          }
%>
		</Table></div>
                <br>
          </form>
     </body>
</html>
