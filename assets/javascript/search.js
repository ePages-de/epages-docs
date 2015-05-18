(function (ko) {
  'use strict';

  var _searchPayload = function (query, chapter) {
    return {
      query: {
        bool: {
          must: [
            {
              match_phrase_prefix: {
                content: {
                  query: query,
                  slop: 10
                }
              }
            },
            {
              match_phrase_prefix: {
                url: {
                  query: '/' + chapter
                }
              }
            }
          ]
        }
      },
      highlight: {
        fields: {
          content: {}
        }
      }
    };
  };

  var _searchRequest = function (searchUrl, query, chapter, callback) {
    if (!query) {
      callback(null, {
        hits: {
          hits: []
        }
      });
      return;
    }

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
      if (xhr.readyState == 4) {
        switch (xhr.status) {
          case 200:
            callback(null, JSON.parse(xhr.response));
            break;
          default:
            callback(new Error('Unknown error'), null);
            break;
        }
      }
    };

    xhr.open('POST', searchUrl, true);
    xhr.setRequestHeader('Accept', 'application/json');
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify(_searchPayload(query, chapter)));
  };

  var SearchViewModel = function (searchUrl, query, chapter) {
    this.query = ko.observable(query || '');
    this.results = ko.observableArray([]);
    this.error = ko.observable(null);

    this.search = function (query) {
      _searchRequest(searchUrl, query, chapter, function (err, res) {
        if (!err) {
          this.results(res.hits.hits);
          this.error(null)
        } else {
          this.results([]);
          this.error(err.message);
        }
      }.bind(this));
    };

    this.query.subscribe(this.search.bind(this));
    this.search(this.query());
  };

  window.SearchViewModel = SearchViewModel;
})(ko);
