(function ($) {
    'use strict';

    var $request = $('#apiconsole-request');
    var $response = $('#apiconsole-response');
    var $send = $('#apiconsole-send');

    var demoRequest =
        'GET / HTTP/1.1\n' +
        'Host: echo.luckymarmot.com\n';
    var demoResponse =
        'HTTP/1.1 200 OK\n' +
        'Server: nginx/1.4.6 (Ubuntu)\n' +
        'Date: Sat, 07 Feb 2015 15:11:16 GMT\n' +
        'Content-Type: application/json; charset=utf-8\n' +
        'Transfer-Encoding: chunked\n' +
        'Connection: close\n' +
        'Access-Control-Allow-Origin: *\n' +
        'Access-Control-Allow-Headers: Content-Type, X-Special-Header\n';

    $request.html(demoRequest);

    $send.on('click', function () {
        $response.html(demoResponse);
    });
})(jQuery);
