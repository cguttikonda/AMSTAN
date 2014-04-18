<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<HTML>
<HEAD>
<style>

   A  {text-decoration: none;
       color: black}
  .folderStyle{
       font-family: Verdana, Arial, sans-serif;
	   	font-size: 11px;
	   	font-weight: bold;
	    color: #336699;
      }
   .docStyle{
	       font-size: 11px;
	  	   font-family: verdana,helvetica;
	  	   text-decoration: none;
	  	   white-space:nowrap;
	       color: blue;
      }
</style>
</Head>


<frameset cols="22%,*" rows="*" border="0" framespacing="0"  marginheight=0 margintop=0> 
	<Frameset rows="15%,*" cols="*"  border="1" scrolling=no  framespacing="0"  marginheight=0 margintop=0 noresize>
		 <frame src="ezCnetDrillDownTree.jsp" name="options" marginwidth="0"  marginheight=0 margintop=0 scrolling="NO" frameborder="NO">	
	</Frameset> 
	<frame src="ezCnetDrillDownDisplay.jsp" name="subDisplay" marginwidth="0"  marginheight=0 margintop=0 scrolling="NO" frameborder="NO">	
	<frame noresize="noresize">
</frameset>

<Body scroll=NO>
<Form name="myForm" method="post">
<input type="hidden" name="execType" value="P">
<input type="hidden" name="addProduct" value="<%=request.getParameter("addProduct")%>">
<input type="hidden" name="FavGroup" value="<%=request.getParameter("FavGroup")%>">
<input type="hidden" name="GroupDesc" value="<%=request.getParameter("GroupDesc")%>">
<input type="hidden" name="searcKey" value="<%=request.getParameter("searcKey")%>">

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>