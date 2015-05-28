(function ($) {
    'use strict';

    var afterChange = function (node, callback) {
        $(node).on('change keyup', function () {
            var $input = $(this);
            callback($input.val());
        });
        callback($(node).val());
    };

    var escapeHtml = function (html) {
        return html.replace(/[\u00A0-\u9999<>\&]/gim, function(i) {
          return '&#'+i.charCodeAt(0)+';';
        });
    };

    var parseUri = function (href) {
        var match = href.match(/^(https?\:)\/\/(([^:\/?#]*)(?:\:([0-9]+))?)((\/[^?#]*)(\?[^#]*|))(#.*|)$/);
        return match ? {
            protocol: match[1],
            host: match[2],
            hostname: match[3],
            port: match[4],
            pathname: match[6],
            search: match[7],
            hash: match[8],
            pathnameAndSearch: match[5]
        } : null;
    };

    var renderFullUri = function (ramlResponse, ramlMethod, uriParameters, queryParameters) {
        var uri = ramlResponse.absolute_uri;
        var firstQuery = true;

        for (var k in uriParameters) {
            uri = uri.replace('{' + k + '}', encodeURIComponent(uriParameters[k] || ''));
        }

        for (var k in queryParameters) {
            if (queryParameters[k]) {
                uri += firstQuery ? '?' : '&';
                uri += k;
                uri += '='
                uri += encodeURIComponent(queryParameters[k]);
                firstQuery = false;
            }
        }

        return uri;
    };

    var convertRamlToRawRequest = function (ramlResponse, ramlMethod, uriParameters, queryParameters, requestBody) {
        var method = ramlMethod.method;
        var uri_full = renderFullUri(ramlResponse, ramlMethod, uriParameters, queryParameters);
        var pathnameAndSearch = parseUri(uri_full).pathnameAndSearch;
        var host = parseUri(uri_full).host;
        var txt = method + ' ' + pathnameAndSearch + ' HTTP/1.1\n' +
            'Host: ' + host + '\n' +
            'Content-Type: application/json' +
            (requestBody ? '\n\n' + requestBody : '');

        return escapeHtml(txt);
    };

    var convertXhrToRawResponse = function (xhr) {
        if (xhr.status > 0) {
            var txt = 'HTTP/1.1 ' + xhr.status + ' ' + xhr.statusText + '\n' +
                xhr.getAllResponseHeaders() + '\n' +
                xhr.responseText;

            return escapeHtml(txt);
        } else {
            return 'Could not connect to server';
        }
    };

    var ApiConsole = function (ramlResource, ramlMethod, $request, $response, $form) {
        var $request = $($request);
        var $response = $($response);
        var $form = $($form);
        var uriParameters = {};
        var queryParameters = {};
        var requestBody = '';

        var rerenderRequest = function () {
          $request.html(convertRamlToRawRequest(ramlResource, ramlMethod, uriParameters, queryParameters, requestBody));
        };

        $.each(ramlResource.uri_parameters, function (name, p) {
            afterChange($form.find('#parameter-uri-' + p.name), function (val) {
                uriParameters[p.name] = val;
                rerenderRequest();
            });
        });

        $.each(ramlMethod.query_parameters, function (name, p) {
            afterChange($form.find('#parameter-query-' + p.name), function (val) {
                queryParameters[p.name] = val;
                rerenderRequest();
            });
        });

        afterChange($form.find('#request-body'), function (val) {
          requestBody = val;
          rerenderRequest();
        });

        rerenderRequest();
        $form.on('submit', function (event) {
            event.preventDefault();

            $response.html('(Loading...)');
            $.ajax({
                type: ramlMethod.method,
                url: renderFullUri(ramlResource, ramlMethod, uriParameters, queryParameters),
                data: requestBody,
                headers: {
                  'Content-Type': 'application/json'
                }
            }).done(function (data, textStatus, xhr) {
                $response.html(convertXhrToRawResponse(xhr));
            }).fail(function (xhr, textStatus, err) {
                $response.html(convertXhrToRawResponse(xhr));
            });
        });
    };

    window.ApiConsole = ApiConsole;
})(jQuery);
