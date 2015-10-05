import Ember from 'ember';

const ApplicationController = Ember.Controller.extend({
// TODO: can all of this be removed?
  actions: {
    signOut() {
      $.ajax({
        url: "/sessions",
        type: "DELETE",
         headers: {
            "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
          }
      });
    }
  }
});

export default ApplicationController;