import DS from 'ember-data';

const UserFavorite = DS.Model.extend({
  recipe: DS.belongsTo('recipe')
});

export default UserFavorite;