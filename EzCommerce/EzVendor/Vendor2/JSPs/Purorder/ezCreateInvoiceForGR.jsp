<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Html>
<Head>
	<script language="JavaScript">
	function fun1()
	{	
		document.forms[0].action="ezListOpenGrs.jsp";
		document.forms[0].submit();
	}
	</script>
</Head>
<Body>


<form onSubmit="return false">
<input type="hidden" name="RefDoc">
<input type="hidden" name="Status">
<input type="hidden" name="PostingDate">
</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%@ include file="../../../Includes/JSPs/Purorder/iCreateInvoiceForGR.jsp" %>
