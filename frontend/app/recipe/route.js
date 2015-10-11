import Ember from 'ember';

const RecipeRoute = Ember.Route.extend({

  model(params) {
    const id = params.id;
    return this.store.findRecord('recipe', id);
  },

  afterModel(recipeModel) {
    if (!recipeModel.get('isDataComplete')) {
      recipeModel.save()
    }
  }
});

export default RecipeRoute;
