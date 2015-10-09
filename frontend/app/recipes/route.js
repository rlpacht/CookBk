import Ember from 'ember';

const RecipesRoute = Ember.Route.extend({

  model(params) {
    const searchText = params.searchText;
    const currentPage = params.currentPage || 1;
    const query = {search: searchText, currentPage: currentPage};
    var recipes = this.store.findQuery('recipe', { query: query });

    const hash = {
      recipes: recipes,
      userFavorites: this.store.findAll('userFavorite')
    }

    return Ember.RSVP.hash(hash);
  },

  setupController(controller, model) {
    this._super(controller, model);
    controller.set('recipes', model.recipes);
    controller.set('userFavorites', model.userFavorites);
    const metadata = this.store.metadataFor('recipe');
    controller.set('totalMatches', metadata.total_matches);
    controller.set('resultsPerPage', metadata.results_per_page);
    controller.set('isLoading', false);
  }
});

export default RecipesRoute;
