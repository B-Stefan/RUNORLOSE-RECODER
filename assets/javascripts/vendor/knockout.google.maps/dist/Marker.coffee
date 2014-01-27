define ['knockout'], (ko)->
  class Marker
    constructor: (options = {})->
      @latitude = options.lat ? ko.observable(0)
      @longitude = options.lng ? ko.observable(0)
      @title = options.title ? ko.observable("")
      #@animation = options.animation ? ko.observable(google.maps.Animation.BOUNCE)
      @clickable = options.clickable ?  ko.observable(false)
      @cursor = options.cursor ? ko.observable(null)
      @icon = options.icon ? ko.observable(null)
      @raiseOnDrag = options.raiseOnDrag ?  ko.observable(true)
      @shadow = options.shadow ? ko.observable(null)
      @draggable = options.draggable ? ko.observable(false)
      @flat = options.flat  ? ko.observable(false)
      @visible = options.visible ? ko.observable(true)
      @hintVisible = ko.observable(false)
      @click = ()=> @hintVisible(not @hintVisible()) #Toggle
      @position = ko.computed(
        read: ->
          latitude: @latitude()
          longitude: @longitude()

        write: (value) ->
          @latitude value.latitude
          @longitude value.longitude
        owner: this
      )