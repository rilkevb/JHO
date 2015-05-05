function boardView() {
  this.lists = [];
  // What else goes here?
};

boardView.prototype.renderBoard = function(board) {
  // render the board based on data from controller (returned from call to model)
};

boardView.prototype.updateCard = function(card) {
  // update a card's information in the view
  // based on card passed in
};

function boardModel() {
  this.lists =  [];
}

boardModel.prototype.addCard = function(first_argument) {
  // body...
};

boardModel.prototype.updateCard = function(first_argument) {
  // body...
};

function cardModel() {
  this.props = {
    organizationName: "",
    organizationSummary: "",
    list_id: "",
    // etc.
  }
}

cardModel.prototype.method_name = function(first_argument) {
  // placeholder
};