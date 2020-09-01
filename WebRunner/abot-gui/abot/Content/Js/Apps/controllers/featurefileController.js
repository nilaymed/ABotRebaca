/* 
 Created on : 14 March, 2017, 10:31:40 AM
 Author     : Joydeep
 */
'use strict';

define(['app'], function (app) {
	
    var injectParams = ['$scope', '$state', '$rootScope', '$timeout',  'AppConfig', 'PyService', 'Uploader', 'growl'];
    var featurefileController = function ($scope, $state, $rootScope, $timeout, AppConfig, PyService, Uploader, growl) {
    	
        var temp_fileContent = "";
    	$scope.readOnlyMode = true;
    	$scope.selectedFileName = "";
    	
    	$timeout(function(){
    		$(".panel-left").resizable({
 			   handleSelector: ".splitter",
 			   resizeHeight: false
 			 });

 			 $(".panel-top").resizable({
 			   handleSelector: ".splitter-horizontal",
 			   resizeWidth: false
 			 });
 			 
 			///----------- Adjusting Panel height -----------------------------
  			$("#featureFileLeftTree").height($(window).height() - 200);
  			$("#featureFileSplitter").height($(window).height() - 165);
  			$("#featureFileContent").height($(window).height() - 165);
  			$("#featureFileView").height($(window).height() - 165);
    	},100);
    	
    	$scope.init = function() {
    		PyService.GetFeatureFileView('featureFiles/').then(function(result){
    			$scope.treedata = result.data.tree_list;
    		});
        }
    	
    	$scope.showDownLoadLink = function() {
    		return $scope.selectedFileName.includes(".");
    	}
    	
    	$scope.editFeature = function() {
    		$scope.readOnlyMode = false;
    		temp_fileContent = _.cloneDeep($scope.content);
    	}
    	
    	$scope.saveChanges = function() {
    		$scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
            PyService.GetFileContentEdit($scope, $scope.fullFilePath, 'feature', $scope.content).then(function(response){
            	growl.success("File saved successfully", {});
            	$scope.content = response.data.result.content;
            })
    		
    		$scope.readOnlyMode = true;
    	}
    	
    	$scope.cancelChanges = function() {
    		$scope.readOnlyMode = true;
    		$scope.content = _.cloneDeep(temp_fileContent);
    	}
    	
    	$scope.execute = function() {
			PyService.getExecutionStatus().then(function(response){
				if(response.data['status']['executing'] === false) {
					$state.go("app.executionView");
					angular.element("#executionView").scope().executeFeatureAndLoadConsole(_.cloneDeep($scope.selectedFileName), $scope.firstKeyword.replace("@", ""));
				} else {
					growl.success("Execution already in progress...", {});
					angular.element("#executionView").scope().updateExecutionStatus(true);
				}
			});
    	}
    	
    	$scope.isSelectedFileChanged = function() {
    		if ($scope.content !== temp_fileContent) {
    			return true;
    		} else {
    			return false;
    		}
    	}
    	
    	$scope.isExecuteDisabled = function() {
    		if ($scope.selectedFileType != "feature") {
    			return true;
    		} else if (angular.element("#executionView").scope().isFeatureFileRunning == true) {
    			return true;
    		}
    	};
    	
    	$scope.handleKeyPress = function(event) {
    		// console.log(event);
    		if (event.ctrlKey == true && event.shiftKey == true) {
    			if (event.keyCode == 6) {
    				$scope.indent();
    			}
    		}
    	};
    	
    	$scope.indent = function() {
    		if ($scope.readOnlyMode == false) {
				if ($scope.selectedFileType == "feature") {
					$scope.content = formatFeature($scope.content);
				} else if ($scope.selectedFileType == "xml") {
					$scope.content = formatXML($scope.content,"  ");
				}
			}
    	}
    	
    	function formatFeature(input) {
    		var propertiesStartIndex = -1;
    		var propertiesEndIndex = - 1;
    		var propertiesStarted = false;
    		var linesToFormat = new Array();
    		
    		var formmatedOutput = "";
    		var lines = input.split('\n');
    		// Loop through all lines
    		for (var j = 0; j < lines.length; j++) {
    		  //console.log('Line ' + j + ' is ' + lines[j]);
    		  if (lines[j].trim().startsWith("|")) {
    			  if (propertiesStarted == true) {
    				  linesToFormat.push(lines[j].trim());
    			  } else {
    				  propertiesStarted = true;
    				  propertiesStartIndex = j;
    				  linesToFormat = new Array();
    				  linesToFormat.push(lines[j].trim());
    			  }
    		  } else if (lines[j].trim().startsWith("Given") || lines[j].trim().startsWith("Then") || lines[j].trim().startsWith("When")) {
    			  lines[j] = "\t\t" + lines[j].trim();
    			  if (propertiesStarted == true) {
    				  propertiesEndIndex = j - 1;
    				  propertiesStarted = false;
    				//   console.log("Lines to process::");
    				  /// Start processing with properties line;
    				  var newLineArray = processLineContent(linesToFormat, propertiesStartIndex, propertiesEndIndex);
    				  for (var x = 0; x < newLineArray.length; x++) {
    					  lines[propertiesStartIndex + x] = newLineArray[x];
    				  }
    				  
    			  } else {
    				  
    			  }
    		  } else if (lines[j].trim().startsWith("Scenario:")) {
    			  lines[j] = "\t" + lines[j].trim();
    			  if (propertiesStarted == true) {
    				  propertiesEndIndex = j - 1;
    				  propertiesStarted = false;
    				//   console.log("Lines to process::");
    				  /// Start processing with properties line;
    				  var newLineArray = processLineContent(linesToFormat, propertiesStartIndex, propertiesEndIndex);
    				  for (var x = 0; x < newLineArray.length; x++) {
    					  lines[propertiesStartIndex + x] = newLineArray[x];
    				  }
    				  
    			  } else {
    				  
    			  }
    		  } else if(lines[j].trim().startsWith("@") || lines[j].trim().startsWith("Feature:")) {
    			  lines[j] = lines[j].trim();
    			  if (propertiesStarted == true) {
    				  propertiesEndIndex = j - 1;
    				  propertiesStarted = false;
    				//   console.log("Lines to process::");
    				  /// Start processing with properties line;
    				  var newLineArray = processLineContent(linesToFormat, propertiesStartIndex, propertiesEndIndex);
    				  for (var x = 0; x < newLineArray.length; x++) {
    					  lines[propertiesStartIndex + x] = newLineArray[x];
    				  }
    			  } else {
    				  
    			  }
    		  } else {
    			 
    		  }
    		}
    		var newLineArray = processLineContent(linesToFormat, propertiesStartIndex, propertiesEndIndex);
			  for (var x = 0; x < newLineArray.length; x++) {
				  lines[propertiesStartIndex + x] = newLineArray[x];
			  }
    		formmatedOutput = lines.join("\n");
    		return formmatedOutput;
    	};
    	
    	function processLineContent(linesToFormat, propertiesStartIndex, propertiesEndIndex) {
    		var maxlengthOfProperties = 0;
    		var maxLengthOfValue = 0;
    		var newLineArray = [];
    		var padding = "     ";
    		for (var i = 0; i < linesToFormat.length; i++ ) {
    			var lineContents = linesToFormat[i].split("|");
    			if (lineContents[1].trim().length > maxlengthOfProperties) {
    				maxlengthOfProperties = lineContents[1].trim().length;
    			}
    			if (lineContents[2].trim().length > maxLengthOfValue) {
    				maxLengthOfValue = lineContents[2].trim().length;
    			}
    		}
    		for (var i = 0; i < linesToFormat.length; i++ ) {
    			var lineContents = linesToFormat[i].split("|");
    			var newLine = "\t\t\t| " + getPaddedCharacter(maxlengthOfProperties, lineContents[1].trim()) + "| " + getPaddedCharacter(maxLengthOfValue, lineContents[2].trim()) + "|";
    			newLineArray.push(newLine);
    		}
    		return newLineArray;
    	};
    	
    	function getPaddedCharacter(maxLength, characters) {
    		var length = (maxLength + 1) - characters.length;
    		for (var i = 0; i < length; i ++) {
    			characters = characters + " ";
    		}
    		return characters;
    	}
    	
    	function formatXML(input,indent)
    	{
    	  indent = indent || '\t'; //you can set/define other ident than tabs
    	  //PART 1: Add \n where necessary
    	  var xmlString = input.replace(/^\s+|\s+$/g, '');  //trim it (just in case) {method trim() not working in IE8}
    	  xmlString = input
    	                   .replace( /(<([a-zA-Z]+\b)[^>]*>)(?!<\/\2>|[\w\s])/g, "$1\n" ) //add \n after tag if not followed by the closing tag of pair or text node
    	                   .replace( /(<\/[a-zA-Z]+[^>]*>)/g, "$1\n") //add \n after closing tag
    	                   .replace( />\s+(.+?)\s+<(?!\/)/g, ">\n$1\n<") //add \n between sets of angled brackets and text node between them
    	                   .replace( />(.+?)<([a-zA-Z])/g, ">\n$1\n<$2") //add \n between angled brackets and text node between them
    	                   .replace(/\?></, "?>\n<") //detect a header of XML
    	  var xmlArr = xmlString.split('\n');  //split it into an array (for analise each line separately)
    	  //PART 2: indent each line appropriately
    	  var tabs = '';  //store the current indentation
    	  var start = 0;  //starting line
    	  if (/^<[?]xml/.test(xmlArr[0]))  start++;  //if the first line is a header, ignore it
    	  for (var i = start; i < xmlArr.length; i++) //for each line
    	  {  
    	    var line = xmlArr[i].replace(/^\s+|\s+$/g, '');  //trim it (just in case)
    	    if (/^<[/]/.test(line))  //if the line is a closing tag
    	     {
    	      tabs = tabs.replace(indent, '');  //remove one indent from the store
    	      xmlArr[i] = tabs + line;  //add the tabs at the beginning of the line
    	     }
    	     else if (/<.*>.*<\/.*>|<.*[^>]\/>/.test(line))  //if the line contains an entire node
    	     {
    	      xmlArr[i] = tabs + line; //add the tabs at the beginning of the line
    	     }
    	     else if (/<.*>/.test(line)) //if the line starts with an opening tag and does not contain an entire node
    	     {
    	      xmlArr[i] = tabs + line;  //add the tabs at the beginning of the line
    	      tabs += indent;  //and add one indent to the store
    	     }
    	     else  //if the line contain a text node
    	     {
    	      xmlArr[i] = tabs + line;  // add the tabs at the beginning of the line
    	     }
    	  }
    	  return  xmlArr.join('\n');  //rejoin the array to a string and return it
    	}
    	
    	$scope.upload = function() {
    		var files = angular.element("#file-input")[0].files;
    		if (files == undefined || files.length == 0) {
    			return;
    		}
    		Uploader.upload_file(files[0], $scope.uploadPath).then(function(result){
    			// console.log(result);
    			if (result.returnMsg == "success") {
    				// console.log("success in uploading the file");
    				growl.success("File uploaded successfully", {});
    				$scope.init();
    			} else {
    				// console.log("fail in uploading the file");
    				growl.error("File upload failed", {});
    			}
    		});
    	}
    	
    	$scope.printParent = function($event) {
    		if ($scope.readOnlyMode==false) {
    			return;
    		}
    		
            var root = $scope;
            var currentScope = angular.element($event.target).scope();
            $scope.rootPath = [];
            
            if (currentScope == undefined || currentScope.node == undefined) {
            	return null;
            }
            
            $scope.selectedFileName = currentScope.node['label'];
            $scope.selectedFileType = $scope.selectedFileName.split('.').pop();
            
            currentScope = currentScope.$parent;
            
            
            while(currentScope.$id !== root.$id) {
                $scope.rootPath.push(currentScope.node['label']);
                currentScope = currentScope.$parent;
            }
            $scope.rootPath = $scope.rootPath.reverse().join("/");
            $scope.selectedFolder = $scope.rootPath;
            if(typeof $scope.rootPath != 'undefined' && $scope.rootPath != ""){
                var pathArray = $scope.rootPath.split('/');
                $scope.selectedFolder = '';
                pathArray.forEach(function(current_value) {
                	$scope.selectedFolder = $scope.selectedFolder + " / " + current_value;
                });
            }
            
            $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
            
            if($scope.selectedFileType == "feature"){
            	$scope.uploadPath = null;
                $scope.downloadFileName = $scope.selectedFileName;
                if($scope.execFeatureFile == "true" || ($scope.execFeatureFile == "false" && $scope.dualContainer == "true")){
                    if($scope.statusVal == "Completed"){
                        $scope.statusVal = "Idle"; 
                    }
                    $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                    PyService.GetFileContentView($scope, $scope.fullFilePath, 'feature').then(function(response){
                    	// console.log("Feature file content", response);
                    	$scope.keywords = response.data.result.keywords;
                    	$scope.firstKeyword = $scope.keywords[0];
                    	$scope.content = response.data.result.content;
                    });
                    $scope.dualContainer = "true";
                }
                else if($scope.execFeatureFile == "false" && $scope.dualContainer == "false"){
                    //console.log("137");
                    $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                    PyService.GetFileContentView($scope, $scope.fullFilePath, 'feature').then(function(response){
                    	// console.log("ExecFeature file false", response);
                    	$scope.keywords = response.data.result.keywords;
                    	$scope.firstKeyword = $scope.keywords[0];
                    	$scope.content = response.data.result.content;
                    });
                }
                else{
                    $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                    PyService.GetFileContentView($scope, $scope.fullFilePath, 'feature').then(function(response){
                    	// console.log("Response", response);
                    	$scope.keywords = response.data.result.keywords;
                    	$scope.firstKeyword = $scope.keywords[0];
                    	$scope.content = response.data.result.content;
                    });
                }
            }
            else if($scope.selectedFileType == "xml"){
            	var xml = "<root><node>  <subnode></subnode></node></root>";
            	var formattedXML = formatXML(xml);
            	// console.log("Formatted Text", formattedXML);
            	
            	
                $scope.downloadFileName = $scope.selectedFileName;
                $scope.uploadPath = null;
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
                //$('#uploadFile').css('display', 'none');
                if($scope.statusVal == "Executing..."){
                    $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                    PyService.GetFileContentView($scope, $scope.fullFilePath, 'xml').then(function(response){
                    	// console.log("Executing...", response);
                    	$scope.content = response.data.result.content;
                    });
                    $scope.execFeatureFile = "true";
                }
                else{
                    $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                    PyService.GetFileContentView($scope,$scope.fullFilePath, 'xml').then(function(response){
                    	// console.log("Not Executing...", response);
                    	$scope.content = response.data.result.content;
                    });
                }
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
            }
            else if($scope.selectedFileType == "rxf"){
            	$scope.uploadPath = null;
                $scope.downloadFileName = $scope.selectedFileName;
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
                
                $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                PyService.GetFileContentView($scope, $scope.fullFilePath, 'rxf').then(function(response){
                	// console.log("Rxf file loaded", response);
                	$scope.content = response.data.result.content;
                });
                var heightPanelbox = windowHeight - (headerHeight + pageheaderHeight + footerHeight);
                $('#rightPanel .panel-body').css('height', heightPanelbox);
                $('#xmlView').css('display','none');
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
                
            }
            else if($scope.selectedFileType == "tst"){
            	$scope.uploadPath = null;
                $scope.downloadFileName = $scope.selectedFileName;
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
                
                $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                PyService.GetFileContentView($scope, $scope.fullFilePath, 'tst').then(function(response){
                	// console.log("tst file loaded", response);
                	$scope.content = response.data.result.content;
                });
                
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
            }
            else if($scope.selectedFileType == "template"){
            	$scope.uploadPath = null;
                $scope.downloadFileName = $scope.selectedFileName;
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
                
                
                $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                PyService.GetFileContentView($scope, $scope.fullFilePath, 'template').then(function(response){
                	// console.log("template file",  response);
					$scope.content = response.data.result.content;
                });
                // var heightPanelbox = windowHeight - (headerHeight + pageheaderHeight + footerHeight);
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
			}
			else if($scope.selectedFileType == "csv"){
            	$scope.uploadPath = null;
                $scope.downloadFileName = $scope.selectedFileName;
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
                
                
                $scope.fullFilePath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                PyService.GetFileContentView($scope, $scope.fullFilePath, 'csv').then(function(response){
					// console.log("csv file",  response);
					$scope.content = response.data.result.content;
                });
                // var heightPanelbox = windowHeight - (headerHeight + pageheaderHeight + footerHeight);
                $rootScope.selectedFile = "   /   " + $scope.selectedFileName;
            }
            else{
                //console.log("270");
                var featureFolderRootPath = AppConfig.pathToData+ 'featureFiles/'+ $scope.rootPath +'/'+ $scope.selectedFileName;
                $rootScope.path = featureFolderRootPath;
                $scope.uploadPath = $rootScope.path;
            }
            
            $scope.displayPath = _.cloneDeep($scope.fullFilePath);
            $scope.displayPath = $scope.displayPath.replace("../", "/");
            if($scope.displayPath.length>=65){
                pathArray = $scope.displayPath.split(" / ");
                var pathArrayLength = pathArray.length;
                for(var index=1;index<=pathArrayLength-1;index++){
                    $scope.displayPath = '';
                    if(index == pathArrayLength-1){
                        var fileName = pathArray[pathArray.length-1];
                        if(fileName.length>65){
                            pathArray[pathArray.length-1] = "..." + fileName.slice((fileName.length-65),fileName.length);
                        }
                        $scope.displayPath = '';
                        pathArray.forEach(function(current_value){
                            $scope.displayPath = $scope.displayPath + " / " + current_value;
                        });
                        $scope.displayPath = $scope.displayPath.substring(2);
                        break;
                    }
                    if(index == 1){
                        pathArray[index]="...";
                    } else {
                        pathArray.splice(2, 1);
                    }
                    pathArray.forEach(function(current_value){
                        $scope.displayPath = $scope.displayPath + " / " + current_value;
                    });
                    $scope.displayPath = $scope.displayPath.substring(2);
                    if($scope.displayPath.length <65){
                        break;
                    }
                }
            }
            
            //landingObjectContent();
            ///$('.panel-body').scrollTop($scope.scrollPos);

           /* $rootScope.displayPath = '';
            if($rootScope.selectedFolder != undefined && $rootScope.selectedFolder != null && $rootScope.selectedFolder != ''){
                $rootScope.displayPath = $rootScope.selectedFolder;
            }
            if($rootScope.selectedFile != undefined && $rootScope.selectedFile != null && $rootScope.selectedFile != ''){
                $rootScope.displayPath = $rootScope.displayPath + $rootScope.selectedFile;
            }

            //Replace multiple spaces with one space
            $rootScope.displayPath = $rootScope.displayPath.replace(/ +(?= )/g,'');
            $rootScope.tooltipText = $rootScope.pageHeaderheading + $rootScope.displayPath;
            console.log("407--", $rootScope.displayPath, "  :  ", $rootScope.tooltipText);*/
            
            //Shorten Path if required
            /*if($rootScope.displayPath.length>=65){
                pathArray = $rootScope.displayPath.split(" / ");
                var pathArrayLength = pathArray.length;
                for(var index=1;index<=pathArrayLength-1;index++){
                    $rootScope.displayPath = '';
                    if(index == pathArrayLength-1){
                        var fileName = pathArray[pathArray.length-1];
                        if(fileName.length>65){
                            pathArray[pathArray.length-1] = "..." + fileName.slice((fileName.length-65),fileName.length);
                        }
                        $rootScope.displayPath = '';
                        pathArray.forEach(function(current_value){
                            $rootScope.displayPath = $rootScope.displayPath + " / " + current_value;
                        });
                        $rootScope.displayPath = $rootScope.displayPath.substring(2);
                        break;
                    }
                    if(index == 1){
                        pathArray[index]="...";
                    } else {
                        pathArray.splice(2, 1);
                    }
                    pathArray.forEach(function(current_value){
                        $rootScope.displayPath = $rootScope.displayPath + " / " + current_value;
                    });
                    $rootScope.displayPath = $rootScope.displayPath.substring(2);
                    if($rootScope.displayPath.length <65){
                        break;
                    }
                }
            }*/
            //console.log("440", $rootScope.displayPath);
        }
    };
    featurefileController.$inject = injectParams;
    app.controller('FeatureCtrl', featurefileController);
    
});
