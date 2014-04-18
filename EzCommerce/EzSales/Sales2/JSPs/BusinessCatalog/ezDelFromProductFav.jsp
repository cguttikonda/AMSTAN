<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iDelFromProductFav.jsp"%>
<%
	//Redirect to FavGroup Details page
	response.sendRedirect("ezFavGroupFinalLevel.jsp?ProductGroup=" + prodfavgroup+"&GroupDesc="+GroupDesc+"&personalize=Y");
%>

