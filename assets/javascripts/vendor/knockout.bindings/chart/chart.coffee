###
Bootstrap resize event
 
###
define ["require", 'knockout', "lib-chart"], (require, ko,Chart) ->

  ko.bindingHandlers.chart =
    init: (element, valueAccessor, allBindingsAccessor) ->
      settings = valueAccessor()
      allBindings = allBindingsAccessor()
      chartType = ko.utils.unwrapObservable(settings.typ) ? throw Error("please choose a type")
      data = ko.utils.unwrapObservable(settings.data) ? throw Error("please paas data")
      options = ko.utils.unwrapObservable(settings.options) ? {}


      ctx = element.getContext("2d");
      element.chart = new Chart(ctx)[chartType](data, options);

    update: (element, valueAccessor, allBindingsAccessor, viewModel) ->
      settings = valueAccessor()
      allBindings = allBindingsAccessor()
      chartType = ko.utils.unwrapObservable(settings.typ) ? throw Error("please choose a type")
      data = ko.utils.unwrapObservable(settings.data) ? throw Error("please paas data")
      options = ko.utils.unwrapObservable(settings.options) ? {}


      ctx = element.getContext("2d");
      element.chart = new Chart(ctx)[chartType](data, options);

