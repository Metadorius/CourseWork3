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

<div>
    <%@include file="components/headerUser.jsp" %>
</div>
<div class="main-wrapper">
    <%@include file="components/sidebar.jsp" %>
    <div id="map" class="content"></div>
</div>

<script>
    let bounds = null;
    let map = null;
    let targetMarker = null;
    let markers = [];
    let selectedMarkerIndex = null;

    document.getElementById('calculate').addEventListener("click", function () {
        document.getElementById('horizontalDistance').value = google.maps.geometry.spherical.computeDistanceBetween(targetMarker.position, markers[selectedMarkerIndex].position) / 1000;
    });

    document.getElementById("sidebarCollapse").addEventListener("click", function () {
        document.getElementById("sidebar").classList.toggle("active");
    });


    function placeMarker(location) {
        if (targetMarker == null) {
            targetMarker = new google.maps.Marker({
                icon: 'http://maps.google.com/mapfiles/ms/icons/purple-dot.png',
                position: location,
                map: map,
                draggable: true
            });
        } else {
            targetMarker.setPosition(location);
        }
    }

    function drawCircle(point, radius, dir) {
        let d2r = Math.PI / 180; // degrees to radians
        let r2d = 180 / Math.PI; // radians to degrees
        let earthsradius = 3963; // 3963 is the radius of the earth in miles

        let points = 32;

        // find the raidus in lat/lon
        let rlat = (radius / earthsradius) * r2d;
        let rlng = rlat / Math.cos(point.lat() * d2r);


        let extp = [];
        if (dir === 1) {
            var start = 0;
            var end = points + 1
        } // one extra here makes sure we connect the
        else {
            var start = points + 1;
            var end = 0
        }
        for (let i = start;
             (dir == 1 ? i < end : i > end); i = i + dir) {
            let theta = Math.PI * (i / (points / 2));
            ey = point.lng() + (rlng * Math.cos(theta)); // center a + radius x * cos(theta)
            ex = point.lat() + (rlat * Math.sin(theta)); // center b + radius y * sin(theta)
            extp.push(new google.maps.LatLng(ex, ey));
            bounds.extend(extp[extp.length - 1]);
        }
        // alert(extp.length);
        return extp;
    }

    function getHeadingParam() {
        let heading = parseFloat(document.getElementById("heading").value);
        // if (!heading || !targetMarker || !selectedMarkerIndex || !markers || !markers[selectedMarkerIndex])
        //     return null;
        let offset = google.maps.geometry.spherical.computeOffset(targetMarker.position, 1, heading);
        let complex = markers[selectedMarkerIndex].position;

        let t = ((complex.lat - targetMarker.lat) * (offset.lat - targetMarker.lat) + (complex.lng - targetMarker.lng) * (offset.lng - targetMarker.lng)) /
            ((offset.lat - targetMarker.lat) * (offset.lat - targetMarker.lat) + (offset.lng - targetMarker.lng) * (offset.lng - targetMarker.lng));

        var intersect = {lat: 0, lng: 0};
        intersect.lat = targetMarker.lat + t * (offset.lat - targetMarker.lat);
        intersect.lng = targetMarker.lng + t * (offset.lng - targetMarker.lng);
        return google.maps.geometry.spherical.computeDistanceBetween(complex, intersect);
    }

    function initMap(listener) {

        bounds = new google.maps.LatLngBounds();
        let req = new XMLHttpRequest();
        map = new google.maps.Map(
            document.getElementById('map'));
        let infoWindow = new google.maps.InfoWindow();
        let json = null;


        req.open("GET", 'api', true);
        req.send();
        req.onload = function (listener) {
            json = JSON.parse(req.responseText);
            Object.keys(json).forEach(function (key) {
                let value = json[key];

                // Маркер
                let marker = new google.maps.Marker({
                    icon: 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png',
                    position: new google.maps.LatLng(value["lat"], value["lng"]),
                    map: map,
                    title: value["name"]
                });
                markers.push(marker);

                // Радиусы
                let donut1 = new google.maps.Polygon({
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

                let donut2 = new google.maps.Polygon({
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

                let donut3 = new google.maps.Polygon({
                    paths: [drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusOuterHigh"], 1),
                        drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusInnerHigh"], -1)
                    ],
                    strokeColor: "#c80000",
                    strokeOpacity: 0.5,
                    strokeWeight: 2,
                    fillColor: "#ff0000",
                    fillOpacity: 0.2
                });
                donut3.setMap(map);

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
                        infoWindow.setContent(
                            "<p class=\"mb-1\"><b>" + value["name"] + "</b></p>\n" +
                            "<p class=\"mb-1\">" + value["lat"] + ", " + value["lng"] + "</p>\n" +
                            "<p class=\"mb-1\">" + value["AASystem"]["name"] + "</p>\n"
                        );
                        infoWindow.open(map, this);
                    }
                })(marker, value));

                marker.addListener('dblclick', function () {
                    selectedMarkerIndex = markers.indexOf(marker);
                    markers.forEach(function (m) {
                        if (m === marker) {
                            m.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');
                        } else {
                            m.setIcon('http://maps.google.com/mapfiles/ms/icons/yellow-dot.png');
                        }
                    })
                });

                bounds.extend(marker.position);
                map.fitBounds(bounds);
            });
        }

        google.maps.event.addListener(map, 'click', function (e) {
            placeMarker(e.latLng);
        });
    }

</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD73SZhvHYfj_BhuMgAQ9tqoV6b2BVneIY&callback=initMap&libraries=geometry">
</script>
<%@include file="components/tail.jsp" %>
</body>
</html>
