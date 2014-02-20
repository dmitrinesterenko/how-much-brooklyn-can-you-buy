// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
console.log('map');

$(function() {
    $('#submit').on('click', function(){
        console.log('clicked');
        var amount = $('#amount').val();
        var neighborhood = $('#neighborhood').val();
        console.log(amount, neighborhood);
        var url = "/api/spend/" + amount+"/"+neighborhood;
        var jqxhr = $.get( url, function(data) {
            console.log( "success", data );
            place_marker(data)
        }).done(function(data) {
                console.log( "second success" );
                console.log(data)  ;
            })
            .fail(function() {
                console.log( "error" );
            })
            /*.always(function() {
                console.log( "complete" );
            }); */



    });
});

function place_marker(data){
    //testing
    //just center on first result
    var mapOptions = {
        center: new google.maps.LatLng(data[0].latitude,data[0].longitude),
        zoom: 13
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    for(i=0; i< data.length; i++){
        var myLatlng = new google.maps.LatLng(data[i].latitude,data[i].longitude);
        var infowindow = new google.maps.InfoWindow({
            content: get_info_window_text(data[i])
        });

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: data[i].description
        });
        // adding listeners in an array
        //using closure because am dumb stolen from here http://stackoverflow.com/questions/11106671/google-maps-api-multiple-markers-with-infowindows
        google.maps.event.addListener(marker, 'click', (function(marker,content,infowindow){
            return function() {
                infowindow.setContent(content);
                infowindow.open(map,marker);
            };
        })(marker,content,infowindow));
    }
}

function get_info_window_text(property){
    content = "<h1>"+ property.address +" | " + property.price + "</h1>";

    show_details = false;
    if(property.baths != null || property.beds != null || property.sqft != null){
        show_details = true;

    }
    if(show_details){
        content += "<div class='details'>";
    }
    if(property.beds != null){
        content += "<p>Bedrooms: " + property.baths + "</p>";
    }
    if(property.baths != null){
        content += "<p>Baths: " + property.beds +"</p>";
    }

    if(property.sqft != null){
        content += "<p>Sq Feet: " + property.sqft + "</p>";
    }

    if(show_details){
        content += "</div>";
    }
    content += "<div class='content'>" + property.description +"</div>" ;



    return content;
}