angular.module('pattern', ['ngRoute'])

function PatternCtrl($scope) {
    $scope.output = "oo";
    $scope.pattern = "";
    $scope.init_val = null;
    $scope.test_text = "";

    $scope.keydown = function() {
	handle_ui_changed($scope);
    };
}


function handle_ui_changed($scope) {

    var data = $.param({
	init_val: $scope.init_val,
	pattern: $scope.pattern,
	test_text: $scope.test_text
    });
    var jqxhr = $.ajax( {
        type: "POST",
        url: "exec_pattern",
        data: data,
        success: function(data) {
            console.log( "post success", data );
            var j = $.parseJSON( data );
//	    $("#result-text").text(data);
	    $scope.output = data;
        }
    });
}


$(function() {

    $("#init-val").kendoNumericTextBox();

});

