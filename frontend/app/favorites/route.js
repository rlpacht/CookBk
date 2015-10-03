import Ember from 'ember';

const FavoritesRoute = Ember.Route.extend({

  model() {
    return this.store.findAll('userFavorite');
  }
});

export default FavoritesRoute;
