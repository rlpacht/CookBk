import Ember from 'ember';

const ApplicationController = Ember.Controller.extend({

  actions: {
    signOut() {
      $.ajax({
        url: "/sessions",
        type: "DELETE",
         headers: {
            "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
          }//, success: ()=> {
          //   debugger
          // }, error: () => {
          //  $.ajax({
          //     url: "/sessions/new",
          //     type: "GET",
          //     headers: {
          //       "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
          //     }, success: ()=> {
          //       debugger
          //     }
          //  });
          // }
      });
    }
  }
});

export default ApplicationController;