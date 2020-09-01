/*
 * AJAX Request Handler Object
 */
var ajaxRequest = {
    method: 'POST',
    url: '',
    data: null,
    dataType: 'json',
    async: true,
    processData: true,
    beforeSend: null,
    complete: null,
    errorListner: function (response) {
        //alert('ERROR : ' + response.status + ' ' + response.statusText + '\n' + this.url);
        console.log('ERROR : ' + response.status + ' ' + response.statusText + '\n' + this.url);      
    },
    successListner: null,
    doRequest: function () {
        $.ajax({
            type: this.method,
            url: this.url,
            data: this.data,
            dataType: this.dataType,
            async: this.async,
            processData: this.processData,
            beforeSend: this.beforeSend,
            complete: this.complete,
            success: this.successListner,
            error: this.errorListner
        });
    },
    abortRequest: function () {
        this.url = '';
        this.data = null;
        this.method = 'POST';
        this.async = true;
        this.beforeSend = null;
        this.complete = null;
        this.successListner = null;
    },
};