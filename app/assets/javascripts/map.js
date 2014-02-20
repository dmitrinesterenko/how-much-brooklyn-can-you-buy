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
    //end of testing
    for(i=0; i< data.length; i++){
        var myLatlng = new google.maps.LatLng(data[i].latitude,data[i].longitude);

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: data[i].description
        });
    }
}