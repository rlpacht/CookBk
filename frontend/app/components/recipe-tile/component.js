import Ember from 'ember';

const RecipeTileComponent  = Ember.Component.extend({
  classNames: ['recipe-result', 'thumbnail'],

  classNameBindings: ['favoritesPage:fave-tile:search-tile'],

  recipe: null,

  faves: null,

  favoritesPage: null,

  isFavorite: Ember.computed('recipe', 'faves.[]', function() {
    const faves = this.get('faves');
    const recipe = this.get('recipe');
    return faves.contains(recipe);
  }),

  formattedRecipeName: Ember.computed(function() {
    var recipeName = this.get("recipe.name");
    if (recipeName.length > 36) {
      var formattedName = recipeName.slice(0,37);
      formattedName += "...";
      return formattedName;
    } else {
      return recipeName;
    }
  }),

  actions: {

    addToFavorites () {
      this.sendAction('addToFavorites', this.get('recipe'));
    },

    removeFromFavorites () {
      this.sendAction('removeFromFavorites', this.get('recipe'));
    }
  }
});
export default RecipeTileComponent;