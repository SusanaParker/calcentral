'use strict';

angular
  .module('calcentral.filters')
  .filter('dateInYearFilter', function(dateService, $filter) {
    return function(millisecondsEpoch, currentYearFormat, otherYearFormat) {
      var isCurrentYear =
        dateService.format(dateService.now, 'yyyy') ===
        dateService.format(millisecondsEpoch, 'yyyy');
      var standardDateFilter = $filter('date');
      currentYearFormat = currentYearFormat || 'MM/dd';
      otherYearFormat = otherYearFormat || 'MM/dd/yyyy';

      if (isCurrentYear) {
        return standardDateFilter(millisecondsEpoch, currentYearFormat);
      } else {
        return standardDateFilter(millisecondsEpoch, otherYearFormat);
      }
    };
  });
