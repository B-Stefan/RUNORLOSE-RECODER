define ["viewmodels/board", "text!example.json", "introJs"], (BoardViewModel, importJson,introJs)->

  class exampleBoard extends BoardViewModel
    constructor: ()->
      super(JSON.parse(importJson))
      @receiver.unsubscribe()
      window.example = @

    compositionComplete: ()=>introJs().start()




