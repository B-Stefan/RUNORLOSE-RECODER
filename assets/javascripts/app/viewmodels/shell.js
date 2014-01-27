define(['plugins/router', 'durandal/app'], function (router, app) {
    return {
        router: router,
        search: function() {
            //It's really easy to show a message box.
            //You can add custom options too. Also, it returns a promise for the user's response.
            app.showMessage('Search not yet implemented...');
        },
        activate: function () {
            router.map([
                { route: '', title:'Schnoor-Karte', moduleId: 'viewmodels/board', nav: true },
                { route: 'Beispiel-Aufnahme', title:'Beispiel-Aufnahme', moduleId: 'viewmodels/exampleBoard',view: 'views/board', nav: true }
            ]).buildNavigationModel();
            
            return router.activate();
        }
    };
});