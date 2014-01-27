﻿var defaultClustererName = '$clusterer';

function getClusterer(bindings, bindingContext) {
    var name = ko.utils.unwrapObservable(bindings.clusterer) || defaultClustererName;
    return bindingContext[name];
}

ko.bindingHandlers.clusterer = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
		if (bindingContext.$map === undefined) {
			throw 'marker binding must be used only inside the scope of a map binding.';
		}

		var bindings = ko.utils.unwrapObservable(valueAccessor());

		var options = {};
		for (var property in ko.bindingHandlers.clusterer.binders) {
			var binder = ko.bindingHandlers.clusterer.binders[property];
			if (binder.onBuildOptions) {
				binder.onBuildOptions(bindingContext, bindings, options, ko);
			}
		}

		var clusterer = new MarkerClusterer(bindingContext.$map, [], options);
		for (var property in ko.bindingHandlers.clusterer.binders) {
			var binder = ko.bindingHandlers.clusterer.binders[property];
			if (binder.onCreated) {
				binder.onCreated(bindingContext, bindings, clusterer, ko);
			}
		}

		var name = ko.utils.unwrapObservable(bindings.name) || defaultClustererName;

		var extension = {};
		extension[name] = clusterer;
		var innerBindingContext = bindingContext.extend(extension);
		ko.applyBindingsToDescendants(innerBindingContext, element);

		return { controlsDescendantBindings: true };
	},
	binders: {
		gridSize: {
			onBuildOptions: function (bindingContext, bindings, options, ko) {
				ko.google.maps.utils.assignBindingToOptions(bindings, 'gridSize', options, null);
			},
			onCreated: function (bindingContext, bindings, clusterer, ko) {
			    ko.google.maps.utils.tryObserveBindingForSetter(bindings, 'gridSize', clusterer, 'setGridSize');
			}
		},
		maxZoom: {
			onBuildOptions: function (bindingContext, bindings, options, ko) {
				ko.google.maps.utils.assignBindingToOptions(bindings, 'maxZoom', options, null);
			},
			onCreated: function (bindingContext, bindings, clusterer, ko) {
			    ko.google.maps.utils.tryObserveBindingForSetter(bindings, 'maxZoom', clusterer, 'setMaxZoom');
			}
		},
		styles: {
			onBuildOptions: function (bindingContext, bindings, options, ko) {
				ko.google.maps.utils.assignBindingToOptions(bindings, 'styles', options, null);
			},
			onCreated: function (bindingContext, bindings, clusterer, ko) {
				if (ko.isObservable(bindings.styles)) {
					bindings.styles.subscribe(function () {
						clusterer.setStyles(bindings.styles());
						clusterer.resetViewport();
						clusterer.redraw();
					});
				}
			}
		}
	}
};
ko.virtualElements.allowedBindings.clusterer = true;

ko.bindingHandlers.marker.binders.clusterer = {
	onCreated: function (bindingContext, bindings, marker, ko) {
	    var clusterer = getClusterer(bindings, bindingContext);
	    if (clusterer) {
	        clusterer.addMarker(marker);
		}
	},
	onRemoved: function (bindingContext, bindings, viewModel, marker, ko) {
	    var clusterer = getClusterer(bindings, bindingContext);
	    if (clusterer) {
	        clusterer.removeMarker(marker);
		}
	}
};