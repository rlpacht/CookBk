import Ember from 'ember';

const FavoritesController = Ember.Controller.extend({

  userFavorites: Ember.computed.alias('model'),

  // favoritedRecipes is an up to date list of the favorited recipes
  // It is used to let each recipe tile know whether to show the
  // 'Fave' or 'Unfave' button
  favoritedRecipes: Ember.computed.mapBy('userFavorites', 'recipe'),

  // initialFavoritedRecipes is set in setupController and does not change
  // This ensures that recipes don't disappear from the page when they are
  // unfavorited
  initialFavoritedRecipes: null,

  isFavoritesEmpty: Ember.computed.empty('initialFavoritedRecipes'),

  actions: {
    addToFavorites(recipe) {
      const newFave = this.store.createRecord('userFavorite', {recipe: recipe});
      newFave.save();
    },

    removeFromFavorites(recipe) {
      let unFaved = this.store.peekAll('userFavorite').findBy('recipe', recipe);
      unFaved.destroyRecord();
    }
  }

});

export default FavoritesController;