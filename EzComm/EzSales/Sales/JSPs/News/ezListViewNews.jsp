<%@ include file="../../../Includes/JSPs/News/iListViewNews.jsp"%>
<%

	String newsText		= request.getParameter("hiddenText");
	String newsSub 		= request.getParameter("hiddenSub");
	String redirectPage	= "ezListConfigNews.jsp";
	HashMap ackMap = (HashMap)session.getValue("ACK_STAMP");	
	HashMap newsCnt = (HashMap)session.getValue("NEWS_CNT");	

	if(newsText!=null)
	{
		newsText = newsText.replaceAll("``","\"");
		newsText = newsText.replaceAll("`","\'");
	}
%>

<script type="text/javascript" src="../../Library/Script/jquery-ui-1.8.21.all.min.js"></script>
<script type="text/javascript">
function viewDocs(path)
{
	var dbClickOnFlNm = path
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../News/ezViewNewsFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm);
	}	

}
function funBack()
{
	document.myForm.action="ezListConfigNews.jsp";
	document.myForm.submit();
}

$(function() {
	$( "#dialog-Alert" ).dialog({
		autoOpen: false,
		resizable: false,
		height:150,
		width:300,
		modal: true,
		buttons: {
			"Ok": function() {
				$( this ).dialog( "close" );
			}
		}
	});
		
}); // end of function()


</Script>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main roundedCorners" style="width:665px;">
<div class="my-account">
<div class="dashboard">
<form name="myForm" method="post">
<div id="dialog-Alert" title="Acknowledge" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Please Acknowledge to go back.</p>
</div>

<div class="col1-set">
<div class="info-box">


	<table class="data-table" id="quickatp">
	<thead>
		<tr>
		<th align="a-justify"> Viewing - <%=newsSub%></th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td><h3></h3>
			<%=newsText%>
		</td>
	</tr>
	
<%
	if(uploadDocs!=null && uploadDocs.getRowCount()>0)
	{
%>
	<tr>
	<td>
<%	
		for(int i=0;i<uploadDocs.getRowCount();i++)
		{
			fileName=uploadDocs.getFieldValueString(i,"CLIENTFILENAME");
			tempPath=uploadDocs.getFieldValueString(i,"SERVERFILENAME");
%>			
			<a href="javascript:viewDocs('<%=tempPath%>')"><%=fileName%></a>
<%				
		}
	}
%>
		
	</td>
	</tr>
	
	</tbody>
	</table>
	<div class="buttons-set form-buttons">
		 <button type="button" class="button" onClick="funBack()"><span><span>Back</span></span></button>
	 </div>	 
</div>
</div>

</div>
</div>
</div>
<div class="col-left sidebar roundedCorners" style="width:209px !important">
	<div class="block">
	<div class="block-title"><strong><span>News</span></strong></div>
	<div class="block-content">
	<ul>
		<li><a href="ezConfigureNews.jsp">Configure News</a></li>
		<li class="current"><Strong>News List</strong></li>
	</ul>
	</div>
	</div>
</div>
</div>
</div>
</form>