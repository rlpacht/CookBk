import Ember from 'ember';

const RecipesController = Ember.Controller.extend({
  queryParams: ['searchText', 'currentPage'],

  searchText: null,

  isLoading: true,

  isRecipesEmpty: Ember.computed.empty('recipes'),

  recipes: [],

  userFavorites: [],

  favoritedRecipes: Ember.computed.mapBy('userFavorites', 'recipe'),

  currentPage: 1,

  numPages: Ember.computed('totalMatches', 'resultsPerPage', function() {
    return Math.floor(this.get('totalMatches') / this.get('resultsPerPage')) + 1;
  }),

  _searchHelper() {
    this.set('isLoading', true);
    const query = {search: this.get('searchText'), currentPage: this.get('currentPage')};
    this.store.find('recipe', {query: query}).then( (searchedRecipeModels) => {
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
    }
  }
});

export default RecipesController;