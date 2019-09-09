'use strict';

angular.module('calcentral.services').service('authService', function($http, $route, $timeout) {
  /*
   * Check whether the current user is logged in or not
   * If they aren't AND they aren't on a public page, redirect them to login.
   */
  var isLoggedInRedirect = function() {
    // We need a $timeout since we need to wait for the DOM to be ready
    // otherwise the back button doesn't trigger a new response
    $timeout(function() {
      $http.get('/api/my/am_i_logged_in').then(
        function successCallback(response) {
          if (response.data && !response.data.amILoggedIn && $route && $route.current && !$route.current.isPublic) {
            window.location = '/auth/cas';
          }
        }
      );
    }, 0);
  };

  return {
    isLoggedInRedirect: isLoggedInRedirect
  };
});
