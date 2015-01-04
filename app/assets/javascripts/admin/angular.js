ready = function() {
  var uploadApp = angular.module('FileUploader', ['angularFileUpload']);

  uploadApp.controller('UploadController', [ '$scope', '$upload', '$http', function($scope, $upload, $http) {

    $scope.image  = {};
    $scope.images = [];
    $scope.term   = "";
    $scope.page   = 1;
    $scope.total  = 1;
    $scope.next   = "";
    $scope.previous = "";
    $scope.show_gallery = "";

    loadImage = function(upload_id) {
      $http.get('/admin/uploads/' + upload_id + '.json').success(function(data) {
        $scope.image = data;
      });
    }

    loadImages = function(url) {
      $http.get(url).success(function(data, status, headers, config) {
        $scope.images   = data;
        $scope.page     = headers("X-Pagination-Page");
        $scope.total    = headers("X-Pagination-Total");
        $scope.next     = headers("X-Pagination-Next");
        $scope.previous = headers("X-Pagination-Previous");
      });
    }

    // Called from view to init the image
    $scope.initImage = function (upload_id) {
      loadImage(upload_id);
    }

    // Called after file is selected
    $scope.upload = function(files) {

      for (var i = 0; i < files.length; i++) {

        var file = files[i];

        $scope.upload = $upload.upload({
          url: '/admin/uploads.json',
          fileFormDataName: "upload[file]",
          file: file
        }).success(function(data, status, headers, config) {
          $scope.image = data;
          $scope.images.push(data);
        });

      }

    };

    $scope.performSearch = function() {
      loadImages('/admin/uploads.json?page=' + $scope.page + '&term=' + $scope.term);
    }

    $scope.nextPage = function() {
      loadImages($scope.next);
    }

    $scope.previousPage = function() {
      loadImages($scope.previous);
    }

    $scope.selectImage = function(upload_id) {
      loadImage(upload_id);
    }

    $scope.showGallery = function() {
      $scope.show_gallery = "yes";
    }

    $scope.hideGallery = function() {
      $scope.show_gallery = "";
    }

    $scope.performSearch();

  }]);

  angular.bootstrap("body", ['FileUploader']);
};

$(document).ready(ready);
$(document).on('page:load', ready);