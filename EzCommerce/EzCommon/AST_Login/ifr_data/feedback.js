AJS.$(function(){var E=AJS.$("#footer-build-information").text(),I='<form action="{baseurl}/rest/feedback/1.0/provide/{timestamp}" id="feedback-form" method="post" class="aui">\n    <div class="content-body">\n        <p>{feedbackHelp}</p>\n        <p>{privacy}</p>\n\n        <div id="desc-group" class="field-group">\n            <label for="description">{descriptionLabel}<span class="aui-icon icon-required"></span></label><textarea class="textarea long-field" id="description" name="description"></textarea>\n        </div>\n        <div id="screenshot-group" class="field-group">\n            <label for="screenshot">{screenshotLabel}</label><input type="file" name="screenshot" class="file" id="screenshot">\n        </div>\n        <div id="name-group" class="field-group">\n            <label for="fullname">{nameLabel}</label><input type="text" name="fullname" class="text" id="fullname"></div>\n        <div id="email-group" class="field-group">\n            <label for="email">{emailLabel}</label><input type="text" name="email" class="text" id="email">\n            <div class="description">{emailDescription}</div>\n        </div>\n        <input type="hidden" name="version" id="version" value="{version}">\n        <input type="hidden" name="location" id="location" value="{windowLocation}">\n        <input type="hidden" name="userAgent" id="userAgent" value="{userAgent}">        \n    </div>\n</form>',G=function(K){if(AJS.$.browser.msie&&K.indexOf("\\")>=0){K=K.substring(K.lastIndexOf("\\")+1)
}return K
},C=function(){AJS.$("#feedback-dialog .dialog-button-panel").addClass("loading throbber");
AJS.$("#feedback-dialog .submit-button").attr("disabled","true")
},F=function(K){if(K){AJS.$("#feedback-dialog").find(".submit-button").remove()
}else{AJS.$("#feedback-dialog").find(".submit-button").removeAttr("disabled")
}AJS.$("#feedback-dialog .dialog-button-panel").removeClass("loading").removeClass("throbber")
},J=function(K){return AJS.$("<form method='post' enctype='multipart/form-data' action='"+contextPath+"/rest/feedback/1.0/provide/"+K+"/files'/>").hide()
},D=function(M){AJS.$("#feedback-form").remove();
var K=AJS.template(I);
var L={baseurl:contextPath,timestamp:M,feedbackHelp:"As we introduce new features in our products we would like to get your feedback to see if these are useful additions. Please use the form below to tell us about something that you love or hate when you use JIRA!",descriptionLabel:"Tell us what you think",screenshotLabel:"Upload a screenshot",nameLabel:"Name",emailLabel:"E-mail",emailDescription:"Feel free to leave feedback anonymously, however providing your contact details will allow us to notify you when we\'\'ve addressed your feedback in a release.",version:E.substr(1,E.length-2),windowLocation:window.location,userAgent:navigator.userAgent,privacy:"When you send feedback to Atlassian, information about what browser you\'\'re using and which plugins you have installed will also be included.  If you do not wish to share this information simply close this dialog."};
return K.fill(L).toString()
},A=function(){if(AJS.params.baseURL&&AJS.params.baseURL.indexOf("sandbox.onjira.com")>=0){return true
}if(/.*v[0-9](\.[0-9])+\-(rc[0-9]+)|(SNAPSHOT)|(beta[0-9]+)|(m[0-9]+).*/.test(E)){return true
}if(AJS.$(".licensemessagered:contains('JIRA evaluation license')").length>0){return true
}return false
};
if(A()){var H=AJS.$('<a class="feedback-link spch-bub-inside" href="#"><span class="point"></span><em>'+"GOT FEEDBACK?"+"</em></a>");
AJS.$("#header-top").append(H);
var B=function(L){var K=AJS.$("#feedback-form");
K.find("#screenshot-group").remove();
var M=K.find("#description").val();
if(!M||M.length==0){alert("Please enter some feedback!");
return 
}K.ajaxForm({timeout:0,beforeSubmit:function(){C()
},success:function(){K.parent().html('<div class="content-body"><p>'+"Thanks for providing your feedback!"+"</p></div>");
F(true)
},error:function(){K.parent().html('<div class="content-body"><p>'+"Thanks for providing your feedback!"+"</p></div>");
F(true)
}});
K.submit()
};
H.click(function(M){M.preventDefault();
AJS.$("#feedback-dialog").remove();
var L=new Date().getTime();
var K=new AJS.Dialog({width:690,height:515,id:"feedback-dialog"});
K.addHeader("Got Feedback?");
K.addPanel("Panel 1",D(L),"panel-body");
K.addButton("Send Feedback",B,"submit-button");
K.addLink("Close",function(N){N.remove()
});
AJS.$("#screenshot").change(function(O){var N=J(L);
var P=AJS.$(this);
N.append(P);
AJS.$("body").append(N);
N.ajaxForm({timeout:0,cleanupAfterSubmit:function(){F(false);
N.remove()
},beforeSubmit:function(){C();
AJS.$("#screenshot-group").append(G(P.val()))
},error:function(Q){F(false);
N.remove()
},success:function(Q){F(false);
N.remove()
}});
N.submit()
});
K.show()
})
}});
