define ['knockout', 'baseClasses/PositionData','baseClasses/CoinData'], (ko,PositionData,CoinData)->
  class Player
    @getRandomColor: ()->
      "#" + (co = (lor) ->
        (if (lor += [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "a", "b", "c", "d", "e", "f"][Math.floor(Math.random() * 16)]) and (lor.length is 6) then lor else co(lor))
      )("")
    constructor: (id, options = {})->
      @id = ko.observable(options.id ? id)
      @color = ko.observable(options.color ? Player.getRandomColor())
      @name  = ko.observable(options.name ? id.toString())
      @positions = ko.observableArray()
      @coins =  ko.observableArray()


      #Import
      #Import
      if options.positions
        for pos in options.positions
          @positions.push(new PositionData(@,pos))

      if options.coins
        for coin in options.coins
          @coins.push(new CoinData(@,coin))



    addPosition: (posData)=>  @positions.push(posData)

    toJson: ()=>
      coins = []
      positions = []
      for coin in @coins()
        coins.push(coin.toJson())

      for position in @positions()
        positions.push(position.toJson())

      obj = {
        id: @id()
        color: @color()
        name: @name()
        coins: coins
        positions: positions
      }
