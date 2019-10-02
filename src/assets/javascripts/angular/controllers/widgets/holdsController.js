'use strict';

var _ = require('lodash');

/**
 * Holds controller
 */
angular.module('calcentral.controllers').controller('HoldsController', function(holdsFactory, $scope) {
  $scope.holdsInfo = {
    isLoading: true
  };

  var loadHolds = function() {
    return holdsFactory.getHolds().then(function(response) {
      $scope.holds = _.get(response, 'data.feed.holds').map(hold => {
        if (hold.contact && hold.contact.description === ' ') {
          return { ...hold, contact: { ...hold.contact, description: '' } };
        }

        return hold;
      });
    }).finally(function() {
      $scope.holdsInfo.isLoading = false;
    });
  };

  loadHolds();
});
