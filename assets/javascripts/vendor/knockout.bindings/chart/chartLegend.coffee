###
Bootstrap resize event 

###
define ["require", 'knockout', "lib-chartLegend"], (require, ko,legend) ->

  ko.bindingHandlers.chartLegend =
    init: (element, valueAccessor, allBindingsAccessor) ->
      settings = valueAccessor()
      allBindings = allBindingsAccessor()
      data = ko.utils.unwrapObservable(settings.data) ? throw Error("please paas data")
      options = ko.utils.unwrapObservable(settings.options) ? {}

      legend(element, data);

    update: (element, valueAccessor, allBindingsAccessor, viewModel) ->
      settings = valueAccessor()
      allBindings = allBindingsAccessor()
      data = ko.utils.unwrapObservable(settings.data) ? throw Error("please paas data")
      options = ko.utils.unwrapObservable(settings.options) ? {}
      $(element).html("")
      legend(element, data);

