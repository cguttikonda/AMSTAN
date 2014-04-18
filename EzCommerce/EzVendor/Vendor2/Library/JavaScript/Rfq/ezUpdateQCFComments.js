function getList()
{
	document.myForm.submit();				
}
function back()
{
	document.myForm.action="ezSBUWelcome.jsp";
	document.myForm.submit();				
}

function funOpenReplyWin(qcf_code,qcf_comment_no,qcf_dest_user,qcf_user,qcf_comments)
{
	newWindow=window.showModalDialog("ezQCFCommentsWindow.jsp?qcf_code="+qcf_code+"&qcf_comment_no="+qcf_comment_no+"&qcf_comments="+qcf_comments,window.self,"width=500,height=350,left=40,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}