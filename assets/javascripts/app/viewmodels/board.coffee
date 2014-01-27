define ['baseClasses/Receiver', 'knockout','linq',  'durandal/app'], (Receiver, ko,Enumerable,app)->
  class board
    constructor: (importObj = {})->
      @receiver  = new Receiver(importObj)

      @timeline = ko.computed(
        owner: @
        read: ()->
          Enumerable.Range(10000,@receiver.currentTimestamp()/10000,10000).ToArray()
      )
      @_selectedTimePrivate = ko.observable(0)
      @playTimestamp = ko.observable(0)
      @state = ko.observable('')
      @selectedTime = ko.computed(
        owner: @
        read: ()->
          if @_selectedTimePrivate() == 0
            return @receiver.currentTimestamp()
          else
            return @_selectedTimePrivate()
        write: (val)->
          @_selectedTimePrivate(val)

      )
      window.test = @
    playRecord:()=>
      @state('PLAY')
      @receiver.stopRecord()
      self = @
      positions = []
      for pl in @receiver.players()
        positions = positions.concat(pl.positions())
      arr = Enumerable.From(positions)
      .Where((x)-> x.timestamp() > self.playTimestamp())
      .GroupBy((x)-> x.timestamp())
      .OrderBy((x)->x.Key())
      .ToArray()
      i = 0
      @intVal = setInterval(()->
        if i == arr.length
          self.pauseRecord()
          return
        else
          item = arr[i]
          console.log(item)
          self.selectedTime(item.Key())
          i +=1
      ,500)

    toggleRecord: ()=>
        @state('')
        if @receiver.state() == Receiver.state.RECORD
          @receiver.stopRecord()
        else
          @receiver.startRecord()
    pauseRecord: ()=>
      clearInterval(@intVal)
      @state('')
    export: ()=>
      app.showMessage(JSON.stringify(@receiver.toJson()))

    activate: ()=>
      console.log("activate")
