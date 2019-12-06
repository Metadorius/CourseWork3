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
    let divisionMarkers = {};
    let selectedDivisionId = null;
    let divisionsJson = null;

    document.getElementById('calculate').addEventListener("click", function () {
        console.log(divisionMarkers);
        console.log(selectedDivisionId);
        let dist = +google.maps.geometry.spherical.computeDistanceBetween(targetMarker.position, divisionMarkers[selectedDivisionId].position) / 1000; // km
        let height = +document.getElementById('height').value; // km
        let heading = +document.getElementById('heading').value; // degrees
        let headingParameter = +getHeadingParam(heading); // km
        let speed = +document.getElementById('speed').value; // km/h
        let rocketSpeed = +document.getElementById('rocketSpeed').value; // m/s
        let rockets = +document.getElementById('rockets').value; // qty
        let timeDelta = +document.getElementById('timeDelta').value; // s

        console.log(height)
        console.log(headingParameter)

        let division;
        Object.keys(divisionsJson).forEach(function (key) {
            if (Number(divisionsJson[key]["id"]) == selectedDivisionId)
                division = divisionsJson[key];
        });
        console.log(division)

        //dummy code for test
        let radiusMin = +division["AASystem"]["radiusInnerLow"];
        let radiusMax = +division["AASystem"]["radiusOuterLow"];

        let travelDistanceMin = Math.sqrt(height*height + headingParameter*headingParameter + radiusMin*radiusMin);
        let travelDistanceMax = Math.sqrt(height*height + headingParameter*headingParameter + radiusMax*radiusMax);
        console.log(travelDistanceMin);
        console.log(travelDistanceMax);

        let travelTimeMin = travelDistanceMin * 1000 / rocketSpeed; // km * 1000 = m; m/(m/s) = s
        let travelTimeMax = travelDistanceMax * 1000 / rocketSpeed;
        console.log(travelTimeMin);
        console.log(travelTimeMax);

        let launchDistanceMin = radiusMin + speed*(travelTimeMin + timeDelta*(rockets - 1)) / 3600; //speed: km/h / 3600 = km/s
        let launchDistanceMax = radiusMax + speed*travelTimeMax / 3600;

        document.getElementById('horizontalDistance').value = dist;
        document.getElementById('headingParameter').value = headingParameter;
        document.getElementById('launchDistanceMin').value = launchDistanceMin;
        document.getElementById('launchDistanceMax').value = launchDistanceMax;
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

    function getHeadingParam(heading) {

        // if (!heading || !targetMarker || !selectedMarkerIndex || !markers || !markers[selectedMarkerIndex])
        //     return null;
        let complex = divisionMarkers[selectedDivisionId].position;
        let target = targetMarker.position;

        console.log(heading); console.log(google.maps.geometry.spherical.computeHeading(target, complex));
        let degree = Math.abs(google.maps.geometry.spherical.computeHeading(target, complex) - heading);
        console.log(degree);
        console.log(Math.sin(degree * Math.PI / 180));
        console.log(google.maps.geometry.spherical.computeDistanceBetween(target, complex) / 1000);
        return google.maps.geometry.spherical.computeDistanceBetween(target, complex) * Math.sin(degree * Math.PI / 180) / 1000;
    }

    function initMap(listener) {

        bounds = new google.maps.LatLngBounds();
        let req = new XMLHttpRequest();
        map = new google.maps.Map(
            document.getElementById('map'));
        let infoWindow = new google.maps.InfoWindow();


        req.open("GET", 'api', true);
        req.send();
        req.onload = function (listener) {
            divisionsJson = JSON.parse(req.responseText);
            Object.keys(divisionsJson).forEach(function (key) {
                let value = divisionsJson[key];

                // Маркер
                let marker = new google.maps.Marker({
                    icon: 'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png',
                    position: new google.maps.LatLng(value["lat"], value["lng"]),
                    map: map,
                    title: value["name"]
                });
                divisionMarkers[Number(value["id"])] = marker;

                // Радиусы
                let donut1 = new google.maps.Polygon({
                    paths: [drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusOuterLow"], 1),
                        drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radiusInnerLow"], -1)
                    ],
                    strokeColor: "#00c800",
                    strokeOpacity: 0.5,
                    strokeWeight: 2,
                    fillColor: "#00ff00",
                    fillOpacity: 0.2,
                    clickable: false
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
                    fillOpacity: 0.2,
                    clickable: false
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
                    fillOpacity: 0.2,
                    clickable: false
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
                    selectedDivisionId = Object.keys(divisionMarkers).filter(function(key) {
                        return divisionMarkers[key] === marker;
                    })[0];
                    console.log(selectedDivisionId);
                    Object.keys(divisionMarkers).forEach(function (key) {
                        if (key == selectedDivisionId) {
                            divisionMarkers[key].setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');
                        } else {
                            divisionMarkers[key].setIcon('http://maps.google.com/mapfiles/ms/icons/yellow-dot.png');
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
