import Immutable from 'seamless-immutable';

// The initial state of the App
const initialState = Immutable({
  entity: {},
});

function entityListReducer(state = initialState, action) {
  switch (action.type) {
    default:
      return state;
  }
}

export default entityListReducer;
