import { post } from '../utils/helper';

export default class PostFeedbackService {
  submitFeedback(form, wdn = window) {
    const path = `${wdn.location.origin}/api/feedbacks`;
    return post(path, form);
  }
}
