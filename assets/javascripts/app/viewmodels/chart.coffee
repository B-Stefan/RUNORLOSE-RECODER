define ['knockout','linq','moment','ko-chart','ko-chartLegend'], (ko,Enumerable,moment)->

  class chart
    constructor: ()->
    activate: (@players,@timeline)=>

      @chartData = ko.computed(
        owner: @
        read: ()->
          self = @
          arr = []
          labels = []
          for timestep in @timeline()
            labels.push(moment(timestep).format("mm:ss"))

          for player in @players()
            data = []
            for timestep in @timeline()
              val = Enumerable.From(player.coins()).OrderBy((x)->x.timestamp()).FirstOrDefault(false,
              (x)->
                itemTime = x.timestamp()
                itemTime >  timestep and  itemTime < timestep + 10000
              )
              if val
                data.push(val.coins())
              else

                coins  = player.coins()
                index = @timeline().indexOf(timestep)-1
                if data.length != 0 and index < data.length
                  data.push(data[index])
                else
                  data.push(0)

            dataset = {
              title: player.name(),
              strokeColor : player.color() ,
              fillColor: ''
              pointColor : "rgba(220,220,220,1)",
              pointStrokeColor : "#fff",
              data: data
              animation: false
              datasetFill: false
            }
            arr.push(dataset)

          return {
            labels : labels,
            datasets : arr,
            animation: false
            datasetFill: false
          }

      ).extend(throttle: 900)