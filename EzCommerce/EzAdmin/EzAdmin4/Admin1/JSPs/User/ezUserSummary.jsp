<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iUserSummary.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="java.util.*" %>

<html>
 <head>
 <script src="../../Library/JavaScript/ezSortTableData.js"></script>
 <%
     
 %>
     <script language="JavaScript">
     </script>
     <script>
       	tabHeadWidth=80;
     </script>

<script src="../../Library/JavaScript/ezTabScroll.js"></script>
 </head>
 <body onLoad='scrollInit();ezInitSorting()' onResize='scrollInit()' bgcolor="#FFFFF7"  scroll=no>

<form name=myForm method=post action="">
  <br>

    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    		<Tr>
    			<th align='center'>EzCommerce Mass Vendor Synchronization Summary</th>
    		</Tr>
  </table>
<%
        if(v.size() > 0)
        {
%>
    <div id="theads">
     <Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    		<Tr>
		    <Th width="20%" onClick="ezSortElements(0)" style="cursor:hand">System Key</Th>
		    <Th WIDTH="40%" onClick="ezSortElements(1)" style="cursor:hand">Status</Th>
		    <Th WIDTH="40%" onClick="ezSortElements(2)" style="cursor:hand">No.of Occurences</Th>
		</Tr>
	</Table>
	</div>

	<DIV id="InnerBox1Div">
        <Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
<%
        int create=0;
        int payto=0;
        int fun=0;
        int bp=0;
        int bpin=0;
        int us=0;
        int usin=0;
        int cust=0;
        int ven=0;
        int nocust=0;
       for(int i=0;i<v.size();i++)
       {
       	   StringTokenizer st=new StringTokenizer(String.valueOf(v.elementAt(i)),",");
       	   while(st.hasMoreTokens())
       	   {
       	      String user=String.valueOf(st.nextToken());
       	      String key=String.valueOf(st.nextToken());
       	      String occur=String.valueOf(st.nextToken());
       	      if(key.equals("SUC-USERCREATED"))
       	      {
       	            key="User Created";
       	            create=create+Integer.parseInt(occur);
       	      }
       	      else if(key.equals("EXP-PAYTO"))
       	      {
       	          key="Pay to Sync Failed";
       	          payto=payto+Integer.parseInt(occur);
       	      }
       	      else if(key.equals("EXP-FUNCTIONS"))
	      {
	         key="Function Synch Failed";
	         fun=fun+Integer.parseInt(occur);
       	      }
       	      else if(key.equals("EXP-BPSYSAUTH"))
	      {
	         key="Buisiness System Auth";
	         bp=bp+Integer.parseInt(occur);
       	      }
       	      else if(key.equals("EXP-BPSYSINAUTH"))
	             	      {
	             	          key="Buisiness SysIn Auth";
	             	          bpin=bpin+Integer.parseInt(occur);
       	      }
       	      else if(key.equals("EXP-USERSYSAUTH"))
	             	      {
	             	          key="User System Auth";
	             	          us=us+Integer.parseInt(occur);
       	      }
       	      else if(key.equals("EXP-USERSYSINAUTH"))
	             	      {
	             	          key="User SystemIn Auth";
	             	          usin=usin+Integer.parseInt(occur);
       	      }
              else if(key.equals("EXP-VNDORS"))
	             	      {
	             	          key="Vendor Sync Failed";
	             	          ven=ven+Integer.parseInt(occur);
       	      }
              else if(key.equals("EXP-CUST"))
	             	      {
	             	          key="Customer Sync Failed";
	             	          cust=cust+Integer.parseInt(occur);
       	      }
              else if(key.equals("EXP-NOCUST"))
	             	      {
	             	          key="No Customer";
	             	          nocust=nocust+Integer.parseInt(occur);
       	      }

%>
               <tr>
                  <td width=20%><%=user%></td>
                  <td width=40%><%=key%></td>
                  <td width=40%><%=occur%></td>
               </tr>

               <script>
	       	  //========= Folowing code is for sorting=========================//
	       	    rowArray=new Array()
	       	     rowArray[0]= "<%=user%>"
	       	     rowArray[1]="<%=key%>"
	       	     rowArray[2]="<%=occur%>"



	       	    //end of storing data

	       	     dataArray[<%=i%>]=rowArray
	        </script>
<%

       	   }
       }

%>

</table>



  </div><br>



  <div align='center' id="data" style="position:absolute;top:81%;width:100%;">
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    		    		<Tr>
    		    			<th>System Keys</th>
    		    			   <td><%=v.size()%></td>

    		    			<th>Users Created</th>
    		    			   <td><%=create%></td>
    		    			   <th>Pay To Sync</th>
    		    			   <td><%=payto%></td>
    		    			<th>Fun Sync</th>
    		    			   <td><%=fun%></td>
    		    		</Tr>
    		    		<Tr>
    					    <th>Customer Sync</th>
    					       <td><%=cust%></td>
    					    <th>Vendor Sync</th>
    					       <td><%=ven%></td>
    		    			    <th>No Customer</th>
    		    			     <td><%=nocust%></td>
    		    			     <th>User SysIn Auth</th>
    		    			     <td><%=usin%></td>
    		    		</Tr>
  </table>
  </div>


        <%
      }
      else if((v.size()==0) && (temp.equals("false")))
      {
%>
        <div id="test" width="100%"  style="position:absolute;top:30%;left:20%;">
             <Table top=50 border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="60%"  >
    		<Tr colspan=3 align='center'>
			<Td width="20%">No Vendor's exists</Td>

		</Tr>

	</Table></div>
<%
      }
      else if((v.size()==0) && (temp.equals("true")))
      {
%>
    <div id="test" width="100%"  style="position:absolute;top:30%;left:20%;">
             <Table top=50 border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="60%"  >
    		<Tr colspan=3 align='center'>
			<Td width="20%">check the log file some exceptions are arising</Td>

		</Tr>

	</Table></div>
<%
      }
%>
</form>
</body>
</html>

