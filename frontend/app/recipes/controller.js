import Ember from 'ember';

const RecipesController = Ember.Controller.extend({
  queryParams: ['searchText', 'currentPage', 'maxRecipeTime'],

  searchText: null,

  isLoading: true,

  isRecipesEmpty: Ember.computed.empty('recipes'),

  recipes: [],

  userFavorites: [],

  favoritedRecipes: Ember.computed.mapBy('userFavorites', 'recipe'),

  currentPage: 1,

  timeSliderValue: 10,

  // Map from equally spaced slider increments to non-equally spaced
  // number of minutes
  timeValueToMinutesHash: {
    1: 5,
    2: 10,
    3: 20,
    4: 30,
    5: 45,
    6: 60,
    7: 120,
    8: 240,
    9: 360,
    10: 480
  },

  minutesToTimeValueHash: {
    5: 1,
    10: 2,
    20: 3,
    30: 4,
    45: 5,
    60: 6,
    120: 7,
    240: 8,
    360: 9,
    480: 10
  },

  maxRecipeTime: Ember.computed('timeSliderValue', 'timeValueToMinutesHash', function(key, value) {
    if (arguments.length > 1) {
      // setter
      const minutesToTimeValueHash = this.get('minutesToTimeValueHash');
      this.set('timeSliderValue', minutesToTimeValueHash[value]);
      return value;
    } else {
      // getter
      const valueToMinutesHash = this.get('timeValueToMinutesHash');
      const timeSliderValue = this.get('timeSliderValue');
      return valueToMinutesHash[timeSliderValue];
    }

  }),

  formattedMaxRecipeTime: Ember.computed('maxRecipeTime', function() {
    const minutesSelected = this.get('maxRecipeTime');
    if (minutesSelected < 60) {
      return `${minutesSelected} minutes or less`;
    }
    else if (minutesSelected >= 480) {
      return "Any Time";
    } else {
      const numHours = Math.floor(minutesSelected / 60);
      const hourOrHours = (numHours === 1 ? 'hour' : 'hours');
      return `${numHours} ${hourOrHours} or less`;
    }
  }),

  numPages: Ember.computed('totalMatches', 'resultsPerPage', function() {
    return Math.floor(this.get('totalMatches') / this.get('resultsPerPage')) + 1;
  }),

  _searchHelper() {
    this.set('isLoading', true);
    const query = {
      search: this.get('searchText'),
      currentPage: this.get('currentPage'),
      maxRecipeTime: this.get('maxRecipeTime')
    };
    this.store.findQuery('recipe', {query: query}).then( (searchedRecipeModels) => {
      this.set('recipes', searchedRecipeModels);
      const metadata = this.store.metadataFor('recipe');
      this.set('totalMatches', metadata.total_matches);
      this.set('resultsPerPage', metadata.results_per_page);
      this.set('isLoading', false);
    });
  },

  actions: {
    searchRecipes() {
      this.set('currentPage', 1);
      // Reset maxRecipeTime to the max, which signifies the "Any Time" state
      this.set('maxRecipeTime', 480);
      this._searchHelper();
    },

    pageNumChanged() {
      this._searchHelper();
    },

    addToFavorites(recipe) {
      const newFave = this.store.createRecord('userFavorite', {recipe: recipe});
      newFave.save();
    },

    removeFromFavorites(recipe) {
      const unFaved = this.store.peekAll('userFavorite').findBy('recipe', recipe);
      unFaved.destroyRecord();
    },

    maxTimeChanged(newTime) {
      this.set('currentPage', 1);
      this._searchHelper();
    }
  }
});

export default RecipesController;