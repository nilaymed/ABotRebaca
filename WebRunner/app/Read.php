<?php

$ajaxRequestId = isset($_POST['requestId']) ? $_POST['requestId'] : (isset($_REQUEST['requestId']) ? $_REQUEST['requestId'] : NULL);
if ($ajaxRequestId == NULL) {
    echo json_encode('No requestId found in ajax call');
    die();
}

if ($ajaxRequestId == 'openAnalyticsUrl') {
        $filename = '/etc/rebaca-test-suite/kibana-conf';
        if (file_exists($filename)) {
          $kibanaUrl = file_get_contents($filename, FILE_USE_INCLUDE_PATH);
            if(!empty($kibanaUrl)){
                echo '<li><a href="'.$kibanaUrl.'" class="fSwitch" id="analytics" data-pageHeaderText="Analytics UI" target="_blank"><i class="fa fa-image" aria-hidden="true" ></i><span>Analytics UI</span></a></li>';
            }
        }
    die();
}elseif($ajaxRequestId == 'getABotReleaseNo'){
        $dir = dirname(__FILE__);
        $fileName = substr($dir, 0, -7);//for removing lib/app from the path
        $fileName = $fileName . 'config.yaml';
        $verStr = 'abot-ims-basic_';
        $contents = substr(strstr(file_get_contents($fileName), $verStr), strlen($verStr));
        $contents = substr($contents, 0, 5);
        echo $contents;
        die();
}elseif($ajaxRequestId == 'readTestReports' || $ajaxRequestId == 'readArtifacts') {
    $dir = isset($_POST['dir']) ? urldecode($_POST['dir']) : '';
    $root = '';
    $result = array();
    if (file_exists($root . $dir)) {
        $files = scandir($root . $dir);
        usort($files, "ABOT_Report::compare_array_timestamp");
        //rsort($files);
        $dirNamePrefixRegex = '/^/';
        $fileNamePrefixRegex = '/^/';
        if (count($files) > 2) { /* The 2 accounts for . and .. */
            // All dirs        
            foreach ($files as $file) {
                if ((preg_match($dirNamePrefixRegex, $file)) && file_exists($root . $dir . $file) && $file != '.' && $file != '..' && is_dir($root . $dir . $file)) {
                    //$result['dir'][] = $file;
                    $result[] = $file;
                }
            }
            // All files
            foreach ($files as $file) {
                if ((preg_match($fileNamePrefixRegex, $file)) && file_exists($root . $dir . $file) && $file != '.' && $file != '..' && !is_dir($root . $dir . $file)) {
                    //$result['files'][] = $file;
                    $result[] = $file;
                }
            }
        }
    }
    echo json_encode($result);
    die();
}elseif($ajaxRequestId == 'displayFileTree') {
    $_POST['dir'] = urldecode($_POST['dir']);
    $root = '';

    $dirTypeId = $_POST['typeId'];
    if (isset($dirTypeId) && (strtolower($dirTypeId) == 'artifactsfiles')) {
        $hidden_dir = array('blue', 'charts', '__macosx');
        //$visible_files = array('feature-overview.html', 'tag-overview.html');
        /* Show tag-overview and feature-overview for report-xx directory */
        $report_dir_in_post = explode('/report-', $_POST['dir']);
        if (isset($report_dir_in_post[1])) {
            $visible_files = array('feature-overview.html', 'tag-overview.html');
        }
    }
    if (file_exists($root . $_POST['dir'])) {
        $files = scandir($root . $_POST['dir']);
        if (strtolower($dirTypeId) == 'artifactsfiles') {
            usort($files, "ABOT_Report::compare_array_timestamp");
        } else {
            natcasesort($files);
        }

        $html = "";
        $dirNamePrefixRegex = '/^/';
        $fileNamePrefixRegex = '/^/';
        if (count($files) > 2) { /* The 2 accounts for . and .. */
            $html.= "<ul class=\"jqueryFileTree\" style=\"display: none;\">";
            // All dirs
            foreach ($files as $file) {
                if ((preg_match($dirNamePrefixRegex, $file)) && file_exists($root . $_POST['dir'] . $file) && $file != '.' && $file != '..' && is_dir($root . $_POST['dir'] . $file)) {
                    $hide_class = '';
                    if (isset($hidden_dir)) {
                        if (in_array(strtolower($file), $hidden_dir)) {
                            $hide_class = 'hidden';
                        } else {
                            $hide_class = '';
                        }
                    }

                    $html.= "<li class=\"directory collapsed " . $hide_class . "\"><a href=\"#\" rel=\"" . htmlentities($_POST['dir'] . $file) . "/\">" . htmlentities($file) . "</a></li>";
                }
            }
            // All files
            foreach ($files as $file) {
                if ((preg_match($fileNamePrefixRegex, $file)) && file_exists($root . $_POST['dir'] . $file) && $file != '.' && $file != '..' && !is_dir($root . $_POST['dir'] . $file)) {
                    $ext = preg_replace('/^.*\./', '', $file);
                    $hide_class = '';
                    if (isset($visible_files)) {
                        if (in_array(strtolower($file), $visible_files)) {
                            $hide_class = '';
                        } else {
                            $hide_class = 'hidden';
                        }
                    }
                    $html.= "<li class=\"file " . $hide_class . " ext_$ext\"><a href=\"#\" onclick=\"fileName()\" class=\"file-list\" rel=\"" . htmlentities($_POST['dir'] . $file) . "\">" . htmlentities($file) . "</a></li>";
                }
            }
            $html.= "</ul>";
            echo $html;
        }
    }
    exit();
}elseif($ajaxRequestId == 'getFileContent') {
    // Initialize
    $result = array(
        'file' => '',
        'mime' => '',
        'message' => '',
        'message_css' => '',
        'download' => '',
        'showDownload' => FALSE,
        'containerScroll' => TRUE,
        'content' => '',
    );


    $file = $_POST['path'];
    $file_info = new finfo(FILEINFO_MIME_TYPE);
    $mime_type = $file_info->buffer(file_get_contents($file));
    $result['file'] = $file;
    $result['mime'] = $mime_type;
    $download_html = '';
    $download_html.='<div class="">';
    $download_html.='<a class="btn-download btn btn-lg btn-primary" href="' . $file . '" target="_blank"><i class="glyphicon glyphicon-download-alt"></i> Download</a>';
    $download_html.='</div>';
    $result['download'] = $download_html;

    $supported_application = array(
        'application/xml',
        'text/x-php',
    );
    $mime = explode('/', $mime_type);
    $file_mime = $mime[0];
    if ($file_mime == 'text') {
        $html_content = '';
        $html_content.= '<object data="' . $file . '" type="' . $mime_type . '" id="fileObject" style="width:100%; height:375px;">';
        $html_content.='<embed type="' . $mime_type . '" src="' . $file . '" style="width:100%; height:375px;">';
        $html_content.='</object>';
        $result['content'] = $html_content;
        $result['containerScroll'] = FALSE;
        $result['showDownload'] = FALSE;
    } elseif (in_array($mime_type, $supported_application)) {
        $content = '';
        try {
            $content = file_get_contents($file, TRUE);
            $result['content'] = '<pre id="xml-pre">' . htmlspecialchars($content) . '</pre>';
        } catch (Exception $exc) {
            $result['message'] = $exc->getTraceAsString();
        }
        $result['containerScroll'] = TRUE;
        $result['showDownload'] = FALSE;
    } else {
        $html_content = '';
        $html_content.= '<object data="' . $file . '" type="' . $mime_type . '" id="fileObject" style="width:100%; height:375px;" class="hidden">';
        $html_content.='<embed type="' . $mime_type . '" src="' . $file . '" style="width:100%; height:375px;">';
        $html_content.='</object>';
        $result['content'] = $html_content;
        $result['containerScroll'] = FALSE;
        $result['showDownload'] = TRUE;
    }
    echo json_encode($result);
    die();
}else{
    echo json_encode('No request handler found for request id ' . $ajaxRequestId);
    die();
}

############### End of Ajax post/get request handling ###################


class ABOT_Report {

    static function compare_array_timestamp($a, $b) {
        $checkA = explode(' ', $a);
        $checkB = explode(' ', $b);
        if ($checkA[0] != '.' && $checkA[0] != '..' && $checkB[0] != '.' && $checkB[0] != '..') {
            $x = explode('-', $a);
            $ts_x = explode(' ', $x[1]);
            $tx = str_split($ts_x[0]);
            $his_x = $tx[0] . $tx[1] . ':' . $tx[2] . $tx[3] . ':' . $tx[4] . $tx[5];


            $y = explode('-', $b);
            $ts_y = explode(' ', $y[1]);
            $ty = str_split($ts_y[0]);
            $his_y = $ty[0] . $ty[1] . ':' . $ty[2] . $ty[3] . ':' . $ty[4] . $ty[5];

            $aa = strtotime($x[0] . ' ' . $his_x);
            $bb = strtotime($y[0] . ' ' . $his_y);
            return $bb - $aa;
        }
    }

}
?> 
