(function ($) {
    var SearchForm = function (searchUrl, $searchForm, $searchBox, $searchResults) {
        var $searchForm = $($searchForm);
        var $searchBox = $($searchBox);
        var $searchResults = $($searchResults);

        var createQueryData = function (query) {
            return {
                query: {
                    match_phrase_prefix: {
                        content: {
                            query: query,
                            slop: 10
                        }
                    }
                },
                highlight: {
                    fields: {
                        content: {}
                    }
                }
            };
        };

        var renderResults = function (data) {
            $searchResults.children().remove();
            if (data.hits.total > 0) {
                $.each(data.hits.hits, function (i, hit) {
                    link_html = '<a href="' + hit._source.url + '">' + hit._source.title + '</a> <span>(' + (hit._score * 100).toFixed(2) + ' %)</span></div>';
                    highlight_html = '';
                    $.each(hit.highlight.content, function (j, highlight) {
                        highlight_html += '<span class="search-highlight">' + highlight + '</span>';
                    });
                    $searchResults.append('<li class="search-result"><div>' + link_html + '</div><div>' + highlight_html + '</div></li>');
                });
            } else {
                $searchResults.append('<li class="no-search-result"><div>No results.</div></li>');
            }
        };

        var busy = false;
        var search = function (query) {
            if (busy == true) return;
            busy = true;

            window.setTimeout(function () {
                if (busy == false) return;
                $searchResults.children().remove();
                $searchResults.append('<li class="no-search-result"><div>Searching for "' + query + '"...</div></li>');
            }, 250);

            $.ajax({
                type: 'POST',
                url: searchUrl,
                data: JSON.stringify(createQueryData(query)),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8'
            }).done(function (data, textStatus, xhr) {
                busy = false;
                $searchResults.children().remove();
                if (data.hits.total > 0) {
                    $.each(data.hits.hits, function (i, hit) {
                        link_html = '<a href="' + hit._source.url + '">' + hit._source.title + '</a> <span>(' + (hit._score * 100).toFixed(2) + ' %)</span></div>';
                        highlight_html = '';
                        $.each(hit.highlight.content, function (j, highlight) {
                            highlight_html += '<span class="search-highlight">' + highlight + '</span>';
                        });
                        $searchResults.append('<li class="search-result"><div>' + link_html + '</div><div>' + highlight_html + '</div></li>');
                    });
                } else {
                    $searchResults.append('<li class="no-search-result"><div>No results for "' + query + '".</div></li>');
                }
            }).fail(function (xhr, textStatus, err) {
                busy = false;
                $searchResults.children().remove();
                $searchResults.append('<li class="no-search-result"><div>An unknown error.</div></li>');
                console.log(xhr, err);
            });
        };

        $searchForm.on('submit', function (event) {
            event.preventDefault();
            search($searchBox.val());
        });

        $searchBox.on('change keyup', function (event) {
            search($searchBox.val());
        });
    };

    window.SearchForm = SearchForm;
})(jQuery);
