//intercept all http traffic 
(function () {
	'use strict';
	angular.module('app').factory('ABOT_HTTP_interceptService', rcaHttpInterceptService);

	rcaHttpInterceptService.$inject = ['$q', '$rootScope', 'AppConfig', '$timeout'];
	function rcaHttpInterceptService($q, $rootScope, AppConfig, $timeout) {
		var _rscope = $rootScope;
		var appconf = AppConfig;
		return {
			request: function(config) {
				// console.log('request', config);
				if(config.url.includes('graph/') == false) {
					$("#loadingDiv").css('height', Math.max($(document).height(), $(window).height()));
	            	$("#loadingDiv").show();
				}
				//$("#loadingDiv").show();
				return config;
			},

			requestError: function(config) {
				if(config.url.includes('graph/') == false) {
					$("#loadingDiv").hide();
				}
				return config;
			},

			response: function(res) {
				$("#loadingDiv").hide();
				return res;
			},

			responseError: function(res) {
				//console.log('responseError', res);
				$("#loadingDiv").hide();
				if (res.status == -1) {
					
				} else if (res.status == 401) {
					
				} else if (res.status == 500) {
					
				} else {
					
				}
				return res;
			}
		}
	}
	 angular.module('app').config(function ($httpProvider) {
        $httpProvider.interceptors.push('ABOT_HTTP_interceptService');
    });

})();