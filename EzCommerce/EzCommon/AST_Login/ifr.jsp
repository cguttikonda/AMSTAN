<html class="mozilla"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"><style type="text/css">body,td,div,span,p{font-family:arial,sans-serif;}a {color:#0000cc;}a:visited {color:#551a8b;}a:active {color:#ff0000;}body{margin: 0px;padding: 0px;background-color:white;}</style><script src="ifr_data/auth-refresh.js"></script><script>var gadgets=gadgets||{};
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
var gadgets=gadgets||{};
gadgets.window=gadgets.window||{};
gadgets.window.setTitle=function(A){gadgets.rpc.call(null,"set_title",null,A)
};
var _IG_SetTitle=gadgets.window.setTitle;;
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
gadgets.config.init({"rpc":{"useLegacyProtocol":false,"parentRelayUrl":"/plugins/servlet/gadgets/rpc-relay"},"shindig.auth":{"authToken":"atlassian:mQrj5ZHNW0CF3V8fj0Kna8CeSy/vMwnzijHv3h1qi6fGC/F+K7TRlzRg59ORoDLsI+QKCX1TqRmmBqVyUIB7DhbOUnb7eQfjBActpKJkXVshMXGnPoXVri07nk1TegxzLXQfR03qMTyU2I22kLKOj5l/CbGjYzkfyJmB2gdW/x8rqZopeVO2XSMkL4DTtwiebOzQ3ABJEm7AfwASpgcOMcwmdKRYDKLM6mlB8487aCqQlgZgT3O86uDTz71/N1QAdHGmELLaL1gs/1NXWP3nZP3OZgc="},"core.util":{"gadget-directory":{"categories":"\n                JIRA\n            "},"dynamic-height":{},"auth-refresh":{},"oauthpopup":{},"settitle":{},"atlassian.util":{}},"atlassian.util":{"baseUrl":"https://ezsuite.atlassian.net"},"core.io":{"jsonProxyUrl":"/plugins/servlet/gadgets/makeRequest","proxyUrl":"%rawurl%"}});
</script><script>gadgets.Prefs.setMessages_({"gadget.common.invalid.period":"Invalid period ''{0}'' specified","gadget.common.cumulative.description":"Progressively add totals (1.. 2.. 3), or show individual values (1.. 1.. 1).","gadget.common.advanced.search":"Advanced Search","gadget.introduction.description":"An introduction to this installation of JIRA.","gadget.common.categories.all":"All Categories","gadget.common.oauth.approve.button":"Login & approve","gadget.common.issuesresolved":"Issues Resolved","gadget.common.days.description":"Days (including today) to show in the graph.","gadget.introduction.gh101.title":"Introductory guide to GreenHopper","gadget.common.cumulative.label":"Cumulative Totals:","gadget.common.required.query":"No project or filter specified.","gadget.common.columns.to.display.label":"Columns to display","gadget.common.projects.description":"The projects to display information for.","gadget.common.stattype.label":"Statistic Type:","gadget.common.period.daily":"Daily","gadget.common.container.oauth.required":"Authentication required to use this gadget","gadget.common.projects.and.categories.description":"Projects or categories to use as the basis for the graph.","gadget.common.quick.find":"Quick Find","gadget.common.period.hourly":"Hourly","gadget.common.invalid.stat.type":"Invalid Statistics Type ({0})","gadget.common.invalid.jql":"Invalid JQL.","gadget.introduction.jira.training.title":"Official JIRA and Confluence Training","gadget.common.manage.filters":"Manage Filters","gadget.common.invalid.project":"Invalid project","gadget.common.invalid.filter.id":"Invalid filter","gadget.common.filter.description":"Saved filter to use for the query.","gadget.common.period.yearly":"Yearly","gadget.common.period.name.label":"Period:","gadget.common.show.column.headers.description":"Helps to distinguish between similar fields","gadget.common.invalid.filter":"Invalid project or filter","gadget.common.show.column.headers.label":"Show column headers","gadget.introduction.gh101":"The {0}GreenHopper{1} plugin for JIRA provides agile project management and assists with the introduction of agile to your team. Get started with the {2}GreenHopper 101 guide{3}.","gadget.common.container.login":"You must be logged in to view this gadget.","gadget.common.oauth.approve.message":"If you are a registered user of JIRA, there may be more information available to you. You will need to log in to JIRA and approve this gadget''s access to your account. (<a class='ag-show-requests' href=\"#\">Show Restricted URLs<\/a>)","gadget.common.error.500":"An internal server error occurred when requesting resource <a href=\"{0}\" target=\"_parent\">{1}<\/a>.","gadget.common.negative.days":"Days must be greater or equal to zero.","gadget.common.days.overlimit":"Days must not exceed {0}","gadget.common.show.column.headers.true.label":"Yes","gadget.common.filter.label":"Saved Filter:","gadget.common.num.description":"Number of results to display (maximum of 50).","gadget.common.default.columns":"Default Columns","gadget.introduction.gh.website.title":"GreenHopper Homepage","gadget.common.project.edit":"Click here to select/change project.","gadget.common.unknown.legacy.portlet":"Unknown Legacy Portlet","gadget.common.period.name.description":"The length of periods represented on the graph.","gadget.common.issue":"Issue","gadget.common.indexing.configure":"Please {0}configure indexing{1}.","gadget.common.config.unavailable":"There are problems with the current configuration for this gadget. The errors below may have been caused by the deletion of entities required by the gadget or by changes to your permissions.","gadget.common.unknown.legacy.portlet.description":"Legacy portlet with key ''{0}'' could not be loaded","gadget.common.projects.and.categories.label":"Projects and Categories:","gadget.common.cancel":"Cancel","gadget.introduction.wheredoistart":"{0}Where do I start?{1}","gadget.common.projects.label":"Projects:","gadget.common.configure":"Edit","gadget.introduction.jira.training":"Get up to speed with an in-depth, interactive {0}Atlassian training course{1}.","gadget.common.projects.all":"All Projects","gadget.common.days.nan":"Days must be a number","gadget.common.error.save.dashboard":"Error rendering save to dashboard form.","gadget.common.num.high":"Number must be less than or equal to 50","gadget.common.no":"No","gadget.common.chart.period":"Period: last {0}{1}{2} days (grouped {3}{4}{5})","gadget.common.save":"Save","gadget.common.period.monthly":"Monthly","gadget.introduction.thanksforchoosing.text":"Welcome to JIRA &mdash; the easy way to help your team track and deliver projects.","gadget.common.issues":"Issues","gadget.common.filter":"Filter:","gadget.common.refresh.never":"Never","gadget.common.projects.and.categories.mixed":"You can not mix categories and projects.","gadget.introduction.userguide":"Learn more about using JIRA with the {0}JIRA User''s Guide{1}.","gadget.introduction.createprojects":"You have no projects yet. {0}Create your first project{1}.","gadget.common.num.overlimit":"Number must not exceed {0}","gadget.common.num.negative":"Number must be greater than 0","gadget.common.period.quarterly":"Quarterly","gadget.common.categories":"Categories","gadget.common.add.filter":"Add filter","gadget.common.authrequired":"Please login <strong>OR<\/strong> contact Administrator to <a href='http://confluence.atlassian.com/display/DOC/External+Gadgets'>configure Application Link<\/a>","gadget.common.period.name":"Period","gadget.common.issuesunresolved":"Issues Unresolved","gadget.common.required.project.or.filter":"Please select a filter or project","gadget.common.show.column.headers.false.label":"No","gadget.common.period.weekly":"Weekly","gadget.common.filterid.edit":"Click here to select/change filter or project.","gadget.common.all.projects.and.others":"''All Projects'' can not be selected along with other projects","gadget.common.indexing":"Indexing is currently not configured so no issue searching can be performed.","gadget.common.projects":"Projects","gadget.common.columns.to.display.description":"Default columns:","gadget.common.filterid.none.selected":"No Filter/Project selected","gadget.common.refresh.description":"How often you would like this gadget to update","gadget.common.filters":"Filters","gadget.common.filterid.description":"Project or saved filter to use as the basis for the graph.","gadget.common.error.404":"The resource <a href=\"{0}\" target=\"parent\">{1}<\/a>, cannot be found.","gadget.common.days.overlimit.for.period":"Days must not exceed {0} for {1} period","gadget.introduction.jira101":"Learn more about configuring JIRA with the {0}JIRA 101 guide{1}.","gadget.common.error.generation":"Unfortunately, one or more of your preferences are now unavailable. Please update your preferences, or remove gadget by clicking delete from the title bar above.","gadget.common.refresh.minutes":"Every {0} Minutes","gadget.common.num.label":"Number of Results:","gadget.common.all.categories.and.others":"''All Categories'' can not be selected along with other categories","gadget.common.project.none.selected":"No project selected","gadget.common.anonymous.is.invalid":"This gadget requires a logged in user.","gadget.common.indexing.admin":"Please contact your administrator to get indexing configured.","gadget.common.project.description":"Project to use as the basis for the graph.","gadget.introduction.thanksforchoosing.title":"{0}Thanks for choosing JIRA.{1}","gadget.common.no.filter.id":"You must specify a filter.","gadget.common.days.label":"Days Previously:","gadget.introduction.agile.management":"{0}Agile project management for JIRA{1}","gadget.common.anonymous.filter":"Anonymous Filter","gadget.common.projects.and.categories.none.selected":"No project/category selected","gadget.common.num.nan":"The value must be an integer greater than 0 and less than or equal to 50","gadget.common.refresh.hours":"Every {0} Hours","gadget.common.project.label":"Project:","gadget.common.invalid.projectOrFilterId":"Invalid project or filter","gadget.common.invalid.projectOrFilterId.query.prefix":"Your query can not start with ''*'' or ''?''","gadget.introduction.title":"Introduction","gadget.common.refresh.label":"Refresh Interval:","gadget.common.stattype.description":"Select which type of statistic to display for this filter.","gadget.common.filterid.label":"Project or Saved Filter:","gadget.common.refresh.hour":"Every {0} Hour","gadget.common.invalid.filter.validationfailed":"The selected filter {0} has an error: {1}.","gadget.common.yes":"Yes","gadget.introduction.editintro":"You can {0}customise this text{1} in the Administration section.","gadget.common.reload":"Refresh","gadget.common.filter.none.selected":"No Filter selected","gadget.common.invalid.projectCategory":"Invalid Project Category"});gadgets.Prefs.setDefaultPrefs_({});gadgets.io.preloaded_={};</script></head><body class="" dir="ltr">


<link href="ifr_data/com_002.css" media="all" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<link type="text/css" rel="stylesheet" href="ajs-gadgets.css?conditionalComment=lt+IE+9" media="all">
<![endif]-->
<link href="ifr_data/com_004.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data/com_003.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data/jira.css" media="all" rel="stylesheet" type="text/css">
<link href="ifr_data/com.css" media="all" rel="stylesheet" type="text/css">
<script src="ifr_data/com.js" type="text/javascript"></script>
<script src="ifr_data/com_003.js" type="text/javascript"></script><div id="ag-sys-msg"></div>
<script src="ifr_data/com_002.js" type="text/javascript"></script>
<script src="ifr_data/jira.js" type="text/javascript"></script>
<script src="ifr_data/com_004.js" type="text/javascript"></script>
        
        <div class="gadget">
        	<div class="view g-intro">
        		<div class="intro">
        			<img  src="ifr_data/intro-gadget.png" style="position:absolute;height:64px;left:-71px;top:0;width:65px;">
        			<h1>Welcome</h1>
        				<p>Thank you for considering our bath & kitchen products for your business. We ve organized everything you need for your
        					project, from spec sheets to installation instructions, into categories on the left.Spend some time with us and get to know why
        					American Standard is once again the buzz of the industry, beating well-established bath & kitchen brands in style, satisfaction and
        					top-ranked performance.
        				</p>
        		</div>
        	</div>
        </div>

    </body></html>