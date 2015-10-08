import Ember from 'ember';

const FavoritesRoute = Ember.Route.extend({

  model() {
    return this.store.findAll('userFavorite');
  }

  // setupController(controller, userFavorites) {
  //   const favoritedRecipes = userFavorites.mapBy('recipe');
  //   controller.set('initialFavoritedRecipes', favoritedRecipes);
  // }
});

export default FavoritesRoute;
