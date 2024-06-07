import Notification from '@stimulus-components/notification'




export default class extends Notification {
  connect() {
    super.connect()
    console.log('Do what you want here.')
  }
}
