define ['knockout', 'googlemaps-Marker'], (ko, Marker)->
  class PositionData

    #@param: {int} playerId
    #@param: {int} timestamp - stamp in ms
    #@param: {float} lat
    #@param: {float} lng
    constructor: (player,options = {})->

      @lat = ko.observable(options.lat ? 0)
      @lng = ko.observable(options.lng ? 0)
      @player = player
      @title = player.name
      @timestamp = ko.observable(options.timestamp ? 0)
      @_marker = null
      @icon = ko.observable('http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=•|'+@player.color().replace("#",''))

    #@returns {Marker}
    getMarker: ()=>
      if(@_marker != null) then return @_marker
      else
        @_marker = new Marker(@)
        return @_marker

    toJson: ()=>
      obj = {
        lat: @lat()
        lng: @lng()
        timestamp: @timestamp()
      }

