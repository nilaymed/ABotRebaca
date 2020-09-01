/* 
 Created on : 14 March, 2017, 10:31:40 AM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {
	
    var injectParams = ['$scope', '$state', '$rootScope', '$timeout', '$interval', 'dialogs', '$mdDialog', 'AppConfig', 'growl', '$sce', 'uuid', 'PyService'];
    var tagController = function ($scope, $state, $rootScope, $timeout, $interval, dialogs, $mdDialog, AppConfig, growl,  $sce, uuid, PyService) {
        
    	$scope.init = function() {
     	   alert('Tag init')
        }
    	
    
    };
    tagController.$inject = injectParams;
    app.controller('TagCtrl', tagController);
    
});
