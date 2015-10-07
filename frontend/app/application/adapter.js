import DS from 'ember-data';
import ActiveModelAdapter from 'active-model-adapter';

const ApplicationAdapter = ActiveModelAdapter.extend({
  headers: {
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
  },
  namespace: "api",
  coalesceFindRequests: true
});

export default ApplicationAdapter;