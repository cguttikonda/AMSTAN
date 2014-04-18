function deleteRepository(B,C){var A=confirm("Are you sure you want to remove this repository? \n "+C);
if(A){AJS.$.ajax({url:BASE_URL+"/rest/bitbucket/1.0/repository/"+B,type:"DELETE",success:function(D){window.location.reload()
}})
}}function toggleMoreFiles(A){AJS.$("#"+A).toggle();
AJS.$("#see_more_"+A).toggle();
AJS.$("#hide_more_"+A).toggle()
}function retrieveSyncStatus(){AJS.$.getJSON(BASE_URL+"/rest/bitbucket/1.0/repositories",function(A){AJS.$.each(A.repositories,function(B,E){var G=AJS.$(".gh_messages.repository"+E.id+" .content");
var D=AJS.$(".syncicon.repository"+E.id);
var C;
var F;
if(E.sync){if(E.sync.isFinished){F="finished";
C="<strong>Sync Finished:</strong>"
}else{F="running";
C="<strong>Sync Running:</strong>"
}C=C+" Synchronized <strong>"+E.sync.changesetCount+"</strong> changesets, found <strong>"+E.sync.jiraCount+"</strong> matching JIRA issues";
if(E.sync.error){F="error";
C=C+'<div class="error"><strong>Sync Failed:</strong> '+E.sync.error+"</div>"
}}else{F="";
C="No information about sync available"
}D.removeClass("finished").removeClass("running").removeClass("error").addClass(F);
G.html(C)
});
window.setTimeout(retrieveSyncStatus,4000)
})
}function forceSync(A){AJS.$.post(BASE_URL+"/rest/bitbucket/1.0/repository/"+A+"/sync");
retrieveSyncStatus()
}function submitFunction(A){var C=AJS.$("#url").val();
var B=BASE_URL+"/rest/bitbucket/1.0/urlinfo?repositoryUrl="+encodeURIComponent(C);
AJS.$("#aui-message-bar").empty();
AJS.messages.generic({title:"Working...",body:"Trying to connect to the repository."});
AJS.$.getJSON(B,function(D){if(D.repositoryType=="github"){AJS.$("#repoEntry").attr("action",BASE_URL+"/secure/admin/AddGithubRepository!default.jspa")
}else{if(D.repositoryType=="bitbucket"){AJS.$("#repoEntry").attr("action",BASE_URL+"/secure/admin/AddBitbucketRepository!default.jspa")
}}AJS.$("#isPrivate").val(D.isPrivate);
AJS.$("#repoEntry").submit()
}).error(function(D){AJS.$("#aui-message-bar").empty();
AJS.messages.error({title:"Error!",body:"The repository url [<b>"+AJS.$("#url").val()+"</b>] is incorrect or the repository is not responding."})
});
return false
}AJS.$(document).ready(function(){if(typeof init_repositories=="function"){init_repositories()
}});
