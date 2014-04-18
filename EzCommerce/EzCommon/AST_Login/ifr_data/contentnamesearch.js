(function() {

    AJS.toInit(function ($) {
        var effect = "fade";

        var dd,
            cache = {},
            cache_stack = [],
            current_active,
            browser = AJS.$.browser;
        var hider = function (list) {
             $("a span", list).each(function () {
                var $a = $(this);
                $a.addClass('search-result');

                this.realhtml = this.realhtml || $a.html();
                var words = this.realhtml.split(" ");
                $a.html("<span>" + words.join("</span><span> ") + "</span>");
                var elpss = AJS("var");
                elpss.html("&#8230;");
                $a.append(elpss);
                this.elpss = elpss;

                var elwidth = $a[0].elpss[0].offsetWidth,
                    width = $a[0].parentNode.parentNode.parentNode.parentNode.offsetWidth,
                    isLong = false;
                $("span", $a).each(function (i) {
                    var $word = $(this);
                    if (isLong) {
                        $word.hide();
                    } else {
                        $word.show();
                        if (this.offsetLeft + this.offsetWidth + elwidth > width) {
                            $word.hide();
                            isLong = true;
                        }
                    }
                });
                $a[0].elpss[isLong ? "show" : "hide"]();
            });

            $("img", list).each(function() {
                var $img = $(this);
                var span = $img.siblings("a").children("span:first-child");
                span.css('background-image', 'url(' + $img.attr('src') + ')');
                $img.remove();
            });
        };

        var moveHandler = function(selected, direction) {

            if (current_active) {
                current_active.removeClass('active');
            }

            current_active = selected;
            current_active.addClass('active');
        }
        
        // see JST-5408
        var displayEscapeHandler = function(obj) {
            // search link for comes already html encoded
            if(obj.className == 'search-for'){
                return obj.name;
            }
            
            // the rest need to be encoded manually
            if (AJS.escapeHtml) {
                return AJS.escapeHtml(obj.name);
            } else {
                // confluence, fisheye, bamboo all run older versions of AJS that do not 
                // contain an escape HTML function.
                // when they upgrade to AJS/AUI 3.4, we can remove this
                return obj.name.replace(/&/g,'&amp;')
                               .replace(/>/g,'&gt;')
                               .replace(/</g,'&lt;')
                               .replace(/"/g,'&quot;')
                               .replace(/'/g,'&#39;')
            }
        }

        var searchBox = $("#studio-quick-search-query");

        if ($.browser.webkit) {
            searchBox[0].type = "search";
            searchBox[0].setAttribute("results", 10);
        }

        searchBox.focus(function () {
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

        var jsonparser = function (json, resultStatus) {
            var matches = json.statusMessage ? [[{html: json.statusMessage, className: "error"}]] : json.contentNameMatches;

            var old_dd = dd;
            current_active = null;
            dd = AJS.dropDown(matches, {moveHandler: moveHandler, displayHandler: displayEscapeHandler})[0];
            dd.$.attr("id", "quick-nav-drop-down").addClass("aui-dropdown"); // FE/CRU 2.2 quirk.

            dd.onhide = function (causer) {
                if (causer == "escape") {
                    searchBox.focus();
                }
            };
            var spans = $("span", dd.$);
            for (var i = 0, ii = spans.length -1; i < ii; i++) {
                (function () {
                    var $this = $(this),
                    html = $this.html();
                    // highlight matching tokens
                    html = html.replace(new RegExp("(" + json.queryTokens.join("|") + ")", "gi"), "<strong>$1</strong>");
                    $this.html(html);
                }).call(spans[i]);
            }
            hider(dd.$);
            dd.hider = function () {
                hider(dd.$);
            };
            AJS.onTextResize(dd.hider);
            if (old_dd) {
                dd.show();
                dd.method = effect;
                AJS.unbindTextResize(old_dd.hider);
                old_dd.$.remove();
            } else {
                dd.show(effect);
            }
        };

        /**
         * Creates a scheduler for executing jsonp requests.
         * TODO(jwilson): move to a more generic place ie. AUI
         * @param initialDelay
         * @param timeoutTime
         */
        var jsonpTimeoutScheduler = function(initialDelay, timeoutTime) {

            if (initialDelay < 0) {
                throw "ajaxTimeoutScheduler - initialDelay must be >= 0";
            }

            if (timeoutTime < 0) {
                throw "ajaxTimeoutScheduler - timeoutTime must >= 0";
            }

            var id = 0;
            var pipeline = {};
            var scheduled = {};

            var callSuccess = function(ident, data, resultStatus) {
                var pipe = pipeline[ident];
                // Could check that callback is a function.
                if (pipe && pipe.callback) {
                    // Wrap in try incase .clear() method is scheduled just before.
                    try {
                       pipe.callback(data, resultStatus);
                    } catch (err) {
                        AJS.log(err);
                    }
                }
            };

            return {
                // Would prefer to use events instead of the shceduled callback
                'schedule' : function(requestUrl, requestData, scheduledCallback, successFunc, timeoutFunc) {
                    var self = this;
                    ++id;

                    var t1 = setTimeout((function(_id){

                        var ident = _id;
                        return function() {

                            if (!scheduled[ident]) {
                                // Don't schedule
                                return;
                            }

                            var successCallback = function (data, resultStatus) {
                                self.clear(ident);
                                successFunc(data, resultStatus);
                            }

                            var t2 = setTimeout(function() {
                                self.clear(ident);
                                timeoutFunc();
                            }, timeoutTime);

                            pipeline[ident] = {call_id:t1, timeout_id:t2, callback: successCallback};

                            AJS.$.getJSON(requestUrl, requestData, function(data, resultStatus) {
                                callSuccess(ident, data, resultStatus);
                            });

                            scheduledCallback(ident);
                        };

                    })(id), initialDelay);

                    scheduled[id] = t1;

                    return id;
                },

                'clear' : function(ident) {
                    delete scheduled[ident];
                    var pipe = pipeline[ident];

                    if (pipe) {
                        // Wrap in try incase the timeout is executed.
                        try {
                            clearTimeout(pipe.call_id);
                            clearTimeout(pipe.timeout_id);
                            pipe.callback = null
                            delete pipeline[ident];
                        } catch(err) {
                            AJS.log(err);
                        }
                    }
                }

            };

        };

        var scheduler = jsonpTimeoutScheduler(400, 5000);

        var poller;
        var quickSearchCallback = function(data, resultStatus) {
            jsonparser(data, resultStatus);
        };

        var scheduledCallback = function(indent) {
            var message = {"contentNameMatches":[[{className:"loading",html:"&nbsp;"}]], statusMessage: ""};
            jsonparser(message);
        }

        // Called when the ajax search takes too long.
        var timeout = function() {
            var searchFor = searchBox.val();
            var escapedSearchFor = AJS.escape(searchFor);
            // escape the searchFor param.
            var htmlEscapedSearchFor = AJS.$('<div/>').text(searchFor).html();
            var timeoutMessage = {"contentNameMatches":[[{"className":"search-for","href": studioData.jiraUrl + "/secure/StudioSearch.jspa?query=" + escapedSearchFor,"icon":"","name":"Search for &lsquo;"+ htmlEscapedSearchFor +"&rsquo;","projectKey":""}]], "queryTokens":[searchFor],"statusMessage":""};
            jsonparser(timeoutMessage);
        };

        var scheduleSearch = function(value) {

            var requestData = {
                query : value,
                studio : true,
                searchAllUrl : studioData.jiraUrl+"/secure/StudioSearch.jspa",
                userProfileUrl : studioData.jiraUrl+"/secure/ViewProfile.jspa?name="
            };
            var requestUrl = studioData.jiraUrl+"/plugins/servlet/studio/quicknav?callback=?";

            poller = scheduler.schedule(requestUrl, requestData, scheduledCallback, quickSearchCallback, timeout);
        };

        function validLength(value) {
            return value.length >= 2;
        }

        function checkQuickSearch() {
            var value = searchBox.val();

            if (poller) {
                scheduler.clear(poller);
                poller = null;
                checkQuickSearch();
            } else if (validLength(value)) {
                scheduleSearch(value);
            } else {
                dd && dd.hide();
            }
        }

        searchBox.keypress(function(e) {

            // Have to ignore some keypress events that only FF fires.
            if (browser.mozilla && e.keyCode) {
                return;
            }

            setTimeout(checkQuickSearch, 0);

        });

        searchBox.keyup(function(e) {
            var key = e.which || e.keyCode;
            switch (key) {
                // Delete or backspace
                case 8: // backspace key
                case 46: // delete key
                    setTimeout(checkQuickSearch, 0);
                    break;
                default:
                    // Do nothing
            }
        });

        searchBox.focus(function(){
           checkQuickSearch();
        });

    });

})(window);
