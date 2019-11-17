<%--
  Created by IntelliJ IDEA.
  User: Meta
  Date: 16.10.2019
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        /* Set the size of the div element that contains the map */
        #map {
            height: 400px;  /* The height is 400 pixels */
            width: 100%;  /* The width is the width of the web page */
        }
    </style>
    <title>lab2</title>
</head>
<body style="margin:2em auto; max-width:800px; padding:1em; text-align:justify">

<a class="btn btn-outline-primary" href="login" role="button">Вход</a>
<div id="map"></div>
<script>
    // Initialize and add the map
    function initMap() {
        var bounds = new google.maps.LatLngBounds();
        var req = new XMLHttpRequest();
        var map = new google.maps.Map(
            document.getElementById('map'));
        var infowindow = new google.maps.InfoWindow();
        var json = null;

        req.open("GET", 'api' ,true);
        req.send();
        req.onload = function() {
            json = JSON.parse(req.responseText);
            Object.keys(json).forEach(function(key) {
                var value = json[key];
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(value["lat"], value["lng"]),
                    map: map,
                    title: value["name"]
                });
                google.maps.event.addListener(marker, 'click', (function(e) {
                    return function() {
                        infowindow.setContent(
                            "<p class=\"mb-1\"><b>" + value["name"] + "</b></p>\n" +
                            "<p class=\"mb-1\">" + value["lat"] + ", " + value["lng"]+ "</p>\n" +
                            "<p class=\"mb-1\">" + value["type"] + "</p>\n"
                        );
                        infowindow.open(map, marker);
                    }
                })(marker, value));
                bounds.extend(marker.position);
            });
        }
        map.fitBounds(bounds);
    }
</script>
<!--Load the API from the specified URL
* The async attribute allows the browser to render the page while the API loads
* The key parameter will contain your own API key (which is not needed for this tutorial)
* The callback parameter executes the initMap() function
-->
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD73SZhvHYfj_BhuMgAQ9tqoV6b2BVneIY&callback=initMap">
</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
