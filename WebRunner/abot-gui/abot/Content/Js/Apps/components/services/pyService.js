'use strict';

define(['app'], function (app) {

    var injectParams = ['$http', '$rootScope', 'AppConfig' ];

    var pyFactory = function ($http, $rootScope, AppConfig ){

        var pyFactory = {};
        var SERVER_ADDRESS = 'http://' + window.location.hostname + ':' + AppConfig.port;
        var SERVER_API = SERVER_ADDRESS + '/abot/api/v5/';
        
        pyFactory.GetLandingPageFile = function (scope, dir) {
        	var config = {headers:{'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
        	return $http.get(SERVER_API + 'artifacts/home', config)
        	.success(function (results) {
        		return results;
        	})
        	.error(function (error, status){
        		if (error != null)
        			getLandingPageFileEvent(null, status + " : " + error.Message, scope);
        		else
        			getLandingPageFileEvent(null, null, scope);       
        	});
        };
        
        function getLandingPageFileEvent(response, error, scope) {
        	alert('error');
            //scope.$broadcast('OnGetLandingPageFile', response, error);
        };
        
        // GET artifacts tree
        pyFactory.GetArtifactTreeView = function(dir, typeId){
        	var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
        	return $http.get(SERVER_API + 'artifacts', config).success(
        			function(results){
        				return results;
        			})
        			.error(
        					function(error, status){
        						if (error!=null){
        							getArtifactTreeViewEvent(null, status + ":" + error.Message);
        						}
        						else{
        							getArtifactTreeViewEvent(null, null); 
        						}
        					});
        };
        function getArtifactTreeViewEvent(response, error) {
        	alert('error');
            //$rootScope.$broadcast('OnGetArtifactTreeViewEvent', response, error);
        };

        pyFactory.GetFeatureFileView = function(path){
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'feature_files', config).success(
                function(results){
                    return results;
                    getFeatureFileViewEvent(results, null);
                }).error(
                function(error, status){
                    if (error!=null)
                        getFeatureFileViewEvent(null, status + ":" + error.Message);
                    else
                        getFeatureFileViewEvent(null, null); 
                });
        };
        
        function getFeatureFileViewEvent(response, error) {
            $rootScope.$broadcast('OnGetFeatureFileViewEvent', response, error);
        };

        pyFactory.GetConfigView = function(path){
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'configs', config).success(
                function(results){
                    return results;
                    //getConfigFileViewEvent(results, null);
                }).error(
                function(error, status){
                    if (error!=null)
                        getConfigFileViewEvent(null, status + ":" + error.Message);
                    else
                        getConfigFileViewEvent(null, null); 
                });
        };
        
        function getConfigFileViewEvent(response, error) {
            $rootScope.$broadcast('OnGetConfigFileViewEvent', response, error);
        };
        
        pyFactory.GetFileContentView = function(scope,path, file_ext){
            var fileExt = file_ext;
            var config = {headers:{'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'files?path=' + path, config).success(
                function(results){
                    return results;
                    //getFileContentViewEvent(scope,results, null, fileExt);
                }).error(
                function(error, status){
                    if (error!=null)
                        getFileContentViewEvent(scope,null, status + ":" + error.Message, fileExt);
                    else
                        getFileContentViewEvent(scope,null, null, fileExt); 
                });
        };
        
        function getFileContentViewEvent(scope, response, error, fileExt) {
            if(fileExt == "feature" || fileExt == "xml"){
                scope.$broadcast('OnGetFeatureFileContentViewEvent', response, error, fileExt);
            }
            else if(fileExt == "properties"){
                scope.$broadcast('OnGetPropertiesFileContentViewEvent', response, error, fileExt);
            }
            else{
                scope.$broadcast('OnGetFileContentViewEvent', response, error, fileExt);
            }
        };
        
        pyFactory.GetFileContentEdit = function(scope, path, file_ext, fileContent){
            var data = {'content':fileContent};
            var config = {headers:{'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.post(SERVER_API + 'files?path=' + path, data, config).success(
                function(results){
                    return results;
                }).error(
                function(error, status){
                	alert('Error GetFileContentEdit()');
                });
        };
		
		pyFactory.GetArtifactFolder = function(scope, folderName){
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'artifacts/'+ folderName +'/download', config)
                .success(function(results){
                     return results;
                })
                .error(function(error, status){
                    if (error!=null)
                        getArtifactDownloadEvent(scope,null, status + ":" + error.Message);
                    else
                        getArtifactDownloadEvent(scope,null, null); 
                });
        };
        
        function getArtifactDownloadEvent(scope, response, error){
            alert('Error in getting artifacts folder');
        };
        
        pyFactory.GetReportPDF = function(scope, path){
            var config = {headers:{'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'reports?path=' + path, config).success(
                function(results){                    
                    getReportContentViewEvent(scope,results, null);
                }).error(
                function(error, status){
                    if (error!=null)
                        getReportContentViewEvent(scope,null, status + ":" + error.Message);
                    else
                        getReportContentViewEvent(scope,null, null); 
                });
        };
        
        function getReportContentViewEvent(scope, response, error){
            scope.$broadcast('OnGetReportContentViewEvent', response, error);
        };

        pyFactory.getPacketCounters = function(interval_in_ms) {
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'graph/packet_counters', config).success(
                function(results){
                    return results;
                }).error(
                function(error, status){
                    // console.log(error);
                });
        }

        pyFactory.getTransactionCounts = function(interval_in_ms) {
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'graph/transaction_counts', config).success(
                function(results){
                    return results;
                }).error(
                function(error, status){
                    // console.log(error);
                });
        }
        
        pyFactory.getProcedureCompletions = function(interval_in_ms) {
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'graph/procedure_completions', config).success(
                function(results){
                    return results;
                }).error(
                function(error, status){
                    // console.log(error);
                });
        }

        pyFactory.getUplinkDownlinkBandwidth = function(interval_in_ms) {
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.get(SERVER_API + 'graph/uplink_downlink_bandwidth', config).success(
                function(results){
                    return results;
                }).error(
                function(error, status){
                    // console.log(error);
                });
        }

        pyFactory.getExecutionStatus = function() {
            return $http.get(SERVER_API + 'execution_status').success(
                function(results){
                    return results;
                }).error(
                function(error, status){
                    console.log(error);
                });
        }

        pyFactory.executeFeatureFile = function(params){
            var data = {'params':params};            
           
            var config = {headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'}}
            return $http.post(SERVER_API + 'feature_files/execute', data, config).success(
                function(results){
                    // console.log(results);
                }).error(
                function(error, status){
                    
                });
        };

        pyFactory.getServerRestAPI = function(){
            return SERVER_API;
        }

        return pyFactory;
    };

    pyFactory.$inject = injectParams;

    app.factory('PyService', pyFactory).config(['$httpProvider', function ($httpProvider) {
        $httpProvider.defaults.headers.post['Content-Type'] = 'application/json; charset=utf-8';
        $httpProvider.defaults.timeout = 10000;
        
    }]);
});