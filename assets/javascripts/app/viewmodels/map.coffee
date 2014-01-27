define ['knockout', 'linq', 'moment', 'knockout-google-maps'], (ko, Enumerable, moment, unused)->
  class Map
    activate: (players = ko.observableArray(), selectedTime = ko.observable(0)) =>

      @selectedTime = selectedTime
      @players = players
      @resize= ko.observable(false)
      @center = ko.observable({ latitude: 53.072916, longitude: 8.814243});
      @zoom =  ko.observable(17)
      @mapStyles = ko.observable([{featureType: "all", stylers: [
        {hue: '#3e8e8e'}
      ] }])


      @markers = ko.computed(
        owner: @
        read: ()->
          self = @
          arr = []
          for player in @players()
            val = Enumerable.From(player.positions()).OrderBy((x)->x.timestamp()).FirstOrDefault(false,
              (x)->
                  itemTime = x.timestamp()
                  selectedTime = self.selectedTime()
                  itemTime >  selectedTime and  itemTime < selectedTime + 10000
            )
            if val
              arr.push(val.getMarker())
            else
              length = player.positions().length
              if length > 0
                arr.push(player.positions()[length-1].getMarker())

          return arr
      )
    compositionComplete: ()=> @resize(not @resize()) #Toggle

