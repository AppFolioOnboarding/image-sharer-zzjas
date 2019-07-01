import { observable, action } from 'mobx';

export default class FeedbackStore {
  /* Implement your feedback store*/
  @observable userName
  @observable comments;

  constructor(options = {}) {
    this.userName = options.name || '';
    this.comments = options.comments || '';
  }

  @action
  setName(name) {
    this.userName = name;
  }

  @action
  setComments(comments) {
    this.comments = comments;
  }
}
