import DS from 'ember-data';

const RecipeModel = DS.Model.extend({
  name: DS.attr('string'),
  yummlyId: DS.attr('string'),
  time: DS.attr('number'),
  sourceUrl: DS.attr('string'),
  numberOfServings: DS.attr('number'),
  smallImgUrl: DS.attr('string'),
  largeImgUrl: DS.attr('string'),
  mediumImgUrl: DS.attr('string'),
  ingredients: DS.attr('string'),
  notes: DS.hasMany('note', {async: true})
});

export default RecipeModel;