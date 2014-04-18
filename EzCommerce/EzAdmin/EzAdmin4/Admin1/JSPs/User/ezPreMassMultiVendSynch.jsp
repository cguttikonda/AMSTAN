<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="java.io.*" %>
<%
	File f=new File("D:\\orant\\j2ee\\home\\lib");
	String[] str=f.list(new ezc.ezbasicutil.EzFilter("PROPERTIES"));
%>
<html>
<head>
<meta name="Author" content="Suresh Parimi">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/User/ezPreMultiMassSynch.js"></script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit()' onresize='scrollInit()' scroll=no>


<form name=myForm method=post action="ezMultiMassVendSynch.jsp" onSubmit='return synch()'>

		<br>


<%
        //out.println(str.length);
        if(str.length == 0)
        {
%>
          <Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	  		<Tr>
	  		<Th width="54%">No Purchase Areas to List</Th>
	  		</Tr>
		</Table>
		<br><br><br><br>
		<center><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
<%
        }
        else
        {
%>
		<div id="theads">
		<Table  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
		<Th width="54%">List of Purchase Areas</Th>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
<%
        int mes=0;
		for (int i=0;i<str.length;i++)
		{
			if(str[i].startsWith("999"))
			{
			   mes++;
				if(i%6==0)
				{
%>
				</tr>
				<tr>
<%
				}
%>
				<td>
			   		<input type="checkbox" name="chk1" value="<%=str[i].substring(0,6)%>">
<%
					out.println(str[i].substring(0,6));
%>
				</td>
<%
			 }
		}
		if(mes==0)
		{
%>
    <br><br><br><br><br>
                         <Td align='center'>No Required Purchase Areas to List</Td>

		</tr>
		</table>
		</div>

	<div id="ButtonDiv" align=center style="position:absolute;top:90%;width:100%">
       		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>	
<%
               }
               else
               {
%> 
       </tr>
       		</table>
       		</div>
       			
       	<div align="center" style="position:absolute;top:90%;width:100%">
       		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" >
              		<img src="../../Images/Buttons/<%= ButtonDir%>/clearall.gif" name="Reset" onClick="document.myForm.reset()" style="cursor:hand">
              		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

	</div>
                
<%
               }
      }
%>      
</form>
</body>
</html>
	
