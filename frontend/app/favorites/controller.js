import Ember from 'ember';

const FavoritesController = Ember.Controller.extend({
  favoritedRecipes: Ember.computed.mapBy('userFavorites', 'recipe'),

  initialFavoritedRecipes: null,

  userFavorites: Ember.computed.alias('model'),

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