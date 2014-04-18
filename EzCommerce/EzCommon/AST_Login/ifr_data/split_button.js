if(typeof contextPath == "undefined" || contextPath == null) {
    contextPath = "";
}

AJS.toInit(function () {

    // Remove Confluence DropDown Handlers
    AJS.$("#com-atlassian-confluence .nav-dropdowns .ajs-menu-bar *").unbind();

    // Setup the projects dropdown
    initMenuDropdowns();

    // user has not logged in, is it a gapps login?
    if (AJS.$("#studio-gapps-login-link").length != 0) {
        AJS.$.getScript(studioData.jiraUrl + "/plugins/servlet/loginOptions?callback=loginOptionsCallback&loginUrl=" +
                encodeURIComponent(AJS.$("#studio-gapps-login-link").attr("href")));
    }

    // Initialize History Menu
    AJS.$.getScript(studioData.jiraUrl + "/plugins/servlet/studio/browsehistory?callback=historyCallback");
});

// === initialize dropdown menus ===

function initMenuDropdowns()
{
    var isNotConfluence = AJS.$("#com-atlassian-confluence").length == 0;
    if (AJS.dropDown.Standard && isNotConfluence) {
        AJS.dropDown.Standard({
            selector:".ajs-menu-item",
            dropDown:".ajs-drop-down",
            trigger:".trigger",
            hideHandler: function() {
                AJS.$("#studio-header").find(".nav-dropdowns ajs-menu-item.active").removeClass('active');
            },
            selectionHandler: function (e, selected) {
                selected.focus();
            }
        });
        AJS.$(".ajs-drop-down").mousedown(function (e) {
            e.stopPropagation();
        });
        AJS.$(".trigger").mousedown(function (e) {
            var $this = AJS.$(this);
            $this.parent(".ajs-menu-item").addClass("active");
            if ($this.parent(".ajs-menu-item.active").size() > 0) {
                e.stopPropagation();
            }


        });
    } else {

        // Remove the active class for conlfuence dropdown
        AJS.$(document).bind("hideLayer", function(event, type, target) {
            if (type === "dropdown" && target) {
                target.$.parent(".ajs-menu-item").removeClass("active")
            }
        });
        var func = function () {
            var dropDownElement = AJS.$(".ajs-drop-down", this);
            dropDownElement[0].hidden = false;
            var dd = AJS.dropDown(dropDownElement)[0];
            // The studio doc theme adds a menu item that does not include a drop-down. Thus, we need to check that the
            // target drop-down element exists before trying to use it.
            if(dd) {
                dd.hide();

                //this will force all other triggers of menus on the page
                //to hide _this_ menu when clicked. Needed because conf dropdowns doesn't seem to fire the showLayer event
                AJS.$(".trigger").click(function() {
                    if (AJS.dropDown.current == dd) {
                        dd.hide();
                    }
                });

                AJS.$(".trigger", this).click(function (e) {
                    if (AJS.dropDown.current == dd) {
                        dd.hide();
                    } else {
                        //close other ajs-drop-down menus that may be open before showing this one
                        AJS.$(".ajs-drop-down").each(function() {
                            var other = this;
                            //a little more defensive in case somebody decides to (mis)use the same class
                            other.isMenuBarOpened && other.isMenuBarOpened()
                                && other.hide && other.hide();
                        });
                        dd.show();
                        //Add the active class for conlfuence dropdown
                        AJS.$(dd.$).parent(".ajs-menu-item").addClass("active");
                    }
                    return false;
                });
            }
        };
        AJS.$(".studio-header .nav-dropdowns .ajs-menu-item").each(func);
    }
}

function confluenceUserCallback(confluenceUser) {
    var userMenuDropDown = AJS.$(".js-user").next();
    var prefUl = AJS.$("ul.section-user-preferences", userMenuDropDown);
    var s = "";
    if (confluenceUser.personalSpaceUrl) {
        s = '<li><a href="' + confluenceUser.personalSpaceUrl + '">Personal Space</a></li>';
    }
    if (confluenceUser.createPersonalSpaceUrl) {
        s = '<li><a href="' + confluenceUser.createPersonalSpaceUrl + '">Create Personal space</a></li>';
    }
    prefUl.html(s);
}

function historyCallback(historyData) {
    function trimString(string, length) {
        return (string.length>length) ? string.substring(0,length-1)+"&hellip;" : string;
    }
    function addTitle(string, length) {
        return (string.length>length) ? 'title="'+string+'"':'';
    }
    var history = AJS.$(".js-history");
    var dropDown = AJS.$(history.nextAll(".ajs-drop-down")[0]);
    var ul = AJS.$("ul", dropDown);
    var s = "";
    if (!historyData.length) {
        s = "<li><a><span><i>&lt;No history yet&gt;</i></span></a></li>";
    }

    for (var i = 0, ii = historyData.length; i < ii; i++) {
        var it = historyData[i];
        s = '<li><a class="' + it.iconType + '" href="' + it.url + '"><span class="history-item"><span class="history-left"'+addTitle(it.title,35)+'>' + trimString(it.title,35) + '</span><span class="history-right"'+addTitle(it.projectKey,6)+'>' + trimString(it.projectKey,6) + '</span></span></a></li>' + s;
    }
    ul.html(s);
}

function filtersCallback(filterData) {
    var s = "";
    var filter = AJS.$(".js-filter");
    var dropDown = filter.nextAll(".ajs-drop-down");
    var ul = AJS.$("ul", dropDown);

    if(!filterData.length) {
        s = "<li><a><span><i>&lt;No filters found&gt;</i></span></a></li>";
    }
    for (var i = 0, ii = filterData.length; i < ii; i++) {
        var it = filterData[i];
        s = s +'<li><a href="' + it.url + '"><span>' + it.name + "</span></a></li>";
    }

    ul.html(s);
}

function loginOptionsCallback(loginOptions) {
    // if we have more than one login option, create a drop down
    if (loginOptions.length > 1) {
        var loginUrl = AJS.$("#studio-gapps-login-link").attr("href");
        var usermenuDiv = AJS.$("#studio-user-menu-container");
        var dropdown = AJS.$("<div/>").addClass("ajs-drop-down hidden");
        var loginSpan = AJS.$("<span/>").attr("id", "login-span").text("Log In");
        var triggerAnchor = AJS.$("<a/>").attr("id", "studio-gapps-login-link").attr("href", loginUrl)
                .addClass("user ajs-menu-title js-user login-link trigger")
                .append(AJS.$("<span/>").append(loginSpan));
        var menubarUl = AJS.$("<ul/>").addClass("ajs-menu-bar").append(
                AJS.$("<li/>").attr("id", "login-options").addClass("normal ajs-menu-item")
                        .append(triggerAnchor).append(dropdown)
                );
        usermenuDiv.empty().append(menubarUl);

        var dropdownUl = AJS.$("<ul/>").attr("id", "login_ul").addClass("first last").appendTo(dropdown);

        for (var i = 0; i < loginOptions.length; i++) {
            var it = loginOptions[i];
            var anchor = AJS.$("<a/>").attr("href", it.href).text(it.text);
            if (it.id) {
                anchor.attr("id", it.id);
            }
            if (it.classes) {
                anchor.addClass(it.classes);
            }
            if (it.imageUrl) {
                anchor.css("background-image", "url(" + it.imageUrl + ")");
            }
            if (it.title) {
                anchor.attr("title", it.title);
            }
            dropdownUl.append(AJS.$("<li/>").append(anchor));
            if (it.formId) {
                attachLoginOptionForm(it, usermenuDiv);
            }
        }

        var dd = AJS.dropDown(dropdown)[0];
        dd.hide();
        loginSpan.click(function (e) {
            document.location = AJS.$("#studio-gapps-login-link").attr("href");
            return false;
        });
        triggerAnchor.click(function (e) {
            if (AJS.dropDown.current == dd) {
                dd.hide();
            }
            else {
                dd.show();
            }
            return false;
        });
    }
    // if we have exactly one login option, just replace the link destination
    else if (loginOptions.length == 1)
    {
        var loginOption = loginOptions[0];

        var linkElement = AJS.$("#studio-gapps-login-link");
        linkElement.attr("href", loginOption.href);
        if (loginOption.id) {
            linkElement.attr("id", loginOption.id);
        }
        if (loginOption.title) {
            linkElement.attr("title", loginOption.title)
        }
        if (loginOption.formId) {
            var usermenuDiv = AJS.$("#studio-user-menu-container");
            attachLoginOptionForm(loginOption, usermenuDiv);
        }
    }
}

function attachLoginOptionForm(loginOption, element)
{
    var oReq = loginOption.openIdRequest;
    var form = AJS.$("<form/>").attr("id", loginOption.formId).attr("name", loginOption.formId).attr("action", oReq.action).
            attr("method", "post").attr("accept-charset", oReq.charset);
    AJS.$.each(oReq.authReqParams, function(key, value) {
        form.append(AJS.$("<input/>").attr("type", "hidden").attr("name", key).val(value));
    });
    element.append(form);
}

/* Search input box */
AJS.$("#studio-quick-search-query").focus(function () {
    this.style.color = "#000";
    if (this.defaultValue == this.value) {
        this.value = "";
    }
}).blur(function () {
    this.style.color = "#ccc";
    if (this.value.replace(/\s+/g, "") == "") {
        this.value = this.defaultValue;
    }
});

// load fisheye search results (on search page)
if (typeof fisheyeAsynchronousSearchUrl != "undefined") {
    AJS.$("#fisheye_search_results").load(fisheyeAsynchronousSearchUrl);
}
