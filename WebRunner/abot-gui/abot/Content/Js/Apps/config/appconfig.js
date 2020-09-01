'use strict';

define(['app', 'module'], function (app, module) {
    app.constant("AppConfig", {
        "cacheBustSuffix": module.uri.split("?v=").pop(),
        //DesktopApp
        "templatePath": "Content/Js/Apps/templates/",
        "localUrl": "Content/Js/Apps/local_storage/",
        "defaultIconPath": "Content/Images/",
        //ElasticSearch Host
        "serverUrl":"http://ABOT_IP_ADDRESS:5000/",
        "port":"5000",
        "host":"192.168.40.101",
        "pathToData":"../",
        "serviceUrl": "",
        "redirectUrl": "",
    });
    app.run(['AppConfig', '$rootScope', '$state', '$stateParams', '$sce', function (AppConfig, $rootScope, $state, $stateParams, $sce) {
            $rootScope.footer_content = AppConfig.footer_copyright;
            $rootScope.version = AppConfig.cacheBustSuffix; //AppConfig.cacheBustSuffix.substring(0, 3);
            $rootScope.serverUrl = "http://" + window.location.hostname + ":" + AppConfig.port + "/";
        }]);
});