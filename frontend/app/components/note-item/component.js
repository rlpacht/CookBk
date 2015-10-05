import Ember from 'ember';

const NoteItemComponent = Ember.Component.extend({
  note: null,

  isEditing: false,

  actions: {
    saveChanges () {
      this.get('note').save();
      this.set("isEditing", false)
    },

    editNote () {
      this.set("isEditing", true);
    },

    deleteNote() {
      this.get("note").destroyRecord();
    }
  }
});

export default NoteItemComponent;