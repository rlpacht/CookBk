import Ember from 'ember';

const RecipeController = Ember.Controller.extend({
  recipe: Ember.computed.alias("model"),

  displayTime: Ember.computed("recipe.time", function () {
    let seconds = this.get("recipe.time");
    const hours = Math.floor(seconds / 3600);
    seconds = seconds % 3600;
    const minutes = Math.floor(seconds / 60);
    if (hours === 0) {
      return `${minutes} minutes`;
    } else if (hours === 1) {
      return `${hours} hour and ${minutes} minutes`;
    } else {
      return `${hours} hours and ${minutes} minutes`;
    }

  }),

  ingredientsArray: Ember.computed("recipe.ingredients", function () {
    const ingredients = this.get("recipe.ingredients");
    return JSON.parse(ingredients)
  })
});

export default RecipeController;