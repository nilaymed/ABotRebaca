'use strict';

define(['app'], function (app) {

    var injectParams = ['$http', '$rootScope', 'AppConfig', '$q' ];
    
    var uploadFactory = function ($http, $rootScope, AppConfig, $q ){

        var uploadFactory = {};             
        var SERVER_ADDRESS = 'http://' + window.location.hostname + ':' + AppConfig.port;
        var SERVER_API = SERVER_ADDRESS + '/abot/api/v5/';
        // var SERVER_ADDRESS = 'http://192.168.40.163:8888';
        // var SERVER_API = SERVER_ADDRESS + '/abot/api/v5/';
            uploadFactory.upload_file = function(file, path) {
                var url = SERVER_API + 'feature_files';
                var deferred = $q.defer(),
                    formdata = new FormData(),
                    xhr = new XMLHttpRequest();
                  
                formdata.append('file', file);
                formdata.append('path', path);
                var returnMsg;
                xhr.onreadystatechange = function(r) {
                    if (4 === this.readyState) {
                        if (xhr.status == 200) {
                            var response = JSON.parse(xhr.response);
                            this.returnMsg = response.result;
                            
                            $rootScope.$apply(function() {
                                deferred.resolve(xhr);  
                            });
                        } 
                        else {
                            $rootScope.$apply(function() {
                                deferred.reject(xhr);
                            });
                        }
                    }
                }
                
                xhr.open("POST", url, true);
                xhr.send(formdata);
                return deferred.promise;
            };
            return uploadFactory;
          }
   
    uploadFactory.$inject = injectParams;
    app.factory('Uploader',uploadFactory);
   
});         
