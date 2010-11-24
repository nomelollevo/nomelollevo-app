// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Generic functions */
NML = {

    // Shows an overlay with a modal window
    // Arguments:
    //  - overlayId: Id of the overlay layer
    //  - overlayWidgetId: Id of the widget that will be inside
    //                     the overlay
    overlay: function () {
        var overlayId = "#"+arguments[0];
        var overlayWidgetId = "#"+arguments[1];

        var x = window.innerWidth;

        var xw = jQuery(overlayWidgetId).css('width');
        xw = parseInt(xw.split("px")[0])

        jQuery(overlayWidgetId).css('left',((x/2)-(xw/2)))

        jQuery(overlayId).show();
        jQuery(overlayWidgetId).show();
    },

    // Hides an overlay with a modal window
    // Arguments:
    //  - overlayId: Id of the overlay layer
    //  - overlayWidgetId: Id of the widget that will be inside
    //                     the overlay
    hideOverlay: function () {
        var overlayId = "#"+arguments[0];
        var overlayWidgetId = "#"+arguments[1];

        jQuery(overlayId).hide();
        jQuery(overlayWidgetId).hide();
    }
}


/* Home Controller */
NML.Home = {

    // Index action
    Index: {

        // executed when the page has been loaded
        onload: function() {
            jQuery("#new-sale-home-button").click(function() {
                NML.overlay("login-overlay", "login-selection-box");
                return false;
            });

            jQuery("#auth-cancel").click(function() {
                NML.hideOverlay("login-overlay", "login-selection-box");
                return false;
            });
        }
    }
}
