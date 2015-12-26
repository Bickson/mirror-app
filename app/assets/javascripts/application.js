// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// $('#time_widget').ready( function(e) {
//   setTimeout(function(){
//     fetchWidgret();
//   }, 1000);
// });
$(document).ready(function(){
  fetchWidgret();
  fetchWeather();
  fetchDepatures();

});

var fetchWidgret = function(){
  $.ajax('/view/time_widget').success(function(data){
    console.log("fetching time");
    $("#time_widget").html(data);
    setTimeout( function(){
      fetchWidgret();
    }, 1000);// every sec
  });
};

var fetchWeather = function(){
  $.ajax('/view/weather_widget').success(function(data){
    console.log("fetching weather");
    $("#weather").html(data);
    setTimeout( function(){
      fetchWeather();
    }, 1800000);// every 30 min
  });
};

var fetchDepatures = function(){
  var hour = new Date().getHours();
  var timeToNext = 5000000;
  if(hour >= 8 && hour < 10){
    timeToNext = 30000; // every 30 sec
    $.ajax('/view/depature_widget').success(function(data){
      console.log("fetching depatures, next in " + timeToNext/1000 + " sec");
      $("#depatures").html(data);
    });

  }else{
    timeToNext = 60000; // every min
    console.log("Not fetching depature data until 08:00, trying again in " + timeToNext/1000 + " sec");
  }
  setTimeout( function(){
    fetchDepatures();
  }, timeToNext);
};
