<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iSystemKeys.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iGetSyncDetails.jsp"%>

<%@ page import="java.util.*" %>

<html>
<head>
  <script language="JavaScript">
     function getUsers()
     {
          
          document.form1.submit();
     }

  </script>
</head>
<body>

<form name=myForm method=post action="ezPayToSyncFails.jsp">

     <input type='hidden' name='type' value='pay'>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr  align="center">
	    <Th >Select</Th>
   	      <td> <select name="syskey" multiple size=5  >

<%
        for(int i=0;i<v.size();i++)
	{
%>
		<option value="<%=v.elementAt(i)%>"><%=v.elementAt(i)%>


<%
        }
%>
	</select>
	</Td>
		<Td >
                      <input type='submit' name='submit' value='submit' >
			<!--<img src = "../../Images/Buttons/show.gif" style = "cursor:hand" onClick ="funGetUsers()">-->
		</Td>
	</Tr>
	</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		
	

<%
         int size=v1.size();

         if(size==0)
	 {
%>
	
		<br><br>
     <tr>
      <Td class = "labelcell">
        <div align="center"><b>Please Select System keys  to continue.</b></div>
    </Td></tr>
<%
        }
        else
	{
              for(int m=0;m<v1.size();m++)
	      {
                   String element=String.valueOf(v1.elementAt(m));
                   StringTokenizer st=new StringTokenizer(element,",");
%>
               <tr>
<%                   
                   while(st.hasMoreTokens())
	           {
%>
			<Td class = "labelcell">
                            <%=st.nextToken()%>
                        </Td>
<%
		   }
%>
                </tr>
<%	        
              }
          }
%>
		
		</Table><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>
	

</form>
</body>
</html>
