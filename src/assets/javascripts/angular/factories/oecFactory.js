'use strict';

/**
 * OEC Factory - Interface for 'OEC Control Panel' API endpoints
 */
angular.module('calcentral.factories').factory('oecFactory', function($http) {
  var getOecTasks = function() {
    return $http.get('/api/oec/tasks');
  };

  var oecTaskStatus = function(oecTaskId) {
    return $http.get('/api/oec/tasks/status/' + oecTaskId);
  };

  var runOecTask = function(taskName, parameters) {
    return $http.post('/api/oec/tasks/' + taskName, parameters);
  };

  return {
    getOecTasks: getOecTasks,
    oecTaskStatus: oecTaskStatus,
    runOecTask: runOecTask
  };
});
