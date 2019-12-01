<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <%@include file="components/head.jsp" %>
    <script src="https://rack.pub/control.min.js"></script>
    <link rel="stylesheet" href="style.css">
    <title>Зоны покрытия ЗРК</title>
</head>
<body>
<div><%@include file="components/headerUser.jsp" %></div>
<div id="map" class="content"></div>
<script>
    var bounds = null;
    var map = null;

    function drawCircle(point, radius, dir) {
        var d2r = Math.PI / 180; // degrees to radians
        var r2d = 180 / Math.PI; // radians to degrees
        var earthsradius = 3963; // 3963 is the radius of the earth in miles

        var points = 32;

        // find the raidus in lat/lon
        var rlat = (radius / earthsradius) * r2d;
        var rlng = rlat / Math.cos(point.lat() * d2r);


        var extp = new Array();
        if (dir == 1) {
            var start = 0;
            var end = points + 1
        } // one extra here makes sure we connect the
        else {
            var start = points + 1;
            var end = 0
        }
        for (var i = start;
             (dir == 1 ? i < end : i > end); i = i + dir) {
            var theta = Math.PI * (i / (points / 2));
            ey = point.lng() + (rlng * Math.cos(theta)); // center a + radius x * cos(theta)
            ex = point.lat() + (rlat * Math.sin(theta)); // center b + radius y * sin(theta)
            extp.push(new google.maps.LatLng(ex, ey));
            bounds.extend(extp[extp.length - 1]);
        }
        // alert(extp.length);
        return extp;
    }


    // Initialize and add the map
    function initMap(listener) {

        bounds = new google.maps.LatLngBounds();
        var req = new XMLHttpRequest();
        map = new google.maps.Map(
            document.getElementById('map'));
        var infowindow = new google.maps.InfoWindow();
        var json = null;

        req.open("GET", 'api', true);
        req.send();
        req.onload = function (listener) {
            json = JSON.parse(req.responseText);
            Object.keys(json).forEach(function (key) {
                var value = json[key];

                // Маркер
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(value["lat"], value["lng"]),
                    map: map,
                    title: value["name"]
                });

                // Радиусы
                var donut1 = new google.maps.Polygon({
                    paths: [drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusOuterLow"], 1),
                        drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusInnerLow"], -1)
                    ],
                    strokeColor: "#00c800",
                    strokeOpacity: 0.5,
                    strokeWeight: 2,
                    fillColor: "#00ff00",
                    fillOpacity: 0.2
                });
                donut1.setMap(map);

                var donut2 = new google.maps.Polygon({
                    paths: [drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusOuterMed"], 1),
                        drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusInnerMed"], -1)
                    ],
                    strokeColor: "#c8c800",
                    strokeOpacity: 0.5,
                    strokeWeight: 2,
                    fillColor: "#ffff00",
                    fillOpacity: 0.2
                });
                donut2.setMap(map);

                var donut3 = new google.maps.Polygon({
                    paths: [drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusOuterHigh"], 1),
                        drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusInnerHigh"], -1)
                    ],
                    strokeColor: "#c80000",
                    strokeOpacity: 0.5,
                    strokeWeight: 2,
                    fillColor: "#ff0000",
                    fillOpacity: 0.2
                });
                donut3.setMap(map)

                document.getElementById('checkLow').addEventListener("click", function () {
                    donut1.setVisible(this.checked);
                });

                document.getElementById('checkMed').addEventListener("click", function () {
                    donut2.setVisible(this.checked);
                });

                document.getElementById('checkHigh').addEventListener("click", function () {
                    donut3.setVisible(this.checked);
                });

                google.maps.event.addListener(marker, 'click', (function (e) {
                    return function () {
                        infowindow.setContent(
                            "<p class=\"mb-1\"><b>" + value["name"] + "</b></p>\n" +
                            "<p class=\"mb-1\">" + value["lat"] + ", " + value["lng"] + "</p>\n" +
                            "<p class=\"mb-1\">" + value["AASystem"]["name"] + "</p>\n"
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
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD73SZhvHYfj_BhuMgAQ9tqoV6b2BVneIY&callback=initMap&libraries=geometry">
</script>
<%@include file="components/tail.jsp" %>
</body>
</html>
