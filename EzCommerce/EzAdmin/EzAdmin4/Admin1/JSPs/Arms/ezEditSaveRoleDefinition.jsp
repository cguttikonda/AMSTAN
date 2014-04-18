<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%  
	String roleNr=request.getParameter("roleNr");
	String roleType=request.getParameter("roleType");
	String language=request.getParameter("language");
	String roleDesc=request.getParameter("roleDesc");
	String roleDel=request.getParameter("roleDel");
	String busComp = request.getParameter("busComp");
	String busDom = request.getParameter("busDom");
	try
	{    
		if(!(roleDel.equals("Y")) || roleDel==null)
			roleDel="N";
	}
	catch(NullPointerException npe)
	{	
		roleDel="N";
	}  
%>
<%@ include file="../../../Includes/JSPs/Arms/iEditSaveRoleDefinition.jsp"%>