

<html>
<style>
</style>
<%@ include file="../../../Includes/JSPs/Misc/iNews.jsp"%>
<%
	if(vectSize>0)
	{
%>
		<Div id='inputDiv1' style='position:absolute;align:center;valign:top;top:20%;width:100%;height:10%'>
		<Table width="60%" height="60%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
				<Table width="100%" border="0" cellspacing="0" cellpadding="0">
				<Tr >
					<Td style="background-color:'F3F3F3'" width="10%" align="left" valign=top class=newslabel>
						<span title="News From Kiss"><B>News</B></span>
					</Td>
				<Tr>
				<Tr height=40px>
					<Td style="background-color:'F3F3F3'" align="left" valign=top>
						<script language=JavaScript1.2>
							n_font='verdana,arial,sans-serif';
							n_fontSize='10px';
							n_fontSizeNS4='11px';
							n_fontWeight='bold';
							n_fontColor='#00385D';
							n_textDecoration='underline';
							n_fontColorHover='#cee0ef';//		| won't work
							n_textDecorationHover='underline';//	| in Netscape4
							n_bgColor='';//set [='transparent'] for transparent
							n_top=0;//	|
							n_left=0;//	| defining
							n_width='100%';//	| the box
							n_height=24;//	|
							n_position='relative';// absolute/relative
							n_timeOut=5;//seconds
							n_pauseOnMouseOver=true;
							n_speed=10;//1000 = 1 second
							n_leadingSign='';
							n_alternativeHTML='';
							n_float='left';
							n_content=
							[
<%
								for(int v=0;v<vectSize;v++)
								{
									if(v!=(vectSize-1))
									{
%>
										['','<%=newsVector.get(v)%>','new1'],
<%
									}
									else
									{
%>
										['','<%=newsVector.get(v)%>','new1']
<%
									}
								}
%>
							];
							n_nS4=document.layers?1:0;n_iE=document.all&&!window.innerWidth&&navigator.userAgent.indexOf("MSIE")!=-1?1:0;n_nSkN=document.getElementById&&(navigator.userAgent.indexOf("Opera")==-1||document.body.innerHTML)&&!n_iE?1:0;n_t=0;n_cur=0;n_l=n_content[0][1].length;n_timeOut*=2000;n_fontSize2=n_nS4&&navigator.platform.toLowerCase().indexOf("win")!=-1?n_fontSizeNS4:n_fontSize;document.write('<style>.nnewsbar,a.nnewsbar,a.nnewsbar:visited,a.nnewsbar:active{font-family:'+n_font+';font-size:'+n_fontSize2+';color:'+n_fontColor+';text-decoration:'+n_textDecoration+';font-weight:'+n_fontWeight+'}a.nnewsbar:hover{color:'+n_fontColorHover+';text-decoration:'+n_textDecorationHover+'}</style>');n_p=n_pauseOnMouseOver?" onmouseover=clearTimeout(n_TIM) onmouseout=n_TIM=setTimeout('n_new()',"+n_timeOut+")>":">";n_k=n_nS4?"":" style=text-decoration:none;color:"+n_fontColor;function n_new(){if(!(n_iE||n_nSkN||n_nS4))return;var O,mes;O=n_iE?document.all['nnewsb']:n_nS4?document.layers['n_container'].document.layers['nnewsb']:document.getElementById('nnewsb');mes=n_content[n_t][0]!=""&&n_cur==n_l?("<a href='"+n_content[n_t][0]+"' target='"+n_content[n_t][2]+"' class=nnewsbar"+n_p+n_content[n_t][1].substring(0,n_cur)+n_leadingSign+"</a>"):("<span class=nnewsbar"+n_k+">"+n_content[n_t][1].substring(0,n_cur)+n_leadingSign+"</span>");if(n_nS4)with(O.document){open();write(mes);close()}else O.innerHTML=mes;if(n_cur++==n_l){n_cur=0;n_TIM=setTimeout("n_new()",n_timeOut);n_t++;if(n_t==n_content.length)n_t=0;n_l=n_content[n_t][1].length}else{setTimeout("n_new()",n_speed)}};document.write('<div '+(n_nS4?"name":"id")+'=n_container style="position:'+n_position+';top:'+n_top+'px;left:'+n_left+'px;width:'+n_width+';height:'+n_height+'px;clip:rect(0,'+n_width+','+n_height+',0)"><div '+(n_nS4?"name":"id")+'=nnewsb style="position:absolute;top:0px;left:0px;width:'+n_width+';height:'+n_height+'px;clip:rect(0,'+n_width+','+n_height+',0);background-color:'+n_bgColor+';layer-background-color:'+n_bgColor+';text-decoration:none;color:'+n_fontColor+'" class=nnewsbar>'+n_alternativeHTML+'</div></div>');if(!n_nS4)setTimeout("n_new()",1000);else window.onload=n_new;if(n_nS4)onresize=function(){location.reload()}
						</script>
					</Td>
				</Tr>
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>					
<%
	}
%>

