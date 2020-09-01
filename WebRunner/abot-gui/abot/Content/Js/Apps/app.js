define([], function () {
    var app = angular.module('app', [
        'LocalStorageModule',
        'ui.router', // Routing 
        'oc.lazyLoad', // ocLazyLoad 
        'ui.bootstrap', // Ui Bootstrap
        /*'ui.bootstrap.contextMenu',*///UI bootstrap context menu
        'ngIdle', // Idle timer
        'dialogs.main', // Modal dialog
        'angular-growl', // Alert messages
        'angular-uuid', // UUID
        'ngAnimate',
        'ngSanitize', // ngSanitize
        'ngResource',
        'dialogs.main',
        'ngMaterial', // ngDialog

        //'elasticsearch', // ElasticSearch
        //'agGrid', // Angular-Grid
        //'ngMask', // Input Mask
        'chart.js' // Chart tool
    ]);
    var enableLog = true;
    app.run(['$rootScope', '$location', 'AppConfig', function ($rootScope, $location, AppConfig) {

        $rootScope
            .$on('$stateChangeStart',
                function (event, toState, toParams, fromState, fromParams) {
                    //console.log("State Change: transition begins!!!");
                });
        $rootScope
            .$on('$stateChangeSuccess',
                function (event, toState, toParams, fromState, fromParams) {

                });
        $rootScope
            .$on('$stateChangeError',
                function (event, toState, toParams, fromState, fromParams) {
                    //console.log("State Change: Error!");
                });
        $rootScope
            .$on('$stateNotFound',
                function (event, toState, toParams, fromState, fromParams) {
                    //console.log("State Change: State not found!");
                });
        $rootScope
            .$on('$viewContentLoading',
                function (event, viewConfig) {
                    //console.log("View Load: the view is loaded, and DOM rendered!");
                });
        $rootScope
            .$on('$viewcontentLoaded',
                function (event, viewConfig) {
                    //console.log("View Load: the view is loaded, and DOM rendered!");
                });

    }]);
    app.run(['$http',
        function ($http) {
            $http.defaults.headers.common.Accept = 'application/json';
        }
    ]);
    app.config(['growlProvider',
        function (growlProvider) {
            growlProvider.globalTimeToLive(3000);
            growlProvider.globalReversedOrder(true);
            growlProvider.globalPosition('right-center');
            growlProvider.globalDisableCountDown(true);
        }
    ]);
    return app;
});