define ['knockout'],(ko)->
  class CoinData
    constructor: (@player,data = {})->
      @coins = ko.observable(data.coins ? 0)
      @timestamp = ko.observable(data.timestamp ? 0)
    toJson: ()=>
      obj = {
        coins: @coins()
        timestamp: @timestamp()
      }