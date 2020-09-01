/* 
 Created on : 10 June, 2016, 10:41:40 AM
 Author     : Joydeep
 */
require.config({
    baseUrl: 'Content/Js/Apps/',
    urlArgs: 'v=1.0.0.Alpha'
});

require(
        [
            'app',
            'config/appconfig',
            //'config/jquery-resizable',
            //Components
            'components/routes',
            //Controller
            
            'controllers/artifactsController',
            'controllers/baseController',
            'controllers/configController',
            'controllers/dashboardController',
            'controllers/dashboardTagController',
            'controllers/featurefileController',
            'controllers/headerController',
            'controllers/loginController',
            'controllers/tagController',
            'controllers/executionController',
            'controllers/graphViewController',
            //Utility
            //'components/utility/http/httpErrorInterceptor',
            //Service        
            'components/services/pyService',
            'components/services/uploader',
            'components/services/abotHttpInterceptService',
            //Filters
            //'components/filters/shortFilter',
            //'components/filters/utilityFilter',
            //Directives
            'directives/treeView',
            'directives/fileChange'
        ],
        function () {
            angular.bootstrap(document, ['app']);
        });