(function ($) {
    'use strict';

    function parseUri(href) {
        var match = href.match(/^(https?\:)\/\/(([^:\/?#]*)(?:\:([0-9]+))?)((\/[^?#]*)(\?[^#]*|))(#.*|)$/);
        return match && {
            protocol: match[1],
            host: match[2],
            hostname: match[3],
            port: match[4],
            pathname: match[6],
            search: match[7],
            hash: match[8],
            pathnameAndSearch: match[5]
        }
    }

    var renderFullUri = function (raml, uriParameters, queryParameters) {
        var uri = raml.uri;
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
    }

    var convertRamlToRawRequest = function (raml, uriParameters, queryParameters) {
        var method = ramlResource.method.toUpperCase();
        var uri_full = renderFullUri(raml, uriParameters, queryParameters);
        var pathnameAndSearch = parseUri(uri_full).pathnameAndSearch;
        var host = parseUri(uri_full).host;
        var txt = method + ' ' + pathnameAndSearch + ' HTTP/1.1\n' +
            'Host: ' + host;

        return txt.replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }

    var convertXhrToRawResponse = function (xhr) {
        if (xhr.status > 0) {
            var txt = 'HTTP/1.1 ' + xhr.status + ' ' + xhr.statusText + '\n' +
                xhr.getAllResponseHeaders() + '\n' +
                xhr.responseText;

            return txt.replace(/</g, '&lt;').replace(/>/g, '&gt;');
        } else {
            return 'Could not connect to server';
        }
    }

    function apiConsole (ramlResource, $request, $response, $form) {
        var $request = $($request);
        var $response = $($response);
        var $form = $($form);
        var uriParameters = {};
        var queryParameters = {};

        ramlResource.uri_parameters.forEach(function (p) {
            uriParameters[p.name] = '';
            $form.find('#parameter-uri-' + p.name).on('change keydown', function () {
                var $input = $(this);
                window.setTimeout(function () {
                    uriParameters[p.name] = $input.val();
                    $request.html(convertRamlToRawRequest(ramlResource, uriParameters, queryParameters));
                }, 0);
            });
        });

        ramlResource.query_parameters.forEach(function (p) {
            queryParameters[p.name] = '';
            $form.find('#parameter-query-' + p.name).on('change keydown', function () {
                var $input = $(this);
                window.setTimeout(function () {
                    queryParameters[p.name] = $input.val();
                    $request.html(convertRamlToRawRequest(ramlResource, uriParameters, queryParameters));
                }, 0);
            });
        });

        $request.html(convertRamlToRawRequest(ramlResource, uriParameters, queryParameters));
        $form.on('submit', function (event) {
            event.preventDefault();

            $response.html('Loading...');
            $.ajax({
                type: ramlResource.method.toUpperCase(),
                url: renderFullUri(ramlResource, uriParameters, queryParameters)
            }).done(function (data, textStatus, xhr) {
                $response.html(convertXhrToRawResponse(xhr));
            }).fail(function (xhr, textStatus, err) {
                $response.html(convertXhrToRawResponse(xhr));
            });
        });
    }

    window.apiConsole = apiConsole;
})(jQuery);
