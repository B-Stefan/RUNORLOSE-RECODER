define ['moment','knockout',
        'baseClasses/PositionData',
        'baseClasses/CoinData',
        'baseClasses/Player',
        'baseClasses/RealTimeCommunicationChannel'
        'linq'],
(moment,ko,PositionData,CoinData,Player,RealTimeCommunication, Enumerable) ->
  ####
  #@class
  #@desc receve all cient events
  class Receiver
    #@static
    #@desc the record types
    #@type enum
    @recordTypes:
      COIN:'COIN'
      POSITION: 'POSITION'
    @state:
      WAITING: 'WAITING'
      STOP: 'STOP'
      RECORD: 'RECORD'
    #@constuctor
    #@param: {date|string} [date=new Date()] the date of the record default: Today
    @fromJson: (data)->
      new Recorder(data)

    @toJson: (recorder)->
      players = []
      for player in recorder.players()
        players.push(player.toJson())

      obj = {
        date: recorder.date()
        currentTimestamp: recorder.currentTimestamp()
        players: players
      }
    constructor: (options = {})->
      self = @
      @date = ko.observable(moment(options.date ? moment()))
      @players = ko.observableArray()
      @currentTimestamp = ko.observable(options.currentTimestamp ? 0)
      @playerCount = ko.computed(
        owner: @
        read: ()->
          @players().length
      )
      @channel = new RealTimeCommunication("presence-recorder")
      @state = ko.observable(Receiver.state.WAITING)
      @channel.channelSubscription.done ()->
        self.channel.channel.bind("client-start", self.onStartGame)
        self.channel.channel.bind("client-record", self.onRecord)
        self.channel.channel.bind("client-end", self.onFinishGame)
        self.channel.channel.bind("pusher:member_added", self.memberAdd)
        self.channel.channel.bind("pusher:member_removed", self.memberRemove)



      #Import
      if options.players
        for player in options.players
          @players.push(new Player(player.id,player))


    memberRemove: (user)=>@players.remove((x)-> x.id()==user.id)

    memberAdd: (user)=>
      @addPlayer(new Player(user.id))
    startTimer: ()=>
      self = @
      interval = 1000
      intVal = setInterval(()->
        if self.state == Receiver.state.STOP
          clearInterval(intVal)
          return
        self.currentTimestamp(self.currentTimestamp()+interval)
      ,interval)
      @intVal = intVal

    onFinishGame: (data) =>
      stopRecord()
    onStartGame: (data) =>
      @startRecord()

    getPlayerById: (id)=> Enumerable.From(@players()).FirstOrDefault(false,(x)-> x.id()==id)

    addPlayer: (newInstance)=>
      @players.push(newInstance)
      return newInstance

    stopRecord: ()=>
      if @state()!= Receiver.state.RECORD
        clearInterval(@intVal)
        @state(Receiver.state.STOP)
    startRecord: ()=>
      if @state()!= Receiver.state.RECORD
        @startTimer()
        @state(Receiver.state.RECORD)

    toJson: ()=> Receiver.toJson(@)
    unsubscribe: ()=> @channel.unsubscribe()
    onRecord: (data)=>
      player = @getPlayerById(data.gameId)
      if !player
        if @state != Receiver.state.STARTED
          @onStartGame()
        player = @addPlayer(new Player(data.gameId))


      if data.type == Receiver.recordTypes.POSITION
        player.positions.push(new PositionData(player,
          lat: data.value.y
          lng: data.value.x
          timestamp: @currentTimestamp()
        ))

      else if  data.type == Receiver.recordTypes.COIN
        player.coins.push(new CoinData(player,
          coins: data.value.coinVal
          timestamp: @currentTimestamp()
        ))


