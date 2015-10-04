import Ember from 'ember';

const RecipeRoute = Ember.Route.extend({

  model(params) {
    const id = params.id;
    return this.store.find('recipe', id);
  },

  afterModel(recipe) {
    recipe.get('notes');
  }
});

export default RecipeRoute;
