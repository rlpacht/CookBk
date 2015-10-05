import Ember from 'ember';

const RecipeController = Ember.Controller.extend({
  recipe: Ember.computed.alias("model"),

  notes: Ember.computed.alias("recipe.notes"),

  isWritingNote: false,

  newNoteText: null,

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
    return JSON.parse(ingredients);
  }),

  actions: {
    addNewNote() {
      this.set("isWritingNote", true);
    },

    createNote() {
      this.set("isWritingNote", false);
      const newNote = this.store.createRecord("note", {
        text: this.get("newNoteText"),
        recipe: this.get("recipe")
      });
      newNote.save();
      this.set("newNoteText", "");
    }
  }
});

export default RecipeController;