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

/* Localization Functions */
NML.Localization = {

    initialLocation: null,

    defaultPosition: null,

    browserSupportFlag: new Boolean(),

    initialize: function() {
        NML.Localization.defaultPosition = new google.maps.LatLng(40.69847032728747, -73.9514422416687);

        var myOptions = {
            zoom: 15,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById("map-container"), myOptions);

        // Try W3C Geolocation (Preferred)
        if(navigator.geolocation) {
            NML.Localization.browserSupportFlag = true;
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    NML.Localization.initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
                    map.setCenter(NML.Localization.initialLocation);
	            marker = new google.maps.Marker({
		        position: NML.Localization.initialLocation,
		        map: map,
		        title:"Initial location"
	            });
	            map.addOverlay(marker)
                },

                function() {
                    NML.Localization.handleNoGeolocation(NML.Localization.browserSupportFlag);
                });

        // Try Google Gears Geolocation
        } else if (google.gears) {
            NML.Localization.browserSupportFlag = true;
            var geo = google.gears.factory.create('beta.geolocation');
            geo.getCurrentPosition(
                function(position) {
                    NML.Localization.initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
                    map.setCenter(NML.Localization.initialLocation);
	            marker = new google.maps.Marker({
		        position: NML.Localization.initialLocation,
		        map: map,
		        title:"Initial location"
	            });
	            map.addOverlay(marker)
                },

                function() {
                    NML.Localization.handleNoGeoLocation(NML.Localization.browserSupportFlag);
                });

        // Browser doesn't support Geolocation
        } else {
            NML.Localization.browserSupportFlag = false;
            NML.Localization.handleNoGeolocation(NML.Localization.browserSupportFlag);
        }
    },

    handleNoGeolocation: function(errorFlag) {
        if (errorFlag == true) {
            NML.Localization.initialLocation = NML.Localization.defaultPosition;
        } else {
            NML.Localization.initialLocation = NML.Localization.defaultPosition;
        }
        map.setCenter(NML.Localization.initialLocation);
    }
}

/* Home Controller */
NML.Home = {

    // Index action
    Index: {

        // executed when the page has been loaded
        onload: function() {
            // Localization support
            NML.Localization.initialize();

            // Identification and login
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
