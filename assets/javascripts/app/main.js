requirejs.config({
    paths: {
        'text': '../vendor/requirejs-text/text',
        'knockout': '../vendor/knockout.js/knockout',
        'jquery': '../vendor/jquery/jquery',
        'bootstrap': '../vendor/bootstrap/bootstrap',
        'durandal':'../vendor/durandal',
        'plugins' : '../vendor/durandal/plugins',
        'transitions' : '../vendor/durandal/transitions',
        'pusher': '../vendor/pusher/pusher',
        'moment': '../vendor/moment/moment',
        "knockout-google-maps": "../vendor/knockout.google.maps/dist/knockout.google.maps-0.1.0.debug",
        'googlemaps-Marker': "../vendor/knockout.google.maps/dist/Marker",
        markerclusterer: "../vendor/knockout.google.maps/dist/markerclusterer",
        infobubble: "../vendor/knockout.google.maps/dist/infobubble",
        linq: "../vendor/linq.js/linq",
        introJs:  "../vendor/intro.js/intro.min",
        "ko-chart":  "../vendor/knockout.bindings/chart/chart",
        "ko-chartLegend":  "../vendor/knockout.bindings/chart/chartLegend",
        "lib-chart":  "../vendor/knockout.bindings/chart/Chartjs/Chart",
        "lib-chartLegend":  "../vendor/knockout.bindings/chart/ChartJsLegend/src/legend"
    },
    shim: {
        'bootstrap': {
            deps: ['jquery'],
            exports: 'jQuery'
        },
        'pusher': {
            exports: 'Pusher'
        },
        'linq': {
            deps: ['jquery'],
            exports: 'Enumerable'
        },
        'introJs': {
            exports: 'introJs'
        },
        'lib-chartLegend': {
            exports: 'legend'
        },
        'lib-chart': {
            exports: "Chart"
        }
    }
});

define(function(require) {
    var app = require('durandal/app'),
        viewLocator = require('durandal/viewLocator'),
        system = require('durandal/system');

    //>>excludeStart("build", true);
    system.debug(true);
    //>>excludeEnd("build");

    app.title = 'Durandal Starter Kit';

    app.configurePlugins({
        router:true,
        dialog: true,
        widget: true
    });

    app.start().then(function() {
        //Replace 'viewmodels' in the moduleId with 'views' to locate the view.
        //Look for partial views in a 'views' folder in the root.
        viewLocator.useConvention();

        //Show the app by setting the root view model for our application with a transition.
        app.setRoot('viewmodels/shell', 'entrance');
    });
});