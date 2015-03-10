(function (ko) {
  'use strict';

  var _searchPayload = function (query) {
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

  var _searchRequest = function (searchUrl, query, callback) {
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
    xhr.send(JSON.stringify(_searchPayload(query)));
  };

  var SearchViewModel = function (searchUrl, query) {
    this.query = ko.observable(query || '');
    this.results = ko.observableArray([]);
    this.error = ko.observable(null);

    this.search = function (query) {
      _searchRequest(searchUrl, query, function (err, res) {
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
