/*
 * THIS FILE IS EXACT COPY FROM CONFLUENCE-3.4.2, EXCEPT LINE 6 IS ADDED (WITH OVERRIDES COMMENT).
 * DO NOT MODIFY THIS FILE. IF THERE IS A BUG, LET CONFLUENCE TEAM KNOW.
 */
AJS.toInit(function() {
    var $ = AJS.$;
    var studioContextPath = $("#studio-context-path").attr("content") || "";                    // override
    var currentStatusRestUrl = studioContextPath + "/plugins/servlet/studio/userstatus";        // override
    var updateStatusRestUrl = currentStatusRestUrl;                                             // override
    if ($("#confluence-context-path").size() > 0) {                                             // override
        // contextPath is defined in Confluence page                                            // override
        currentStatusRestUrl = contextPath + "/status/current.action";                          // override
        updateStatusRestUrl = contextPath + "/status/update.action";                            // override
    }                                                                                           // override
    function trim(string) {                                                                     // override
        return string.replace(/(^\s*)|(\s*$)/g, "");                                            // override
    }                                                                                           // override
    function isBlank(string) {
        return trim(string).length == 0;
    }

    var popup,
        maxChars = 140;

    function createPopUp() {
        var popup = new AJS.Dialog(650, 200, "update-user-status-dialog");
        popup.addHeader(AJS.params.statusDialogHeading || "What are you working on?");
        popup.addPanel("Set Status", "<form class='aui update-status'>" + // TODO AUIfy this
                                     "<fieldset>" +
                                     "<legend class='assistive'>Status Update</legend>" +
                                     "<label for='status-text' class='assistive'>" + (AJS.params.statusDialogAccessibilityLabel || "Enter your status (140 character limit)") + "</label>" +
                                     "<textarea name='status-text' id='status-text'></textarea>" +
                                     "<span id='update-status-chars-left'>" + maxChars + "</span>" +
                                     "<div id='dialog-current-status' class='current-user-latest-status'>" +
                                     "Last update:" +
                                     " <span class='status-text'></span></div>" +
                                     "</fieldset>" +
                                     "</form>");
        popup.addButton(AJS.params.statusDialogUpdateButtonLabel || "Update", updateStatus, "status-update-button");
        popup.addButton(AJS.params.statusDialogCancelButtonLabel || "Cancel", function (dialog) {dialog.hide();}, "status-cancel-button");
        popup.popup.element.find(".dialog-button-panel").append("<span class='error-message'></span>");
        popup.setError = function(html) {
            $("#update-user-status-dialog .error-message").html(html)
        };
        return popup;
    }

    function setCurrentStatus(status) {
        $(".current-user-latest-status .status-text").html(status.text);

        $(".current-user-latest-status a[id^=view]").each(function() {
            var $this = $(this),
                href = $this.attr("href");
            $this.attr("href", href.replace(/\d+$/, status.id))
                   .text(status.friendlyDate)
                   .attr("title", new Date(status.date).toLocaleString());
        });
    }

    function getLatestStatus() {
        $.getJSON(currentStatusRestUrl, function(data) {
            if (data.errorMessage != null) {
                popup.setError(data.errorMessage);
            }
            else {
                setCurrentStatus(data);
            }
        });
    }

    var updateStatus = function() {
        var textarea = $("#update-user-status-dialog #status-text")
                       .attr("disabled", "disabled")
                       .attr("readonly", "readonly")
                       .blur();
        var text = textarea.val();
        $(".status-update-button").attr("disabled", "disabled");

        if (text.length > maxChars || isBlank(text)) {
            return false;
        }
        AJS.safe.ajax({
            url: updateStatusRestUrl,
            type: "POST",
            dataType: "json",
            data: {
                "text": text
            },
            success: function(data) {
                if (data.errorMessage != null) {
                    popup.setError(data.errorMessage);
                }
                else {
                    setCurrentStatus(data);
                    textarea.val("");
                    setTimeout(function() { popup.hide(); }, 1000);
                }
            },
            error: function(xhr, text, error) {
                AJS.log("Error updating status: " + text);
                AJS.log(error);
                popup.setError("There was an error - " + error);
            }
        });
    };
    $("#set-user-status-link").click(function(e) {
        var dropDown = AJS.dropDown($(this).parents(".ajs-drop-down"))[0];
        dropDown && dropDown.hide();

        if (typeof popup == "undefined") {
            popup = createPopUp();
            var $charsLeft = $("#update-status-chars-left");
            var $updateButton = $(".status-update-button").attr("disabled", "disabled");
            $("#update-user-status-dialog form.update-status #status-text").keydown(function(e) {
                if (e.which == 27) { // ESC
                    popup.hide();
                }
                else if (e.which == 13) { // Enter
                    updateStatus();
                }
            }).bind("blur focus change " + ($.browser.mozilla ? "paste input" : "keyup"), function() {
                var length = maxChars - $(this).val().length;
                $charsLeft.removeClass("over-limit").removeClass("close-to-limit").text(length);
                $updateButton.removeAttr("disabled");

                if (isBlank($(this).val())) {
                    $updateButton.attr("disabled", "disabled");
                }
                if (length < 0) {
                    $charsLeft.addClass("over-limit").html("&minus;" + -length);
                    $updateButton.attr("disabled", "disabled");
                }
                else if (length < 20) {
                    $charsLeft.addClass("close-to-limit");
                }
            });
            $("#update-user-status-dialog form.update-status").submit(function(e) {
                updateStatus();
                return AJS.stopEvent(e);
            });
        }
        popup.setError("");
        getLatestStatus();
        popup.show();
        $("#update-user-status-dialog #status-text").removeAttr("readonly").removeAttr("disabled").focus();
        return AJS.stopEvent(e);
    });
});
