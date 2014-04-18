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
<%

	String categoryID = request.getParameter("categoryID");
	String categoryDesc = request.getParameter("categoryDesc"); 

%>
<frameset cols="20%,*" rows="*" border="0" framespacing="0"  marginheight=0 margintop=0 noresize> 
		<frame src="ezCnetCategoryAttrWait.jsp?categoryID=<%=categoryID%>&categoryDesc=<%=categoryDesc%>&STYPE=BY_CAT" name="categoryOpt" marginwidth="0"  marginheight=0 margintop=0 scrolling="NO" frameborder="NO" >	
		<frame src="ezCnetPrdListByCategoryWait.jsp?categoryID=<%=categoryID%>&categoryDesc=<%=categoryDesc%>&STYPE=BY_CAT" name="prdList" marginwidth="0"  marginheight=0 margintop=0 scrolling="NO" frameborder="NO" >	
		<frame noresize="noresize">   	
</frameset>
<Body scroll=NO>
<Div id="MenuSol"></Div>
</Body>
</Html>