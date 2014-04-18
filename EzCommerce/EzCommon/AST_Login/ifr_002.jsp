<html class="mozilla">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<style type="text/css">body,td,div,span,p{font-family:arial,sans-serif;}a {color:#0000cc;}a:visited {color:#551a8b;}a:active {color:#ff0000;}body{margin: 0px;padding: 0px;background-color:white;}</style>
<script src="ifr_data/auth-refresh.js"></script>
<script>var gadgets=gadgets||{};
gadgets.window=gadgets.window||{};
(function(){gadgets.window.getViewportDimensions=function(){var A,B;
if(self.innerHeight){A=self.innerWidth;
B=self.innerHeight
}else{if(document.documentElement&&document.documentElement.clientHeight){A=document.documentElement.clientWidth;
B=document.documentElement.clientHeight
}else{if(document.body){A=document.body.clientWidth;
B=document.body.clientHeight
}else{A=0;
B=0
}}}return{width:A,height:B}
}
})();;
var gadgets=gadgets||{};
gadgets.window=gadgets.window||{};
(function(){var C;
function A(F,D){var E=window.getComputedStyle(F,"");
var G=E.getPropertyValue(D);
G.match(/^([0-9]+)/);
return parseInt(RegExp.$1,10)
}function B(){var D=0;
var G=document.body.childNodes;
for(var F=0;
F<G.length;
F++){if(typeof G[F].offsetTop!=="undefined"&&typeof G[F].offsetHeight!=="undefined"){var E=G[F].offsetTop+G[F].offsetHeight+A(G[F],"margin-bottom");
D=Math.max(D,E)
}}return D+A(document.body,"border-bottom")+A(document.body,"margin-bottom")+A(document.body,"padding-bottom")
}gadgets.window.adjustHeight=function(I){var F=parseInt(I,10);
var E=false;
if(isNaN(F)){E=true;
var K=gadgets.window.getViewportDimensions().height;
var D=document.body;
var J=document.documentElement;
if(document.compatMode==="CSS1Compat"&&J.scrollHeight){F=J.scrollHeight!==K?J.scrollHeight:J.offsetHeight
}else{if(navigator.userAgent.indexOf("AppleWebKit")>=0||(document.documentMode&&document.documentMode!==5)){F=B()
}else{if(D&&J){var G=J.scrollHeight;
var H=J.offsetHeight;
if(J.clientHeight!==H){G=D.scrollHeight;
H=D.offsetHeight
}if(G>K){F=G>H?G:H
}else{F=G<H?G:H
}}}}}if(F!==C&&!isNaN(F)&&!(E&&F===0)){C=F;
gadgets.rpc.call(null,"resize_iframe",null,F)
}}
}());
var _IG_AdjustIFrameHeight=gadgets.window.adjustHeight;;
var gadgets=gadgets||{};
gadgets.views=function(){var D=null;
var A={};
var C={};
function B(H){var E=H.views;
for(var K in E){if(E.hasOwnProperty(K)){var L=E[K];
if(!L){continue
}A[K]=new gadgets.views.View(K,L.isOnlyVisible);
var F=L.aliases||[];
for(var J=0,I;
I=F[J];
++J){A[I]=new gadgets.views.View(K,L.isOnlyVisible)
}}}var G=gadgets.util.getUrlParameters();
if(G["view-params"]){C=gadgets.json.parse(G["view-params"])||C
}D=A[G.view]||A["default"]
}gadgets.config.register("views",null,B);
return{bind:function(T,R){if(typeof T!="string"){throw new Error("Invalid urlTemplate")
}if(typeof R!="object"){throw new Error("Invalid environment")
}var P=/^([a-zA-Z0-9][a-zA-Z0-9_\.\-]*)(=([a-zA-Z0-9\-\._~]|(%[0-9a-fA-F]{2}))*)?$/,V=new RegExp("\\{([^}]*)\\}","g"),S=/^-([a-zA-Z]+)\|([^|]*)\|(.+)$/,L=[],O=0,J,I,G,N,K,F,M,Q;
function H(X,W){return R.hasOwnProperty(X)?R[X]:W
}function E(W){if(!(I=W.match(P))){throw new Error("Invalid variable : "+W)
}}function U(a,W,Z){var X,Y=a.split(",");
for(X=0;
X<Y.length;
++X){E(Y[X]);
if(Z(W,H(I[1]),I[1])){break
}}return W
}while(J=V.exec(T)){L.push(T.substring(O,J.index));
O=V.lastIndex;
if(I=J[1].match(P)){G=I[1];
N=I[2]?I[2].substr(1):"";
L.push(H(G,N))
}else{if(I=J[1].match(S)){K=I[1];
F=I[2];
M=I[3];
Q=0;
switch(K){case"neg":Q=1;
case"opt":if(U(M,{flag:Q},function(X,W){if(typeof W!="undefined"&&(typeof W!="object"||W.length)){X.flag=!X.flag;
return 1
}}).flag){L.push(F)
}break;
case"join":L.push(U(M,[],function(Y,X,W){if(typeof X==="string"){Y.push(W+"="+X)
}}).join(F));
break;
case"list":E(M);
value=H(I[1]);
if(typeof value==="object"&&typeof value.join==="function"){L.push(value.join(F))
}break;
case"prefix":Q=1;
case"suffix":E(M);
value=H(I[1],I[2]&&I[2].substr(1));
if(typeof value==="string"){L.push(Q?F+value:value+F)
}else{if(typeof value==="object"&&typeof value.join==="function"){L.push(Q?F+value.join(F):value.join(F)+F)
}}break;
default:throw new Error("Invalid operator : "+K)
}}else{throw new Error("Invalid syntax : "+J[0])
}}}L.push(T.substr(O));
return L.join("")
},requestNavigateTo:function(E,G,F){gadgets.rpc.call(null,"requestNavigateTo",null,E.getName(),G,F)
},getCurrentView:function(){return D
},getSupportedViews:function(){return A
},getParams:function(){return C
}}
}();
gadgets.views.View=function(A,B){this.name_=A;
this.isOnlyVisible_=!!B
};
gadgets.views.View.prototype.getName=function(){return this.name_
};
gadgets.views.View.prototype.getUrlTemplate=function(){return gadgets.config&&gadgets.config.views&&gadgets.config.views[this.name_]&&gadgets.config.views[this.name_].urlTemplate
};
gadgets.views.View.prototype.bind=function(A){return gadgets.views.bind(this.getUrlTemplate(),A)
};
gadgets.views.View.prototype.isOnlyVisibleGadget=function(){return this.isOnlyVisible_
};
gadgets.views.ViewType=gadgets.util.makeEnum(["CANVAS","HOME","PREVIEW","PROFILE","FULL_PAGE","DASHBOARD","POPUP"]);;
var gadgets=gadgets||{};
gadgets.oauth=gadgets.oauth||{};
gadgets.oauth.Popup=function(A,D,B,C){this.destination_=A;
this.windowOptions_=D;
this.openCallback_=B;
this.closeCallback_=C;
this.win_=null
};
gadgets.oauth.Popup.prototype.createOpenerOnClick=function(){var A=this;
return function(){A.onClick_()
}
};
gadgets.oauth.Popup.prototype.onClick_=function(){this.win_=window.open(this.destination_,"_blank",this.windowOptions_);
if(this.win_){var A=this;
var B=function(){A.checkClosed_()
};
this.timer_=window.setInterval(B,100);
this.openCallback_()
}return false
};
gadgets.oauth.Popup.prototype.checkClosed_=function(){if((!this.win_)||this.win_.closed){this.win_=null;
this.handleApproval_()
}};
gadgets.oauth.Popup.prototype.handleApproval_=function(){if(this.timer_){window.clearInterval(this.timer_);
this.timer_=null
}if(this.win_){this.win_.close();
this.win_=null
}this.closeCallback_();
return false
};
gadgets.oauth.Popup.prototype.createApprovedOnClick=function(){var A=this;
return function(){A.handleApproval_()
}
};
gadgets.oauth.Popup.setReceivedCallbackUrl=function(A){gadgets.oauth.Popup.receivedCallbackUrl_=A
};
gadgets.oauth.Popup.getReceivedCallbackUrl=function(){return gadgets.oauth.Popup.receivedCallbackUrl_
};;
var atlassian = atlassian || {};

atlassian.util = function() {

    var config = config || {};

    function init(configuration) {
        config = configuration["atlassian.util"];
    }

    var requiredConfig = {
        baseUrl: gadgets.config.NonEmptyStringValidator
    };
    gadgets.config.register("atlassian.util", requiredConfig, init);

    return {
      getRendererBaseUrl : function() {
        return config.baseUrl;
      }
    };

}();;
gadgets.config.init({"rpc":{"useLegacyProtocol":false,"parentRelayUrl":"/plugins/servlet/gadgets/rpc-relay"},"shindig.auth":{"authToken":"atlassian:YPgKpNOomJi/Zfkm4NFOIWenewj0Al1V14I3DGNBPTDg0O+fSFBEXucdWpeF61sROJ/moHcMdRNepPjaVEsm7hhMc58YQjWYp18b36PPkl9q0b0WTudLX8QnpqrxyBf+6+DV7mP4mJMJU19AWtMd9F5OEydyS/E82PucVzzX/ZJyq1U6LbidXCDuxtxRCNtuj+EWX+b1hP+DZ3fDSVKn+8xrKScmUsHZQS4Wp29MJGbds+jq"},"views":{"default":{"isOnlyVisible":false,"urlTemplate":"http://localhost/gadgets/profile?{var}","aliases":["DEFAULT","DASHBOARD","profile","home"]},"canvas":{"isOnlyVisible":true,"urlTemplate":"http://localhost/gadgets/canvas?{var}","aliases":[]}},"core.util":{"dynamic-height":{},"views":{},"auth-refresh":{},"oauthpopup":{},"atlassian.util":{}},"atlassian.util":{"baseUrl":"https://ezsuite.atlassian.net"},"core.io":{"jsonProxyUrl":"/plugins/servlet/gadgets/makeRequest","proxyUrl":"%rawurl%"}});
</script>



 <link href="ifr_data/com_002.css" media="all" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<link type="text/css" rel="stylesheet" href="https://ezsuite.atlassian.net/s/en_USwcfkxd/663/45/3.4.2/_/download/batch/com.atlassian.auiplugin:ajs-gadgets/com.atlassian.auiplugin:ajs-gadgets.css?conditionalComment=lt+IE+9" media="all">
<![endif]-->
<link href="ifr_data/com_004.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data/com_003.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data/jira.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data/com.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data_002/jira.css" media="all" rel="stylesheet" type="text/css">
<script src="ifr_data/com_003.js" type="text/javascript"></script>
<script src="ifr_data/com_002.js" type="text/javascript"></script><div id="ag-sys-msg"></div>
<script src="ifr_data/com.js" type="text/javascript"></script>
<script src="ifr_data/jira.js" type="text/javascript"></script>
<script src="ifr_data/com_004.js" type="text/javascript"></script>
<script src="ifr_data_002/jira.js" type="text/javascript"></script>
<script src="ifr_data_002/com.js" type="text/javascript"></script>


        <script type="text/javascript">
	function checkFields()
	{
		if((document.loginform.username.value=='')||(document.loginform.password.value== ''))
		{
			if(document.loginform.username.value=='')
			{
				alert("Enter UserID");
				document.loginform.username.focus();
				return false;
			}
			if(document.loginform.password.value== '')
			{
				alert("Enter Password");
				document.loginform.password.focus();
				return false;
			}
		}
		return true;
	}
	function funSubmit()
	{
		if(checkFields())
		{
			var userName=document.loginform.username.value
			var userPass=document.loginform.password.value
				
			top.window.parent.location="../../EzCommerce/EzCommon/JSPs/ezApplicationAreas.jsp?username="+userName+"&password="+userPass
			return true;
		}
		else
		{
			return false;
		}
	}
	function KeySubmit()
	{
		if (event.keyCode==13)
			funSubmit()
	}         
            
        </script>
        <div class="gadget default">
        	<div class="view g-login">
        		<div id="content" class="">
				<form id="loginform" method="post"  name="loginform" class="aui gdt top-label">
					<div class="field-group">
						<label accesskey="u" for="login-form-username" id="usernamelabel">
							<u>U</u>sername</label><input class="text medium-field" id="login-form-username" name="username"type="text">
					</div>
					<div class="field-group password">
						<label accesskey="p" for="login-form-password"id="passwordlabel">
						<u>P</u>assword</label><input class="text medium-field" id="login-form-password" name="password" type="password">
						<input type=hidden  size=15 name=site value=200>
					</div>
					<fieldset class="group">
						<div class="checkbox" id="rememberme">
							<input class="checkbox" id="login-form-remember-me" name="os_cookie" value="true" type="checkbox">
							<label accesskey="r" for="login-form-remember-me" id="remembermelabel">
							<u>R</u>emember my login on this computer
							</label>
						</div>
					</fieldset>
					<div class="field-group" id="publicmodeooff">
						<div id="publicmodeoffmsg">Not a member? To request an account, please <a target="_parent" id="contact-admin" href="register.jsp">CLICK </a>here
							to register with American Standards.</div>
						</div>
					<div class="buttons-container">
						<div class="buttons"><input class="button" id="login" name="login" value="Log In" type="submit" onClick="funSubmit()"><a class="cancel" href="password.jsp" id="forgotpassword" target="_parent">Can't access your account?</a>
						</div>
						</div>
				</form>
			</div>
      	 	</div>
      </div>

   </body>
</html>