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
    let targetHeadingPolyline = null;
    let divisionMarkers = {};
    let selectedDivisionId = null;
    let divisionsJson = null;
    let maxHeight = null;

    document.getElementById('calculate').addEventListener("click", function () {
        console.log(divisionMarkers);
        console.log(selectedDivisionId);
        let dist = google.maps.geometry.spherical.computeDistanceBetween(targetHeadingPolyline.getPath().getAt(0), divisionMarkers[selectedDivisionId].position) / 1000; // km
        let height = +document.getElementById('height').value; // km
        let heading = google.maps.geometry.spherical.computeHeading(targetHeadingPolyline.getPath().getAt(0), targetHeadingPolyline.getPath().getAt(1)); // degrees
        console.log(heading);
        let headingParameter = +getHeadingParam(heading); // km
        let speed = +document.getElementById('speed').value; // km/h
        let rockets = +document.getElementById('rockets').value; // qty
        let timeDelta = +document.getElementById('timeDelta').value; // s

        let division;
        Object.keys(divisionsJson).forEach(function (key) {
            if (Number(divisionsJson[key]["id"]) == selectedDivisionId)
                division = divisionsJson[key];
        });
        console.log(division)

        let rocketSpeed = +division["AASystem"]["rocketSpeed"]; // m/s
        //dummy code for test
        let radius = getInterpolatedRadius(division, height);
        let radiusMin = +radius["radiusInner"];
        let radiusMax = +radius["radiusOuter"];

        let travelDistanceMin = Math.sqrt(height*height + headingParameter*headingParameter + radiusMin*radiusMin);
        let travelDistanceMax = Math.sqrt(height*height + headingParameter*headingParameter + radiusMax*radiusMax);
        // console.log(travelDistanceMin);
        // console.log(travelDistanceMax);

        let travelTimeMin = travelDistanceMin * 1000 / rocketSpeed; // km * 1000 = m; m/(m/s) = s
        let travelTimeMax = travelDistanceMax * 1000 / rocketSpeed;
        // console.log(travelTimeMin);
        // console.log(travelTimeMax);

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

    function getInterpolatedRadius(division, height) {
        let radii = division["AASystem"]["radii"];
        let closestHigherRadiusKey = null, closestLowerRadiusKey = null;
        Object.keys(radii).forEach(function (key) {
            let radius = radii[key];
            if (radius["height"] == height) {
                closestHigherRadiusKey = key;
                closestLowerRadiusKey = key;
            } else if (radius["height"] > height &&
                (closestHigherRadiusKey == null || closestHigherRadiusKey > radius["height"])) {
                closestHigherRadiusKey = key;
            } else if (radius["height"] < height &&
                (closestLowerRadiusKey == null || closestLowerRadiusKey < radius["height"])) {
                closestLowerRadiusKey = key;
            }
        });
        if (closestHigherRadiusKey == closestLowerRadiusKey) {
            return radii[closestLowerRadiusKey];
        } else if (closestLowerRadiusKey == null || closestHigherRadiusKey == null) {
            return null;
        } else { // linear interpolation
            let lowerRadius = radii[closestLowerRadiusKey];
            let higherRadius = radii[closestHigherRadiusKey];
            return {
                height: height,
                radiusInner: (lowerRadius["radiusInner"]*(higherRadius["height"] - height)
                    + higherRadius["radiusInner"]*(height - lowerRadius["height"])
                    / (higherRadius["height"] - lowerRadius["height"])),
                radiusOuter: (lowerRadius["radiusOuter"]*(higherRadius["height"] - height)
                    + higherRadius["radiusOuter"]*(height - lowerRadius["height"])
                    / (higherRadius["height"] - lowerRadius["height"]))
            }
        }
    }

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

    function placeLine(location) {
        let polyCoord = [
            location,
            google.maps.geometry.spherical.computeOffset(location, 10, 0)
        ];
        targetHeadingPolyline = new google.maps.Polyline({
            path: polyCoord
        });
        targetHeadingPolyline.binder = new MVCArrayBinder(targetHeadingPolyline.getPath());
        var marker0 = new google.maps.Marker({
            position: event.latLng,
            title: 'Цель',
            map: map,
            icon: "http://maps.google.com/mapfiles/ms/micons/orange-dot.png",
            draggable: true
        });
        marker0.bindTo('position', targetHeadingPolyline.binder, (0).toString());
        var marker1 = new google.maps.Marker({
            position: event.latLng,
            title: 'Курс движения цели',
            map: map,
            icon: "http://maps.google.com/mapfiles/ms/micons/orange.png",
            draggable: true
        });
        marker1.bindTo('position', targetHeadingPolyline.binder, (1).toString());
        targetHeadingPolyline.setMap(map);
    }

    function drawCircle(point, radius, dir) {
        let d2r = Math.PI / 180; // degrees to radians
        let r2d = 180 / Math.PI; // radians to degrees
        let earthsradius = 6378;

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

        // if (!heading || !targetMarker || !selectedMarkerIndex || !markers || !markers[selectedMarkerIndex])
        //     return null;
        let complex = divisionMarkers[selectedDivisionId].position;
        let target0 = targetHeadingPolyline.getPath().getAt(0);
        let target1 = targetHeadingPolyline.getPath().getAt(1);

        // console.log(heading); console.log(google.maps.geometry.spherical.computeHeading(target, complex));
        let degree = Math.abs(google.maps.geometry.spherical.computeHeading(target0, complex) - google.maps.geometry.spherical.computeHeading(target0, target1));
        // console.log(degree);
        // console.log(Math.sin(degree * Math.PI / 180));
        // console.log(google.maps.geometry.spherical.computeDistanceBetween(target, complex) / 1000);
        return google.maps.geometry.spherical.computeDistanceBetween(target0, complex) * Math.sin(degree * Math.PI / 180) / 1000;
    }

    function getColorForHeight(height) {
        return 'hsl(' + (height * 240 / maxHeight) + ',100%,50%)';
    }

    function initMap(listener) {

        MVCArrayBinder.prototype = new google.maps.MVCObject();
        MVCArrayBinder.prototype.get = function(key) {
            if (!isNaN(parseInt(key))) {
                return this.array_.getAt(parseInt(key));
            } else {
                this.array_.get(key);
            }
        }
        MVCArrayBinder.prototype.set = function(key, val) {
            if (!isNaN(parseInt(key))) {
                this.array_.setAt(parseInt(key), val);
            } else {
                this.array_.set(key, val);
            }
        }

        bounds = new google.maps.LatLngBounds();
        let req = new XMLHttpRequest();
        let hreq = new XMLHttpRequest();
        map = new google.maps.Map(
            document.getElementById('map'));
        let infoWindow = new google.maps.InfoWindow();

        hreq.open("GET", 'api/maxHeight', true);
        hreq.send();
        hreq.onload = function (listener) {
          maxHeight = Number(hreq.responseText);
        };

        req.open("GET", 'api/divisions', true);
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

                Object.keys(value["AASystem"]["radii"]).forEach(function (radiusKey) {

                    let donut = new google.maps.Polygon({
                        paths: [drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radii"][radiusKey]["radiusOuter"], 1),
                            drawCircle(new google.maps.LatLng(value["lat"], value["lng"]), value["AASystem"]["radii"][radiusKey]["radiusInner"], -1)
                        ],
                        strokeColor: getColorForHeight(value["AASystem"]["radii"][radiusKey]["height"]),
                        strokeOpacity: 0.5,
                        strokeWeight: 2,
                        fillOpacity: 0.0,
                        clickable: false
                    });
                    donut.setMap(map);

                    document.getElementById('checkRadii').addEventListener("click", function () {
                        donut.setVisible(this.checked);
                    });
                });
                // Радиусы

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
                    // console.log(selectedDivisionId);
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
            if (targetHeadingPolyline == null)
                placeLine(e.latLng);
        });
    }

    function MVCArrayBinder(mvcArray) {
        this.array_ = mvcArray;
    }

</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD73SZhvHYfj_BhuMgAQ9tqoV6b2BVneIY&callback=initMap&libraries=geometry">
</script>
<%@include file="components/tail.jsp" %>
</body>
</html>
