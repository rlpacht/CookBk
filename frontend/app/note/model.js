import DS from 'ember-data';

const NoteModel = DS.Model.extend({
  text: DS.attr("string"),
  recipe: DS.belongsTo("recipe", {async: true})
});

export default NoteModel;