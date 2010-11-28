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
};

/* Localization Functions */
NML.Localization = {

    initialLocation: null,

    defaultPosition: null,

    browserSupportFlag: new Boolean(),

    initialize: function() {
        NML.Localization.defaultPosition = new google.maps.LatLng(40.69847032728747, -73.9514422416687);

        var myOptions = {
            zoom: 15,
            mapTypeControl: false,
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

			jQuery("#position_cp").click(function() {
				jQuery("#categorical-search-postalcode").show();			   
			});
			
			jQuery("#position_actual_position").click(function() {
				jQuery("#categorical-search-postalcode").hide();			   
			});
			
			jQuery("#description-close").click(function() {
				jQuery("#description").hide();			   
			});
        }
    }
};

/* SalesManagement Controller */
NML.SalesManagement = {

    // Index action
    Index: {

        // executed when the page has been loaded
        onload: function() {
            jQuery(".sale-row-map-container").each(function(index){
                var longitude = parseFloat(jQuery(this).find(".longitude-holder").text());
                var latitude  = parseFloat(jQuery(this).find(".latitude-holder").text());
                var mapContainer = jQuery(this).find(".map-holder");
                var latlng = new google.maps.LatLng(latitude, longitude);
                var myOptions = {
                    zoom: 14,
                    center: latlng,
                    mapTypeControl: false,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                var map = new google.maps.Map(document.getElementById(mapContainer.attr("id")), myOptions);
                map.setCenter(latlng);
                new google.maps.Marker({ map: map,
                                         position: latlng });
            });
        }
    },

    // New action
    New: {
        map: null,

        marker: null,

        displayMap: function() {
            var location = arguments[0];

            if(NML.SalesManagement.New.map==null) {
                var myOptions = {
                    zoom: 13,
                    center: location[0].geometry.location,
                    mapTypeControl: false,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                }
                NML.SalesManagement.New.map = new google.maps.Map(document.getElementById("sale-map"), myOptions);
            } else {
                NML.SalesManagement.New.marker.setMap(null);
            }

            NML.SalesManagement.New.map.setCenter(location[0].geometry.location);
            NML.SalesManagement.New.marker = new google.maps.Marker({ map: NML.SalesManagement.New.map,
                                                                      position: location[0].geometry.location });

        },

        // executed when the page has been loaded
        onload: function() {
            // date pickers
            jQuery("#sale_start_time").datepicker({ dayNames: ['Domingo', 'Lunes', 'Martes', 'Mi&eacute;rcoles', 'Jueves', 'Viernes', 'S&aacute;bado'],
                                                    dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                                                    firstDay: 1,
                                                    monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']  });
            jQuery("#sale_start_time" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );


            jQuery("#sale_end_time").datepicker({ dayNames: ['Domingo', 'Lunes', 'Martes', 'Mi&eacute;rcoles', 'Jueves', 'Viernes', 'S&aacute;bado'],
                                                  dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
                                                  firstDay: 1,
                                                  monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']  });
            jQuery("#sale_end_time" ).datepicker( "option", "dateFormat", 'dd-mm-yy' );


            // hide add items button
            jQuery("#submit-new-sale").hide();
            jQuery("#add-items-to-new-sale-button").show();
            jQuery("#add-items-to-new-sale-button").click(function(){
                jQuery("#new-sale-form").trigger("submit");
                return false;
            });

            // geocoder
            var geocoder = new google.maps.Geocoder();

            var shouldEncode = function() {
                var valProvince = jQuery("#sale_province").val();
                var valZip = jQuery("#sale_zip_code").val();
                var valAddress = jQuery("#sale_address").val();

                if(valZip != "" && valProvince != "") {
                    var toEncode = valProvince + " " + valAddress + " " + valZip;
                    geocoder.geocode( { 'address': toEncode }, function(results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            var lat = results[0].geometry.location.b;
                            var lon = results[0].geometry.location.c;
                            jQuery("#sale_latitude").val(lat);
                            jQuery("#sale_longitude").val(lon);
                            NML.SalesManagement.New.displayMap(results);
                        }
                    });
                }
            };

            shouldEncode();

            jQuery("#sale_province").focusout(shouldEncode);

            jQuery("#sale_zip_code").focusout(shouldEncode);

            jQuery("#sale_address").focusout(shouldEncode);

            jQuery("#sale_is_unlimited").click(function() {
                var isSelected = jQuery("#sale_is_unlimited").attr("checked");
                if(isSelected) {
                    jQuery("#sale_start_time").attr('disabled', true);
                    jQuery("#sale_end_time").attr('disabled', true);
                } else {
                    jQuery("#sale_start_time").attr('disabled', false);
                    jQuery("#sale_end_time").attr('disabled', false);
                }
            });
        }
    }
};

/* ItemsManagement Controller */
NML.ItemsManagement = {

    // Index action
    Index: {

        // executed when the page has been loaded
        onload: function() {
            jQuery("tr").each(function(index) {
                jQuery(this).mouseover(function() {
                    jQuery(this).css("background-color", "#ECECEC");
                });
                jQuery(this).mouseout(function() {
                    jQuery(this).css("background-color", "#FFFFFF");
                });
            });
        }
    },

    // New action
    New: {

        // executed when the page has been loaded
        onload: function() {
            // hide add items button
            jQuery("#submit-new-item").hide();
            jQuery("#add-items-to-new-item-button").show();
            jQuery("#add-items-to-new-item-button").click(function(){
                jQuery("#new-item-form").trigger("submit");
                return false;
            });

        }
    }
};
