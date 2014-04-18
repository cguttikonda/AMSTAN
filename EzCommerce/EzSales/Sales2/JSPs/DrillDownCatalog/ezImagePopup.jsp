<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<html>
<head>
	<Script>
		  var tabHeadWidth=70
 	   	  var tabHeight="75%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<title>Product Information</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body >
<form method="post">
<%
	String matNum= request.getParameter("matNo");
	String fileName= request.getParameter("fileName");
%>
<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

<tr align="center">
      <td width="100%" class="blankcell"> 
	<img src="../../Images/IMAGEUPLOAD/<%=fileName%>" border="2" >
      </td>
</tr>
</table>
<br>
<center>
<%
    	buttonName   = new java.util.ArrayList();
    	buttonMethod = new java.util.ArrayList();
    		
	buttonName.add("Close");
	buttonMethod.add("window.close()");
    		
    	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</form>

</body>
</html>