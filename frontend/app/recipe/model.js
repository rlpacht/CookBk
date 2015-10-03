import DS from 'ember-data';

const RecipeModel = DS.Model.extend({
  // name: DS.attr('string')
  name: DS.attr('string'),
  yummlyId: DS.attr('string'),
  time: DS.attr('number'),
  sourceUrl: DS.attr('string'),
  numberOfServings: DS.attr('number'),
  // cuisine: DS.attr('string'),
  smallImgUrl: DS.attr('string'),
  largeImgUrl: DS.attr('string'),
  mediumImgUrl: DS.attr('string'),
  ingredients: DS.attr('string')
  // recipeNotes


  // ingredients: DS.attr('array')
});

export default RecipeModel;