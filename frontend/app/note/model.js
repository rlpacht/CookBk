import DS from 'ember-data';

const NoteModel = DS.Model.extend({
  text: DS.attr("string"),
  recipe: DS.belongsTo("recipe")
});

export default NoteModel;