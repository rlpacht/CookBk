import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('recipes', function() {});
  this.route('recipe', {path: "recipe/:id"});
  this.route('favorites', function() {});
});

export default Router;